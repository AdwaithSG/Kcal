
package com.cec.mini.calory.helper;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import com.cec.mini.calory.models.CaloriesDaily;
import com.cec.mini.calory.models.LoginModel;
import com.cec.mini.calory.models.Nutrition;
import com.cec.mini.calory.models.SignUpModel;
import com.cec.mini.calory.nutrition.CaloriesDataBaseHelper;
import com.cec.mini.calory.nutrition.NutritionDataBaseHelper;
import com.cec.mini.calory.nutrition.SignUpDatabase;
import com.google.gson.Gson;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class WaterDataHandler implements MethodChannel.MethodCallHandler{

    private final Context context;
    private final SignUpDatabase signUpDb;

    @RequiresApi(api = Build.VERSION_CODES.P)
    public WaterDataHandler(Context context) {
        this.context = context;
        this.signUpDb = new SignUpDatabase(context);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals("getWaterData")) {
            // Retrieve data from the method call
            String email = call.argument("email");
            String date = call.argument("date");
            double waterLevel = call.argument("waterLevel");
            double waterPercentage = call.argument("waterPr");
            String waterTime = call.argument("waterTm");

            SignUpModel signUpModel = new SignUpModel();
            signUpModel.setUserEmail(email);
            signUpModel.setDate(date);
            signUpModel.setWaterLevel(waterLevel);
            signUpModel.setWaterPercentage(waterPercentage);
            signUpModel.setWaterTime(waterTime);

            String status = signUpDb.setUserWaterData(signUpModel);

            System.out.println(status);

            result.success("success");
        } else if (call.method.equals("getCurrentUserWaterInfo")) {
            // Retrieve data from the method call
            String email = call.argument("email");
            String date = call.argument("date");
            System.out.println(email);
            System.out.println(date);

            SignUpModel signUpModel = signUpDb.getUserWaterData(email,date);

            double waterLv = signUpModel.getWaterLevel();
            double waterPr = signUpModel.getWaterPercentage();
            String waterTm = signUpModel.getWaterTime();

            System.out.println(waterLv);
            System.out.println(waterPr);
            System.out.println(waterTm);

            Map<String, Object> userData = new HashMap<>();

            userData.put("water_level", waterLv);
            userData.put("water_percentage", waterPr);
            userData.put("water_time", waterTm);

            result.success(userData);

        } else {
            result.notImplemented();
        }
    }
}


