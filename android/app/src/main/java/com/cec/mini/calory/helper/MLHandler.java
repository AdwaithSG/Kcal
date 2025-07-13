package com.cec.mini.calory.helper;



import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Log;

import androidx.annotation.NonNull;

import com.cec.mini.calory.ml.MobilenetV110224Quant;
import com.cec.mini.calory.models.Nutrition;
import com.cec.mini.calory.nutrition.NutritionDataBaseHelper;

import org.tensorflow.lite.DataType;
import org.tensorflow.lite.support.image.TensorImage;
import org.tensorflow.lite.support.tensorbuffer.TensorBuffer;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MLHandler implements MethodChannel.MethodCallHandler {

    public static final String LABEL_FILE_NAME = "labels.txt";

    private final Context context;

    private final String[] labels;

    public MLHandler(String[] labels, Context context){

        this.context = context;
        this.labels =labels;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals("submitScanFoodData")) {
            String formData = call.argument("weight");
            byte[] imagePath = call.argument("path");
            Bitmap bitmap = BitmapFactory.decodeByteArray(imagePath, 0, imagePath.length);
            Log.i("WEIGHT",formData);
            String foodname = getFoodName(bitmap, context, labels);
            Log.i("ML-FOOD NAME",foodname);
            Nutrition nutritionFound =  NutritionDataBaseHelper.getNutrition(foodname,formData);
            if(Objects.isNull(nutritionFound)) {
                //Toast.makeText(MainActivity.this,nutrition.getFoodName(), Toast.LENGTH_SHORT).show();
                //result.success(Collections.singletonList("test"));
                System.out.println("food not found");
            }
           else{
               //Map<String,String> resultMap = new HashMap<>();
              // resultMap.put("foodName",nutritionFound.getFoodName());
              // result.success(resultMap);
               // display all nutrition details in ML screen
                System.out.println(nutritionFound.getFoodName());
                System.out.println(nutritionFound.getFoodWeight());
                System.out.println(nutritionFound.getCarbhydrateWeight());
                System.out.println(nutritionFound.getFatWeight());
                System.out.println(nutritionFound.getCalories());

                Map<String, Object> foodData = new HashMap<>();
                foodData.put("foodName", nutritionFound.getFoodName());
                foodData.put("weight", nutritionFound.getFoodWeight());
                foodData.put("carbs", nutritionFound.getCarbhydrateWeight());
                foodData.put("fat", nutritionFound.getFatWeight());
                foodData.put("protein", nutritionFound.getProtienWeight());
                foodData.put("calorie", nutritionFound.getCalories());


                result.success(foodData);
            }
        }else {
            result.notImplemented();
        }
    }

    public  String getFoodName(Bitmap image, Context mainActivity, String[] is){
        String foodName = "";
        try {

            MobilenetV110224Quant model = MobilenetV110224Quant.newInstance(mainActivity);

            Bitmap bitmapupdated =  Bitmap.createScaledBitmap(image,224,224,true);
            // Creates inputs for reference.

            TensorBuffer inputFeature0 = TensorBuffer.createFixedSize(new int[]{1, 224, 224, 3}, DataType.UINT8);

            inputFeature0.loadBuffer(TensorImage.fromBitmap(bitmapupdated).getBuffer());

            // Runs model inference and gets result.
            MobilenetV110224Quant.Outputs outputs = model.process(inputFeature0);

            TensorBuffer outputFeature0 = outputs.getOutputFeature0AsTensorBuffer();
            foodName= is[getMax(outputFeature0.getFloatArray())];

            model.close();

            // Releases model resources if no longer used.
        } catch (IOException e) {
            System.out.println("EXCEPTION--"+e.getMessage());
        }
        return foodName;

    }


    private static int getMax(float[] input){
        int maxvalue = 0;
        for(int i=0;i<input.length;i++){
        if(input[i]>input[maxvalue]){
           maxvalue=i;
        }
    }
return maxvalue;
    }


}
