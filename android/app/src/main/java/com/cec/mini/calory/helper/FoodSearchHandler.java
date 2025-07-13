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

import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class FoodSearchHandler implements MethodChannel.MethodCallHandler{


    private final Context context;

    private NutritionDataBaseHelper nutritionDataBaseHelper;

    private CaloriesDataBaseHelper caloriesDataBaseHelper;

    @RequiresApi(api = Build.VERSION_CODES.P)
    public FoodSearchHandler(Context context) {
        this.context = context;
        nutritionDataBaseHelper = new NutritionDataBaseHelper(context);
        caloriesDataBaseHelper = new CaloriesDataBaseHelper(context);
    }


    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals("searchFoodsName")) {
            List<String> foodNames;
            foodNames = nutritionDataBaseHelper.getNutritionNames();
            result.success(foodNames);
        } else if (call.method.equals("searchFoodsImages")) {
            List<String> foodImages;
            foodImages = nutritionDataBaseHelper.getFoodImages();
            result.success(foodImages);
        }else {
            result.notImplemented();
        }
        if (call.method.equals("submitSelectedFoodData")) {
            // Retrieve data from the method call
            String foodName = call.argument("foodName");
            String foodWeight = call.argument("foodWeight");
            String email = call.argument("email");
            String date = call.argument("date");
            String meal = call.argument("meal");

            System.out.println(foodName);
            System.out.println(foodWeight);

            Nutrition nutrition = new Nutrition();
            nutrition = nutritionDataBaseHelper.getNutrition(foodName,foodWeight);

            CaloriesDaily caloriesDaily = new CaloriesDaily();
            caloriesDaily.setFoodName(nutrition.getFoodName());
            caloriesDaily.setWeight(nutrition.getFoodWeight());
            caloriesDaily.setProtein(nutrition.getProtienWeight());
            caloriesDaily.setCarbohydrate(nutrition.getCarbhydrateWeight());
            caloriesDaily.setFat(nutrition.getFatWeight());
            caloriesDaily.setCalories(nutrition.getCalories());
            caloriesDaily.setEmailId(email);
            caloriesDaily.setDate(date);
            caloriesDaily.setConsumed(false);
            caloriesDaily.setMeal(meal);
            caloriesDaily.setImage(nutrition.getFoodImagePath());

            String status = caloriesDataBaseHelper.saveCalories(caloriesDaily);

            result.success(status);
        } else {
            result.notImplemented();
        }
    }

}
