class CaloriesDaily {
  final String foodName;
  final double weight;
  final double calories;
  final String date;
  final String emailId;
  final String meal;
  final String image;
  final double protein;
  final double carbohydrate;
  final double fat;
  final bool consumed;

  CaloriesDaily({
    required this.foodName,
    required this.weight,
    required this.calories,
    required this.date,
    required this.emailId,
    required this.meal,
    required this.image,
    required this.protein,
    required this.carbohydrate,
    required this.fat,
    required this.consumed,
  });

  factory CaloriesDaily.fromJson(Map<String, dynamic> json) {
    return CaloriesDaily(
      foodName: json['foodName'],
      weight: json['weight'],
      calories: json['calories'],
      date: json['date'],
      emailId: json['emailId'],
      meal: json['meal'],
      image: json['image'],
      protein: json['protein'],
      carbohydrate: json['carbohydrate'],
      fat: json['fat'],
      consumed: json['consumed'],
    );
  }
}
