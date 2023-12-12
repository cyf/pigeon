package com.chenyifaer.homingpigeon;

import android.app.Application;
//import android.os.StrictMode;

//import com.security.mobile.util.tls12patch.Tls12Patch;

public class MainApp extends Application {
   @Override
   public void onCreate() {
      super.onCreate();

//      Tls12Patch.tls12Patch(getFilesDir());
//
//      if (com.hcaptcha.sdk.BuildConfig.DEBUG) {
//         StrictMode.setThreadPolicy(
//                 new StrictMode.ThreadPolicy.Builder()
//                         .detectAll()
//                         .penaltyLog()
//                         .build()
//         );
//         StrictMode.setVmPolicy(
//                 new StrictMode.VmPolicy.Builder()
//                         .detectAll()
//                         .penaltyLog()
//                         .build()
//         );
//      }
   }
}
