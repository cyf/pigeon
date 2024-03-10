import axios from "@/request/axios";
import type { Result } from "@/entities/response";
import type { User } from "@/entities/user";
import type { Auth } from "@/entities/auth";

export const login = (data: Record<string, any>): Promise<Result<Auth>> => {
  return axios.post("/api/auth/login", data);
};

export const fetchUser = async (): Promise<Result<User>> => {
  return axios.get("/api/auth/profile");
};
