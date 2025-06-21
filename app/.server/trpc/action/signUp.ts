import { TRPCError } from "@trpc/server";
import { db } from "~/.server/db";
import { User } from "~/.server/db/schema";
import { p } from "~/.server/trpc";
import { signUpForm } from "~/common/formSchema";
import { encrypt } from "~/.server/crypto";
import { eq, sql } from "drizzle-orm";

const prepareGetUserByEmail = db
  .select()
  .from(User)
  .where(eq(User.email, sql.placeholder("email")))
  .limit(1)
  .prepare("prepareGetUserByEmail");

const prepareGetUserByName = db
  .select()
  .from(User)
  .where(eq(User.name, sql.placeholder("name")))
  .limit(1)
  .prepare("prepareGetUserByName");

export const signUp = p.unAuth
  .input(signUpForm)
  .mutation(async ({ input: { email, name, password } }) => {
    const [userByEmail] = await prepareGetUserByEmail.execute({ email });

    if (userByEmail) {
      throw new TRPCError({
        code: "BAD_REQUEST",
        message: "邮箱已被使用",
      });
    }

    const [userByName] = await prepareGetUserByName.execute({ name });

    if (userByName) {
      throw new TRPCError({
        code: "BAD_REQUEST",
        message: "昵称已被使用",
      });
    }

    await db.insert(User).values({ name, email, password: encrypt(password) });
  });
