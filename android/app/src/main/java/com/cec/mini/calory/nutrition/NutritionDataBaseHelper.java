package com.cec.mini.calory.nutrition;

import android.annotation.SuppressLint;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.os.Build;
import android.util.Log;

import androidx.annotation.RequiresApi;

import com.cec.mini.calory.models.Nutrition;
import com.cec.mini.calory.constants.AndroidConstants;
import com.cec.mini.calory.helper.NutritionHelper;

import java.util.ArrayList;
import java.util.List;

public class NutritionDataBaseHelper {

    static SQLiteOpenHelper dbhandler;
    static SQLiteDatabase database;

    private static final String GET_FOOD_QUERY ="SELECT * FROM NUTRITION " ;
    private static final String F00D_NAME =    "WHERE FOOD_NAME= ?";

    private static final String OPERATION_SUCCESS = "Food Added";


    @RequiresApi(api = Build.VERSION_CODES.P)
    public NutritionDataBaseHelper(Context context) {
        dbhandler=new DatabaseConfiguration(context);
        database = dbhandler.getWritableDatabase();
    }



    public String saveFood(Nutrition nutrition){

            double calories = NutritionHelper.getCalorie(nutrition.getProtienWeight(), nutrition.getFatWeight(), nutrition.getCarbhydrateWeight());
            Log.i("CALORIES:", String.valueOf(calories));
            ContentValues values = new ContentValues();
            values.put(AndroidConstants.FOOD_NAME, nutrition.getFoodName());
            values.put(AndroidConstants.CALORIES, calories);
            values.put(AndroidConstants.FOOD_WEIGHT, nutrition.getFoodWeight());
            values.put(AndroidConstants.CARBO_HYDRATE_WEIGHT, nutrition.getCarbhydrateWeight());
            values.put(AndroidConstants.PROTIEN_WEIGHT, nutrition.getProtienWeight());
            values.put(AndroidConstants.FAT_WEIGHT, nutrition.getFatWeight());
            values.put(AndroidConstants.FOOD_IMAGE_PATH, nutrition.getFoodImagePath());
            long id = database.insert(AndroidConstants.TABLE_NUTRITION, null, values);
            return id != 0 ? OPERATION_SUCCESS : AndroidConstants.OPERATION_FAILED;

    }

    @SuppressLint("Range")
    public static Nutrition getNutrition(String foodName,String weight){
        Nutrition nutrition = new Nutrition();
        Cursor cursor=database.rawQuery(GET_FOOD_QUERY+F00D_NAME,new String[]{foodName});
        if(cursor.getCount()>0) {
            while (cursor.moveToNext()) {
                nutrition.setFoodName(cursor.getString(cursor.getColumnIndex(AndroidConstants.FOOD_NAME)));
                double weightPresent = cursor.getDouble(cursor.getColumnIndex(AndroidConstants.FOOD_WEIGHT));
                double caloriespresent = cursor.getDouble(cursor.getColumnIndex(AndroidConstants.CALORIES));
                double carbohydrate = cursor.getDouble(cursor.getColumnIndex(AndroidConstants.CARBO_HYDRATE_WEIGHT));
                double protien = cursor.getDouble(cursor.getColumnIndex(AndroidConstants.PROTIEN_WEIGHT));
                double fat = cursor.getDouble(cursor.getColumnIndex(AndroidConstants.FAT_WEIGHT));
                String image = cursor.getString(cursor.getColumnIndex(AndroidConstants.FOOD_IMAGE_PATH));

                nutrition.setFoodWeight(weightPresent);
                nutrition.setProtienWeight(protien);
                nutrition.setCarbhydrateWeight(carbohydrate);
                nutrition.setFatWeight(fat);
                nutrition.setFoodImagePath(image);
                if(weightPresent==Double.parseDouble(weight)){
                    nutrition.setCalories(caloriespresent);
                }
                else {
                    nutrition.setCalories(NutritionHelper.getCaloriesOtherThanHundred(caloriespresent,Double.valueOf(weight)));
                    nutrition.setProtienWeight(NutritionHelper.getProteinOtherThanHundred(protien,Double.valueOf(weight)));
                    nutrition.setCarbhydrateWeight(NutritionHelper.getCarbsOtherThanHundred(carbohydrate,Double.valueOf(weight)));
                    nutrition.setFatWeight(NutritionHelper.getFatOtherThanHundred(fat,Double.valueOf(weight)));
                    nutrition.setFoodWeight(Double.parseDouble(weight));
                }
            }
        }
        return nutrition;
    }


    @SuppressLint("Range")
    public static  List<String> getNutritionNames(){
        Cursor cursor=database.rawQuery(GET_FOOD_QUERY, new String[0]);
        List<String> foodNames = new ArrayList<>(400);
        if(cursor.getCount()>0) {
            while (cursor.moveToNext()) {
                foodNames.add(cursor.getString(cursor.getColumnIndex(AndroidConstants.FOOD_NAME)));
            }
        }
        return foodNames;
    }

    @SuppressLint("Range")
    public static  List<String> getFoodImages(){
        Cursor cursor=database.rawQuery(GET_FOOD_QUERY, new String[0]);
        List<String> foodImages = new ArrayList<>(400);
        if(cursor.getCount()>0) {
            while (cursor.moveToNext()) {
                foodImages.add(cursor.getString(cursor.getColumnIndex(AndroidConstants.FOOD_IMAGE_PATH)));
            }
        }
        return foodImages;
    }
    public void close(){
        dbhandler.close();
    }
}
