import jwt from "jsonwebtoken";
import { JWT_KEY } from "~/common/constants";
import { Cookies } from "./cookies";
import { db } from "./db";
import { User } from "./db/schema";
import { eq, sql } from "drizzle-orm";

const prepare = db
  .select()
  .from(User)
  .where(eq(User.id, sql.placeholder("id")))
  .limit(1)
  .prepare("prepare");

export const getMyUserInfo = async (req: Request) => {
  const token = Cookies.get(req, JWT_KEY);
  if (!token) return undefined;
  try {
    const { userId } = jwt.verify(token, process.env.JWT_SECRET) as {
      userId: string;
    };
    const [user] = await prepare.execute({ id: Number(userId) });
    return user;
  } catch (error) {
    return undefined;
  }
};
