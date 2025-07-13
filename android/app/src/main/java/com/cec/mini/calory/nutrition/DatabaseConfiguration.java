package com.cec.mini.calory.nutrition;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;

import com.cec.mini.calory.constants.AndroidConstants;

public class DatabaseConfiguration extends SQLiteOpenHelper {

    private  final String NUTRITION ="CREATE TABLE "+AndroidConstants.TABLE_NUTRITION+"(" +AndroidConstants.COLOUMN_ID+ " INTEGER PRIMARY KEY AUTOINCREMENT, "+
            AndroidConstants.FOOD_NAME + " TEXT, " +
            AndroidConstants.FOOD_WEIGHT + " NUMERIC, " +
            AndroidConstants.PROTIEN_WEIGHT + " NUMERIC, " +
            AndroidConstants.CARBO_HYDRATE_WEIGHT + " NUMERIC ," +
            AndroidConstants.FAT_WEIGHT+" NUMERIC,"+
            AndroidConstants.CALORIES+" NUMERIC,"+
            AndroidConstants.FOOD_IMAGE_PATH + " TEXT " +
            ")";


    private  final String CALORIES ="CREATE TABLE "+ AndroidConstants.TABLE_CALORIES+"(" + AndroidConstants.COLOUMN_ID+ " INTEGER PRIMARY KEY AUTOINCREMENT, "+
            AndroidConstants.FOOD_NAME + " TEXT, " +
            AndroidConstants.FOOD_WEIGHT + " NUMERIC, " +
            AndroidConstants.PROTIEN_WEIGHT + " NUMERIC, " +
            AndroidConstants.CARBO_HYDRATE_WEIGHT + " NUMERIC ," +
            AndroidConstants.FAT_WEIGHT+" NUMERIC,"+
            AndroidConstants.CALORIES+" NUMERIC,"+
            AndroidConstants.EMAIL_ID+" TEXT,"+
            AndroidConstants.DATE+ " TEXT," +
            AndroidConstants.CONSUMED+" TEXT, " +
            AndroidConstants.MEAL+" TEXT, " +
            AndroidConstants.FOOD_IMAGE_PATH + " TEXT " +
            ")";

    @RequiresApi(api = Build.VERSION_CODES.P)
    public DatabaseConfiguration(@Nullable Context context) {
        super(context, AndroidConstants.DB_NAME, null, 2);
    }

    @Override
    public void onCreate(SQLiteDatabase sqLiteDatabase) {
        sqLiteDatabase.execSQL(NUTRITION);
        sqLiteDatabase.execSQL(CALORIES);

    }

    @Override
    public void onUpgrade(SQLiteDatabase sqLiteDatabase, int i, int i1) {

    }
}
