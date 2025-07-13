
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

public class ShowProfileDataHandler implements MethodChannel.MethodCallHandler{

    private final Context context;
    private final SignUpDatabase signUpDb;

    @RequiresApi(api = Build.VERSION_CODES.P)
    public ShowProfileDataHandler(Context context) {
        this.context = context;
        this.signUpDb = new SignUpDatabase(context);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals("getProfileInfo")) {
            // Retrieve data from the method call
            String email = call.argument("email");

            SignUpModel signUpModel = new SignUpModel();
            signUpModel = signUpDb.getUserData(email);

            Map<String, Object> userData = new HashMap<>();

            userData.put("height", signUpModel.getHeight());
            userData.put("age", signUpModel.getAge());
            userData.put("weight", signUpModel.getWeight());
            userData.put("name", signUpModel.getUserName());
            userData.put("activityLevel", signUpModel.getActivityLevel());
            userData.put("gender", signUpModel.getGender());


            result.success(userData);
        } else {
            result.notImplemented();
        }
    }
}



