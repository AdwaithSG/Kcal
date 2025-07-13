package com.cec.mini.calory.helper;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import com.cec.mini.calory.models.Nutrition;
import com.cec.mini.calory.nutrition.NutritionDataBaseHelper;

import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class NutritionHandler implements MethodChannel.MethodCallHandler{


    private final Context context;

    private NutritionDataBaseHelper nutritionDataBaseHelper;

    @RequiresApi(api = Build.VERSION_CODES.P)
    public NutritionHandler(Context context) {
        this.context = context;
        nutritionDataBaseHelper = new NutritionDataBaseHelper(context);
    }


    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals("submitNutrientsData")) {
            double protien = call.argument("protein");
            double fat = call.argument("fat");
            double carbs = call.argument("carbs");
            double weight = call.argument("weight");
            String name = call.argument("name");
            String imagePath = call.argument("image");
            Log.i("WEIGHT", String.valueOf(weight));
            Log.i("INPUT FOOD NAME",name);
            Nutrition nutrition = getNutrition(protien, fat, carbs, weight,name.toLowerCase(),imagePath);
            List<String> foodNames =  nutritionDataBaseHelper.getNutritionNames();
            if (!foodNames.contains(name)){
                String status = nutritionDataBaseHelper.saveFood(nutrition);
            }else{
                System.out.println("duplicate item");
            }
            //write a method to show this status to dart
        }
    }

    @NonNull
    private static Nutrition getNutrition(double protien, double fat, double carbs, double weight , String name, String img) {
        Nutrition nutrition = new Nutrition();
        nutrition.setFatWeight(weight);
        nutrition.setProtienWeight(protien);
        nutrition.setFatWeight(fat);
        nutrition.setCarbhydrateWeight(carbs);
        nutrition.setFoodWeight(weight);
        nutrition.setFoodName(name);
        nutrition.setFoodImagePath(img);
        return nutrition;
    }
}
