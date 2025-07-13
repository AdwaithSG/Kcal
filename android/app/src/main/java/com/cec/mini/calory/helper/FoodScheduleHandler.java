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
import com.google.gson.Gson;

import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class FoodScheduleHandler implements MethodChannel.MethodCallHandler {


    private final Context context;

    private CaloriesDataBaseHelper caloriesDataBaseHelper;

    @RequiresApi(api = Build.VERSION_CODES.P)
    public FoodScheduleHandler(Context context) {
        this.context = context;
        caloriesDataBaseHelper = new CaloriesDataBaseHelper(context);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals("getScheduleFoodInfo")) {
            // Retrieve data from the method call
            String date = call.argument("date");
            String email = call.argument("email");


            List<CaloriesDaily> calorieslist = new ArrayList<>();
            calorieslist = caloriesDataBaseHelper.getCalories(date, email);

            Gson gson = new Gson();
            String json = gson.toJson(calorieslist);

            result.success(json);
        } else if (call.method.equals("updateConsumedFood")) {
            // Retrieve data from the method call
            String date = call.argument("date");
            String email = call.argument("email");
            boolean consumed = call.argument("consumed");
            double weight = call.argument("weight");
            String image = call.argument("image");
            String meal = call.argument("meal");
            String foodName = call.argument("foodName");

            String status = caloriesDataBaseHelper.updateConsumed(date, email, consumed, weight, image, meal, foodName);
            System.out.println(status);

            result.success("Data updated");
        } else {
            result.notImplemented();
        }
    }

}
