"use client";
import React, { useRef } from "react";
import { selectUser, setUserAsync } from "@/model/slices/user/slice";
import { useAppDispatch, useAppSelector } from "@/model/hooks";

export default function UserProvider({ children }: React.PropsWithChildren) {
  const dispatch = useAppDispatch();
  const user = useAppSelector(selectUser);
  const initialized = useRef(false);
  if (!user && !initialized.current) {
    initialized.current = true;
    dispatch(setUserAsync());
  }

  return children;
}
