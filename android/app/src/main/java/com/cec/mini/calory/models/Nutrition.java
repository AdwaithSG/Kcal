package com.cec.mini.calory.models;

public class Nutrition {


    private String foodName;
    private String foodImagePath;

    public String getFoodImagePath() {
        return foodImagePath;
    }

    public void setFoodImagePath(String foodImagePath) {
        this.foodImagePath = foodImagePath;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public double getFoodWeight() {
        return foodWeight;
    }

    public void setFoodWeight(double foodWeight) {
        this.foodWeight = foodWeight;
    }

    public double getProtienWeight() {
        return protienWeight;
    }

    public void setProtienWeight(double protienWeight) {
        this.protienWeight = protienWeight;
    }

    public double getCarbhydrateWeight() {
        return carbhydrateWeight;
    }

    public void setCarbhydrateWeight(double carbhydrateWeight) {
        this.carbhydrateWeight = carbhydrateWeight;
    }

    public double getFatWeight() {
        return fatWeight;
    }

    public void setFatWeight(double fatWeight) {
        this.fatWeight = fatWeight;
    }

    public double getCalories() {
        return calories;
    }

    public void setCalories(double calories) {
        this.calories = calories;
    }

    private double foodWeight;

    private double protienWeight;

    private double carbhydrateWeight;

    private double fatWeight;

    private double calories;

}
