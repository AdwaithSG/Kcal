package com.cec.mini.calory.nutrition;

import android.annotation.SuppressLint;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.os.Build;

import androidx.annotation.RequiresApi;

import com.cec.mini.calory.constants.AndroidConstants;
import com.cec.mini.calory.models.CaloriesDaily;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class CaloriesDataBaseHelper {



    SQLiteOpenHelper dbhandler;
    SQLiteDatabase database;
    private static final String GET_FOOD_QUERY ="SELECT * FROM CALORIES";

    private static final String UPDATE_FOOD_QUERY = "UPDATE CALORIES SET";

    private static final String CONSUMED = AndroidConstants.CONSUMED+"=?";

    private static final String WEIGHT = AndroidConstants.FOOD_WEIGHT+"=?";

    private static final String WHERE = " WHERE DATE= ? AND EMAILID=?";

    private static final String DELETE_CALORIES = "DELETE FROM CALORIES";

    private static final String OPERATION_SUCCESS = "Calories Added";


    @RequiresApi(api = Build.VERSION_CODES.P)
    public CaloriesDataBaseHelper(Context context) {
            dbhandler=new DatabaseConfiguration(context);
            database = dbhandler.getWritableDatabase();
    }

    public String saveCalories(CaloriesDaily calories){
        boolean isDuplicate = checkDuplicate(calories.getDate(),calories.getEmailId(),calories.getWeight(),calories.getMeal(),calories.getFoodName());
        if (isDuplicate){
            return "duplicate";
        }
        else {
            ContentValues values = new ContentValues();
            values.put(AndroidConstants.FOOD_NAME, calories.getFoodName());
            values.put(AndroidConstants.CALORIES, calories.getCalories());
            values.put(AndroidConstants.FOOD_WEIGHT, calories.getWeight());
            values.put(AndroidConstants.CARBO_HYDRATE_WEIGHT, calories.getCarbohydrate());
            values.put(AndroidConstants.PROTIEN_WEIGHT, calories.getProtein());
            values.put(AndroidConstants.FAT_WEIGHT, calories.getFat());
            values.put(AndroidConstants.EMAIL_ID, calories.getEmailId());
            values.put(AndroidConstants.DATE, calories.getDate());
            values.put(AndroidConstants.MEAL, calories.getMeal());
            values.put(AndroidConstants.CONSUMED,String.valueOf(calories.isConsumed()));
            values.put(AndroidConstants.FOOD_IMAGE_PATH, calories.getImage());
            long id = database.insert(AndroidConstants.TABLE_CALORIES, null, values);
            return id != 0 ? OPERATION_SUCCESS : AndroidConstants.OPERATION_FAILED;
        }
    }

    private boolean checkDuplicate(String date, String emailId, double weight, String meal, String name) {
        String selection = AndroidConstants.DATE + "=? AND " +
                AndroidConstants.EMAIL_ID + "=? AND " +
                AndroidConstants.FOOD_WEIGHT + "=? AND " +
                AndroidConstants.MEAL + "=? AND " +
                AndroidConstants.FOOD_NAME + "=?";

        String[] selectionArgs = {date, emailId, String.valueOf(weight), meal, name};

        Cursor cursor = database.query(AndroidConstants.TABLE_CALORIES,
                null,
                selection,
                selectionArgs,
                null,
                null,
                null);

        boolean isDuplicate = cursor != null && cursor.getCount() > 0;

        if (cursor != null) {
            cursor.close();
        }

        return isDuplicate;
    }


    @SuppressLint("Range")
    public List<CaloriesDaily> getCalories(String date, String emailId) {

        List<CaloriesDaily> calorieslist = new ArrayList<>();
        Cursor cursor = database.rawQuery(GET_FOOD_QUERY+WHERE, new String[]{date, emailId});
        if (cursor.getCount() > 0) {
            while (cursor.moveToNext()) {
                CaloriesDaily calories = new CaloriesDaily();
                double weightPresent = cursor.getDouble(cursor.getColumnIndex(AndroidConstants.FOOD_WEIGHT));
                double carbohydrate = cursor.getDouble(cursor.getColumnIndex(AndroidConstants.CARBO_HYDRATE_WEIGHT));
                double protien = cursor.getDouble(cursor.getColumnIndex(AndroidConstants.PROTIEN_WEIGHT));
                double fat = cursor.getDouble(cursor.getColumnIndex(AndroidConstants.FAT_WEIGHT));
                double caloriesvalue = cursor.getDouble(cursor.getColumnIndex(AndroidConstants.CALORIES));
                String emailid = cursor.getString(cursor.getColumnIndex(AndroidConstants.EMAIL_ID));
                String name = cursor.getString(cursor.getColumnIndex(AndroidConstants.FOOD_NAME));
                String dateF = cursor.getString(cursor.getColumnIndex(AndroidConstants.DATE));
                String meal = cursor.getString(cursor.getColumnIndex(AndroidConstants.MEAL));
                String consumed = cursor.getString(cursor.getColumnIndex(AndroidConstants.CONSUMED));
                String image = cursor.getString(cursor.getColumnIndex(AndroidConstants.FOOD_IMAGE_PATH));

                calories.setCalories(caloriesvalue);
                calories.setCarbohydrate(carbohydrate);
                calories.setProtein(protien);
                calories.setWeight(weightPresent);
                calories.setDate(dateF);
                calories.setEmailId(emailid);
                calories.setFat(fat);
                calories.setFoodName(name);
                calories.setConsumed(Boolean.parseBoolean(consumed));
                calories.setMeal(meal);
                calories.setImage(image);

                calorieslist.add(calories);
            }
        }
        return calorieslist;
    }

    /*public String updateCalories(String date,String emailId, boolean consumed,double weight){

        if(Objects.nonNull(weight)){
            database.execSQL(UPDATE_FOOD_QUERY+WEIGHT+WHERE,new Object[]{weight,date,emailId});
            return "Updation of Weight is  Successfull";
        } else if (consumed) {
            database.execSQL(UPDATE_FOOD_QUERY+CONSUMED+WHERE,new String[]{String.valueOf(consumed),date,emailId});
            return "Updation of status is  Successfull";

        }
        return "Updation Not Happened";
    }/

    public String deleteCalories(String date,String emailId){
        database.execSQL(DELETE_CALORIES+WHERE,new String[]{date,emailId});
        return "Deleted Successfully";
    }*/

    public String updateConsumed(String date, String emailId, boolean consumed, double weight, String image, String meal, String name) {
        ContentValues values = new ContentValues();
        values.put(AndroidConstants.CONSUMED, String.valueOf(consumed));

        // Construct the WHERE clause based on the provided parameters
        String whereClause = AndroidConstants.DATE + "=? AND " +
                AndroidConstants.EMAIL_ID + "=? AND " +
                AndroidConstants.FOOD_WEIGHT + "=? AND " +
                AndroidConstants.FOOD_IMAGE_PATH + "=? AND " +
                AndroidConstants.MEAL + "=? AND " +
                AndroidConstants.FOOD_NAME + "=?";

        // Arguments for the WHERE clause
        String[] whereArgs = {date, emailId, String.valueOf(weight), image, meal, name};

        // Perform the update operation
        int rowsAffected = database.update(AndroidConstants.TABLE_CALORIES, values, whereClause, whereArgs);

        if (rowsAffected > 0) {
            return "updated";
        } else {
            return "falied";
        }
    }

    public double getConsumedCalories(String date, String emailId) {
        double totalCalories = 0.0;

        // Construct the WHERE clause based on the provided parameters
        String whereClause = AndroidConstants.DATE + "=? AND " +
                AndroidConstants.EMAIL_ID + "=? AND " +
                AndroidConstants.CONSUMED + "=?";

        // Arguments for the WHERE clause
        String[] whereArgs = {date, emailId, "true"}; // "true" represents true for boolean column

        // Perform the query to get the sum of consumed calories
        Cursor cursor = database.query(AndroidConstants.TABLE_CALORIES,
                new String[]{"SUM(" + AndroidConstants.CALORIES + ")"},
                whereClause,
                whereArgs,
                null,
                null,
                null);

        // Retrieve the sum of consumed calories from the cursor
        if (cursor != null && cursor.moveToFirst()) {
            totalCalories = cursor.getDouble(0); // Get the sum from the first column
            cursor.close();
        }

        return totalCalories;
    }

    public double getConsumedCarbs(String date, String emailId) {
        double totalCarbs = 0.0;

        // Construct the WHERE clause based on the provided parameters
        String whereClause = AndroidConstants.DATE + "=? AND " +
                AndroidConstants.EMAIL_ID + "=? AND " +
                AndroidConstants.CONSUMED + "=?";

        // Arguments for the WHERE clause
        String[] whereArgs = {date, emailId, "true"}; // "true" represents true for boolean column

        // Perform the query to get the sum of consumed calories
        Cursor cursor = database.query(AndroidConstants.TABLE_CALORIES,
                new String[]{"SUM(" + AndroidConstants.CARBO_HYDRATE_WEIGHT + ")"},
                whereClause,
                whereArgs,
                null,
                null,
                null);

        // Retrieve the sum of consumed calories from the cursor
        if (cursor != null && cursor.moveToFirst()) {
            totalCarbs = cursor.getDouble(0); // Get the sum from the first column
            cursor.close();
        }

        return totalCarbs;
    }

    public double getConsumedFat(String date, String emailId) {
        double totalFat = 0.0;

        // Construct the WHERE clause based on the provided parameters
        String whereClause = AndroidConstants.DATE + "=? AND " +
                AndroidConstants.EMAIL_ID + "=? AND " +
                AndroidConstants.CONSUMED + "=?";

        // Arguments for the WHERE clause
        String[] whereArgs = {date, emailId, "true"}; // "true" represents true for boolean column

        // Perform the query to get the sum of consumed calories
        Cursor cursor = database.query(AndroidConstants.TABLE_CALORIES,
                new String[]{"SUM(" + AndroidConstants.FAT_WEIGHT + ")"},
                whereClause,
                whereArgs,
                null,
                null,
                null);

        // Retrieve the sum of consumed calories from the cursor
        if (cursor != null && cursor.moveToFirst()) {
            totalFat = cursor.getDouble(0); // Get the sum from the first column
            cursor.close();
        }

        return totalFat;
    }

    public double getConsumedProtein(String date, String emailId) {
        double totalProtein = 0.0;

        // Construct the WHERE clause based on the provided parameters
        String whereClause = AndroidConstants.DATE + "=? AND " +
                AndroidConstants.EMAIL_ID + "=? AND " +
                AndroidConstants.CONSUMED + "=?";

        // Arguments for the WHERE clause
        String[] whereArgs = {date, emailId, "true"}; // "true" represents true for boolean column

        // Perform the query to get the sum of consumed calories
        Cursor cursor = database.query(AndroidConstants.TABLE_CALORIES,
                new String[]{"SUM(" + AndroidConstants.PROTIEN_WEIGHT + ")"},
                whereClause,
                whereArgs,
                null,
                null,
                null);

        // Retrieve the sum of consumed calories from the cursor
        if (cursor != null && cursor.moveToFirst()) {
            totalProtein = cursor.getDouble(0); // Get the sum from the first column
            cursor.close();
        }

        return totalProtein;
    }
}
