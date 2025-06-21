import { z } from "zod";

// basic fields
export const email = z.string().email("无效的邮箱格式");

export const password = z
  .string()
  .min(8, "密码长度不能少于8位")
  .max(30, "密码长度不能多于30位");

export const keepAlive = z.boolean();

export const name = z
  .string()
  .min(3, "名字长度不能少于3位")
  .max(16, "名字长度不能多于16位");

export const comment = z
  .string()
  .min(3, "评论长度不能少于3位")
  .max(1000, "评论长度不能多于1000位");

// signInForm
export const signInForm = z.object({ email, password, keepAlive });

// signUpForm
export const signUpForm = z
  .object({ 
    email,
    password,
    password2: password,
    name
  })
  .refine((data) => data.password === data.password2, {
    message: "两次密码输入不一致",
    path: ["password2"],
  });

// updatePasswordForm
export const updatePasswordForm = z
  .object({
    email,
    password,
    password2: password,
    verifyCode: z.string().length(6, "验证码为6位数字")
  })
  .refine((data) => data.password === data.password2, {
    message: "两次密码输入不一致",
    path: ["password2"],
  });

// commentForm
export const commentForm = z.object({ comment });
