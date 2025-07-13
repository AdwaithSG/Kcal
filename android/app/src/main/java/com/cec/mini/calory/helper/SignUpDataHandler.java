package com.cec.mini.calory.helper;

import android.content.Context;

import com.cec.mini.calory.models.LoginModel;
import com.cec.mini.calory.models.SignUpModel;
import com.cec.mini.calory.nutrition.LoginDatabase;
import com.cec.mini.calory.nutrition.SignUpDatabase;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class SignUpDataHandler implements MethodChannel.MethodCallHandler {

    private final Context context;
    private final SignUpDatabase database;
    private final LoginDatabase loginDb;

    public SignUpDataHandler(Context context) {
        this.context = context;
        this.database = new SignUpDatabase(context);
        this.loginDb = new LoginDatabase(context);
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        if (call.method.equals("submitSignupData")) {
            // Retrieve data from the method call
            String username = call.argument("username");
            String email = call.argument("email");
            String password = call.argument("password");
            String gender = call.argument("gender");
            int age = call.argument("age"); // Corrected to int
            double weight = call.argument("weight");
            double height = call.argument("height");
            String activityLevel = call.argument("activityLevel");
            double goalCalorie = call.argument("goalCalorie");

            boolean active = false;



            // Create a SignUpModel instance and use the setter methods to set the data
            SignUpModel user = new SignUpModel();
            user.setUserName(username);
            user.setUserEmail(email);
            user.setUserPassword(password);
            user.setGender(gender);
            user.setAge(age);
            user.setWeight(weight);
            user.setHeight(height);
            user.setActivityLevel(activityLevel);
            user.setTargetCalorie(goalCalorie);



            // Insert the user data into the database
            database.insertUserData(user);

            LoginModel loginModel = new LoginModel();
            loginModel.setLoginUsername(username);
            loginModel.setLoginPassword(password);
            loginModel.setLoginEmail(email);
            loginModel.setActive(active);

            // Insert the user data into the database
            loginDb.insertLoginData(loginModel);

            // Respond back to the Flutter side
            result.success("Data stored successfully in the database.");
        } else {
            result.notImplemented();
        }
    }
}
