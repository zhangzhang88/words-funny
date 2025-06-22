export const COOKIE_MAX_AGE = 60 * 60 * 24 * 7; //7d
export const JWT_KEY = "ACCESS_TOKEN";
export const IS_PROD = import.meta.env.PROD;

// 在客户端使用动态主机名，在服务器端使用固定值
const isBrowser = typeof window !== 'undefined';
const currentOrigin = isBrowser ? window.location.origin : 'http://localhost:3001';
export const TRPC_URL = `${currentOrigin}/trpc`;
