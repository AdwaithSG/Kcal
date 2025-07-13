package com.cec.mini.calory.helper;

import java.util.Arrays;

public class NutritionHelper {

    private static final double CALORIE_PROTIEN = 4;

    private static final double CALORIE_FAT = 9;


    private static final double CALORIE_CARBOHYDRATE = 4;



    public static double getCalorie(double protien,double fat, double carbs){
        return (protien*CALORIE_PROTIEN)+(fat*CALORIE_FAT)+(carbs*CALORIE_CARBOHYDRATE);
    }

    public static double getCaloriesOtherThanHundred(double calories, double unputweight){
        return (calories/100)*unputweight;

    }

    public static double getProteinOtherThanHundred(double protein, double inputweight){
        return (protein/100)*inputweight;

    }

    public static double getCarbsOtherThanHundred(double carbs, double inputweight){
        return (carbs/100)*inputweight;

    }public static double getFatOtherThanHundred(double fat, double inputweight){
        return (fat/100)*inputweight;

    }

}
