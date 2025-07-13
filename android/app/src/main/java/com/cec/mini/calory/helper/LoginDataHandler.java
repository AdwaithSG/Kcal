package com.cec.mini.calory.helper;

import android.content.Context;

import com.cec.mini.calory.models.LoginModel;
import com.cec.mini.calory.nutrition.LoginDatabase;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class LoginDataHandler implements MethodChannel.MethodCallHandler {

    private final Context context;
    private final LoginDatabase loginDb;

    private boolean isTrue = false;

    public LoginDataHandler(Context context) {
        this.context = context;
        this.loginDb = new LoginDatabase(context);
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        if (call.method.equals("submitLoginData")) {
            // Retrieve data from the method call
            String email = call.argument("email");
            String password = call.argument("password");

            // Create a SignUpModel instance and use the setter methods to set the data
            LoginModel loginModel = new LoginModel();
            loginModel.setLoginEmail(email);
            loginModel.setLoginPassword(password);

            isTrue = loginDb.authenticateUser(loginModel);

            if (isTrue) {
                loginModel.setLoginEmail(email);
                loginModel.setActive(true);
                loginDb.updateActiveStatus(loginModel);
                System.out.println("User can enter");
            } else {
                System.out.println("user can't enter");
            }

            result.success(isTrue);

        } /*else if (call.method.equals("submitLoginActiveData")) {

            boolean isActive = Boolean.TRUE.equals(call.argument("active"));
            String username = call.argument("username");

            LoginModel loginModel = new LoginModel();
            loginModel.setLoginUsername(username);
            loginModel.setActive(isActive);

            loginDb.updateActiveStatus(loginModel);

        }*/ else {
            result.notImplemented();
        }
    }
}
