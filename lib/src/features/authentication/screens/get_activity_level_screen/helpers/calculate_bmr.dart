class CalculateBMR{

  static double calculateBMR(double weight, double height, int age, String gender) {
    if (gender == 'Male') {
      return (10 * weight) + (6.25 * height) - (5 * age) + 5;
    } else {
      return (10 * weight) + (6.25 * height) - (5 * age) - 161;
    }
  }

  double calculateDailyCalorieIntake(double bmr, String activityLevel) {
    double activityMultiplier;

    switch (activityLevel) {
      case 'Sedentary Active':
        activityMultiplier = 1.2;
        break;
      case 'Lightly Active':
        activityMultiplier = 1.375;
        break;
      case 'Moderately Active':
        activityMultiplier = 1.55;
        break;
      case 'Very Active':
        activityMultiplier = 1.725;
        break;
      case 'Extra Active':
        activityMultiplier = 1.9;
        break;
      default:
        activityMultiplier = 1.0; // Default to sedentary
        break;
    }

    return bmr * activityMultiplier;
  }

}