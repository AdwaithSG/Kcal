package com.cec.mini.calory;

import android.os.Build;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import com.cec.mini.calory.helper.CalorieDietDataHandler;
import com.cec.mini.calory.helper.FoodScheduleHandler;
import com.cec.mini.calory.helper.FoodSearchHandler;
import com.cec.mini.calory.helper.HomeDataHandler;
import com.cec.mini.calory.helper.LoginDataHandler;
import com.cec.mini.calory.helper.NutritionHandler;
import com.cec.mini.calory.helper.ShowProfileDataHandler;
import com.cec.mini.calory.helper.SignUpDataHandler;
import com.cec.mini.calory.helper.MLHandler;
import com.cec.mini.calory.helper.WaterDataHandler;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

    private static final String SIGNUP_CHANNEL = "signup_data_channel";
    private static final String LOGIN_CHANNEL = "login_data_channel";
    private static final String HOME_CHANNEL = "home_data_channel";
    private static final String CALORIE_DIET_CHANNEL = "calorie_diet_data_channel";

    private static final String ML_CHANNEL = "scan_food_channel";

    private static final String NUTRITION_CHANNEL="nutrients_data_channel";

    private static final String FOOD_SEARCH_CHANNEL="food_search_data_channel";

    private static final String FOOD_SCHEDULE_CHANNEL="meal_schedule_data_channel";
    private static final String WATER_DATA_CHANNEL="water_view_data_channel";
    private static final String VIEW_PROFILE_DATA_CHANNEL="show_profile_data_channel";


    @RequiresApi(api = Build.VERSION_CODES.P)
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        // Create and set up the SignUpDataHandler instance for the SIGNUP_CHANNEL
        SignUpDataHandler signUpDataHandler = new SignUpDataHandler(this);
        new MethodChannel(flutterEngine.getDartExecutor(), SIGNUP_CHANNEL)
                .setMethodCallHandler(signUpDataHandler);

        // Create and set up the LoginDataHandler instance for the LOGIN_CHANNEL
        LoginDataHandler loginDataHandler = new LoginDataHandler(this);
        new MethodChannel(flutterEngine.getDartExecutor(), LOGIN_CHANNEL)
                .setMethodCallHandler(loginDataHandler);

        // Create and set up the HomeDataHandler instance for the LOGIN_CHANNEL
        HomeDataHandler homeDataHandler = new HomeDataHandler(this);
        new MethodChannel(flutterEngine.getDartExecutor(), HOME_CHANNEL)
                .setMethodCallHandler(homeDataHandler);

        MLHandler mlHelper = new MLHandler(getLabels(),this);
        new MethodChannel(flutterEngine.getDartExecutor(), ML_CHANNEL)
                .setMethodCallHandler(mlHelper);

        NutritionHandler nutritionHandler = new NutritionHandler(this);
        new MethodChannel(flutterEngine.getDartExecutor(),NUTRITION_CHANNEL).setMethodCallHandler(nutritionHandler);

        // Create and set up the FoodSearchHandler instance for the FOOD_SEARCH_CHANNEL
        FoodSearchHandler foodSearchHandler = new FoodSearchHandler(this);
        new MethodChannel(flutterEngine.getDartExecutor(),FOOD_SEARCH_CHANNEL).setMethodCallHandler(foodSearchHandler);

        FoodScheduleHandler foodScheduleHandler = new FoodScheduleHandler(this);
        new MethodChannel(flutterEngine.getDartExecutor(),FOOD_SCHEDULE_CHANNEL).setMethodCallHandler(foodScheduleHandler);

        CalorieDietDataHandler calorieDietDataHandler = new CalorieDietDataHandler(this);
        new MethodChannel(flutterEngine.getDartExecutor(),CALORIE_DIET_CHANNEL).setMethodCallHandler(calorieDietDataHandler);

        WaterDataHandler waterDataHandler = new WaterDataHandler(this);
        new MethodChannel(flutterEngine.getDartExecutor(),WATER_DATA_CHANNEL).setMethodCallHandler(waterDataHandler);

        ShowProfileDataHandler showProfileDataHandler = new ShowProfileDataHandler(this);
        new MethodChannel(flutterEngine.getDartExecutor(),VIEW_PROFILE_DATA_CHANNEL).setMethodCallHandler(showProfileDataHandler);

    }
    @NonNull
    private String[] getLabels() {
        BufferedReader reader =null;
        String[] labels = new String[1001];
        int count = 0;
        try {
            reader = new BufferedReader(new InputStreamReader(getAssets().open(MLHandler.LABEL_FILE_NAME)));
            String labelvalue = reader.readLine();
            while(labelvalue!=null){
                labels[count] = labelvalue;
                count++;
                labelvalue=reader.readLine();
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return labels;
    }



}
