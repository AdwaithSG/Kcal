package com.cec.mini.calory.helper;

import android.content.Context;

import androidx.annotation.NonNull;

import com.cec.mini.calory.models.LoginModel;
import com.cec.mini.calory.models.SignUpModel;
import com.cec.mini.calory.nutrition.LoginDatabase;
import com.cec.mini.calory.nutrition.SignUpDatabase;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class HomeDataHandler implements MethodChannel.MethodCallHandler {

    private final Context context;
    private final LoginDatabase loginDb;
    private final SignUpDatabase signUpDb;

    public HomeDataHandler(Context context) {
        this.context = context;
        this.loginDb = new LoginDatabase(context);
        this.signUpDb = new SignUpDatabase(context);
    }

    @Override
    public void onMethodCall(MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals("getCurrentUser")) {
            // Retrieve data from the method call
            LoginModel loginModel = loginDb.getCurrentUser();
            String username = loginModel.getLoginUsername();
            String email = loginModel.getLoginEmail();

            Map<String, String> userData = new HashMap<>();
            userData.put("name", username);
            userData.put("email", email);


            result.success(userData);

        } else {
            result.notImplemented();
        }
        if (call.method.equals("disableCurrentUser")) {
            // Retrieve data from the method call
            String email = call.argument("email");

            LoginModel loginModel = new LoginModel();
            loginModel.setLoginEmail(email);
            loginModel.setActive(false);
            loginDb.updateActiveStatus(loginModel);

            result.success("User Exit");
        } else {
            result.notImplemented();
        }
    }
}
