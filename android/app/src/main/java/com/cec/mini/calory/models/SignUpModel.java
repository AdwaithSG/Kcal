package com.cec.mini.calory.models;

public class SignUpModel {

    private String username;
    private String email;
    private String password;
    private String gender;
    private int age;
    private double weight;
    private double height;
    private String activityLevel;
    private double targetCalorie;
    private double waterLevel;
    private double waterPercentage;
    private String waterTime;
    private String date;

    public void setDate(String date) {
        this.date = date;
    }

    public String getDate() {
        return date;
    }

    public double getHeight() {
        return height;
    }

    public void setHeight(double height) {
        this.height = height;
    }

    public String getActivityLevel() {
        return activityLevel;
    }

    public void setActivityLevel(String activityLevel) {
        this.activityLevel = activityLevel;
    }

    public double getTargetCalorie() {
        return targetCalorie;
    }

    public void setTargetCalorie(double targetCalorie) {
        this.targetCalorie = targetCalorie;
    }

    public double getWaterLevel() {
        return waterLevel;
    }

    public void setWaterLevel(double waterLevel) {
        this.waterLevel = waterLevel;
    }

    public double getWaterPercentage() {
        return waterPercentage;
    }

    public void setWaterPercentage(double waterPercentage) {
        this.waterPercentage = waterPercentage;
    }

    public String getWaterTime() {
        return waterTime;
    }

    public void setWaterTime(String waterTime) {
        this.waterTime = waterTime;
    }

    public String getUserName() {
        return username;
    }

    public void setUserName(String username) {
        this.username = username;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {this.age = age;}

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {this.weight = weight;}

    public String getUserEmail() {
        return email;
    }

    public void setUserEmail(String email) {
        this.email = email;
    }

    public String getUserPassword() {
        return password;
    }

    public void setUserPassword(String password) {
        this.password = password;
    }
}
