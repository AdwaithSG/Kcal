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

public class CalorieDietDataHandler implements MethodChannel.MethodCallHandler{


    private final Context context;

    private CaloriesDataBaseHelper caloriesDataBaseHelper;
    private SignUpDatabase signUpDatabase;

    @RequiresApi(api = Build.VERSION_CODES.P)
    public CalorieDietDataHandler(Context context) {
        this.context = context;
        caloriesDataBaseHelper = new CaloriesDataBaseHelper(context);
        signUpDatabase = new SignUpDatabase(context);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals("getConsumedCalorie")) {
            // Retrieve data from the method call
            String date = call.argument("date");
            String email = call.argument("email");

            double calorie = caloriesDataBaseHelper.getConsumedCalories(date,email);
            double carbs = caloriesDataBaseHelper.getConsumedCarbs(date,email);
            double fat = caloriesDataBaseHelper.getConsumedFat(date,email);
            double protein = caloriesDataBaseHelper.getConsumedProtein(date,email);

            Map<String, Object> userData = new HashMap<>();

            userData.put("calorie", calorie);
            userData.put("carbs", carbs);
            userData.put("fat", fat);
            userData.put("protein", protein);

            result.success(userData);
        } else if (call.method.equals("getTargetCalorie")) {

            String email = call.argument("email");

            SignUpModel signUpModel = new SignUpModel();
            signUpModel = signUpDatabase.getUserData(email);
            double targetCalorie = signUpModel.getTargetCalorie();

            result.success(targetCalorie);
        }  else {
            result.notImplemented();
        }

    }
}

