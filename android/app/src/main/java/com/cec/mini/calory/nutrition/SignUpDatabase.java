package com.cec.mini.calory.nutrition;

import android.annotation.SuppressLint;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import com.cec.mini.calory.models.SignUpModel;

public class SignUpDatabase extends SQLiteOpenHelper {
    private static final String DATABASE_NAME = "SignUpData.db";
    private static final int DATABASE_VERSION = 1;
    private static final String TABLE_NAME = "SignUpData";

    // Column names
    private static final String COLUMN_USERNAME = "username";
    private static final String COLUMN_EMAIL = "email";
    private static final String COLUMN_PASSWORD = "password";
    private static final String COLUMN_GENDER = "gender";
    private static final String COLUMN_AGE = "age";
    private static final String COLUMN_WEIGHT = "weight";
    private static final String COLUMN_HEIGHT = "height";
    private static final String COLUMN_ACTIVITY_LEVEL = "activity_level";
    private static final String COLUMN_TARGET_CALORIE = "target_calorie";
    private static final String COLUMN_WATER_LEVEL = "water_level";
    private static final String COLUMN_WATER_PERCENTAGE = "water_percentage";
    private static final String COLUMN_WATER_TIME = "water_time";
    private static final String COLUMN_DATE = "date";

    public SignUpDatabase(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        // Create the signup table
        String CREATE_TABLE = "CREATE TABLE " + TABLE_NAME + "("
                + COLUMN_USERNAME + " TEXT,"
                + COLUMN_EMAIL + " TEXT PRIMARY KEY ,"
                + COLUMN_PASSWORD + " TEXT,"
                + COLUMN_GENDER + " TEXT,"
                + COLUMN_AGE + " INTEGER,"
                + COLUMN_WEIGHT + " REAL,"
                + COLUMN_HEIGHT + " REAL,"
                + COLUMN_ACTIVITY_LEVEL + " TEXT,"
                + COLUMN_TARGET_CALORIE + " REAL,"
                + COLUMN_WATER_LEVEL + " REAL DEFAULT 0,"
                + COLUMN_WATER_PERCENTAGE + " REAL DEFAULT 0,"
                + COLUMN_WATER_TIME + " TEXT DEFAULT '--',"
                + COLUMN_DATE + " TEXT DEFAULT '--'"
                + ")";
        db.execSQL(CREATE_TABLE);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        // Drop older table if existed
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_NAME);
        // Create tables again
        onCreate(db);
    }

    public void insertUserData(SignUpModel user) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put(COLUMN_USERNAME, user.getUserName());
        values.put(COLUMN_EMAIL, user.getUserEmail());
        values.put(COLUMN_PASSWORD, user.getUserPassword());
        values.put(COLUMN_GENDER, user.getGender());
        values.put(COLUMN_AGE, user.getAge());
        values.put(COLUMN_WEIGHT, user.getWeight());
        values.put(COLUMN_HEIGHT, user.getHeight());
        values.put(COLUMN_ACTIVITY_LEVEL, user.getActivityLevel());
        values.put(COLUMN_TARGET_CALORIE, user.getTargetCalorie());
        // Inserting Row
        db.insert(TABLE_NAME, null, values);
        db.close(); // Closing database connection
    }

    @SuppressLint("Range")
    public SignUpModel getUserData(String userEmail) {
        SignUpModel user = new SignUpModel();
        SQLiteDatabase db = this.getReadableDatabase();
        String[] columns = {
                COLUMN_USERNAME,
                COLUMN_EMAIL,
                COLUMN_PASSWORD,
                COLUMN_GENDER,
                COLUMN_AGE,
                COLUMN_WEIGHT,
                COLUMN_HEIGHT,
                COLUMN_ACTIVITY_LEVEL,
                COLUMN_TARGET_CALORIE,
        };
        String selection = COLUMN_EMAIL + "=?";
        String[] selectionArgs = {userEmail};
        Cursor cursor = db.query(TABLE_NAME, columns, selection, selectionArgs, null, null, null);
        if (cursor != null && cursor.moveToFirst()) {
            user.setUserName(cursor.getString(cursor.getColumnIndex(COLUMN_USERNAME)));
            user.setUserEmail(cursor.getString(cursor.getColumnIndex(COLUMN_EMAIL)));
            user.setUserPassword(cursor.getString(cursor.getColumnIndex(COLUMN_PASSWORD)));
            user.setGender(cursor.getString(cursor.getColumnIndex(COLUMN_GENDER)));
            user.setAge(cursor.getInt(cursor.getColumnIndex(COLUMN_AGE)));
            user.setWeight(cursor.getDouble(cursor.getColumnIndex(COLUMN_WEIGHT)));
            user.setHeight(cursor.getDouble(cursor.getColumnIndex(COLUMN_HEIGHT)));
            user.setActivityLevel(cursor.getString(cursor.getColumnIndex(COLUMN_ACTIVITY_LEVEL)));
            user.setTargetCalorie(cursor.getDouble(cursor.getColumnIndex(COLUMN_TARGET_CALORIE)));
            cursor.close();
        }
        db.close();
        return user;
    }

    @SuppressLint("Range")
    public SignUpModel getUserWaterData(String userEmail, String date) {
        SignUpModel user = new SignUpModel();
        SQLiteDatabase db = this.getReadableDatabase();
        String[] columns = {
                COLUMN_WATER_LEVEL,
                COLUMN_WATER_PERCENTAGE,
                COLUMN_WATER_TIME
        };
        String selection = COLUMN_EMAIL + "=? AND " + COLUMN_DATE + "=?";
        String[] selectionArgs = {userEmail, date};
        Cursor cursor = db.query(TABLE_NAME, columns, selection, selectionArgs, null, null, null);
        if (cursor != null && cursor.moveToFirst()) {
            user.setWaterLevel(cursor.getDouble(cursor.getColumnIndex(COLUMN_WATER_LEVEL)));
            user.setWaterPercentage(cursor.getDouble(cursor.getColumnIndex(COLUMN_WATER_PERCENTAGE)));
            user.setWaterTime(cursor.getString(cursor.getColumnIndex(COLUMN_WATER_TIME)));
            cursor.close();
        }
        db.close();
        return user;
    }

    public String setUserWaterData(SignUpModel signUpModel) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put(COLUMN_WATER_LEVEL, signUpModel.getWaterLevel());
        values.put(COLUMN_WATER_PERCENTAGE, signUpModel.getWaterPercentage());
        values.put(COLUMN_WATER_TIME, signUpModel.getWaterTime());
        values.put(COLUMN_DATE, signUpModel.getDate());

        String selection = COLUMN_EMAIL + "=?";
        String[] selectionArgs = {signUpModel.getUserEmail()};

        int rowsAffected = db.update(TABLE_NAME, values, selection, selectionArgs);
        db.close();
        // Handle the result as needed, e.g., check if any row was updated
        if (rowsAffected > 0) {
             return "updated";
        } else {
            return "not updated";
        }
    }

}
