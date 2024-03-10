"use client";
import { useEffect, useRef, useState } from "react";
import { io } from "socket.io-client";
import { IoIosSend } from "react-icons/io";
import { Button } from "@/components/ui/button";
import { useTranslation } from "@/i18n/client";

import type { Socket } from "socket.io-client";

const WS_BASE_URL = process.env.WS_BASE_URL;

export default function User({
  params,
}: {
  params: {
    lng: string;
  };
}) {
  const { t } = useTranslation(params.lng, "common");
  const socketRef = useRef<Socket>();

  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (!WS_BASE_URL) return;

    // Create a socket connection
    socketRef.current = io(WS_BASE_URL);

    socketRef.current?.on("hello2", (data: any) => {
      console.log("receive hello2", data);
    });

    socketRef.current?.on("exception", (error) => {
      console.error("exception", error);
    });

    socketRef.current?.on("error", (error) => {
      console.error("error", error);
    });

    socketRef.current?.on("reconnect_error", (error) => {
      console.error("reconnect_error", error);
    });

    socketRef.current?.on("reconnect_failed", (error) => {
      console.error("reconnect_failed", error);
    });

    // Clean up the socket connection on unmount
    return () => {
      socketRef.current?.disconnect();
    };
  }, []);

  const sendMessage = () => {
    // Send the message to the server
    socketRef.current?.emit("hello2", "222222", (res: any) => {
      console.log("emit hello2: ", res);
    });
  };

  return (
    <div className="flex h-auto w-full max-w-screen-xl flex-1 px-5 xl:px-0">
      <Button
        disabled={loading}
        className="inline-flex w-auto min-w-[150px] items-center justify-center overflow-hidden rounded-lg bg-blue-600 px-4 py-2.5 text-sm text-white shadow transition-colors duration-300 hover:bg-blue-500 focus:ring focus:ring-blue-300 focus:ring-opacity-80"
        onClick={sendMessage}
      >
        <IoIosSend className="h-5 w-5" />
        <span className="mx-2">Send Message</span>
      </Button>
    </div>
  );
}
