class PointModel {

  final String productName;
  final String brand;
  final int point;
  final String date;

  PointModel({
    required this.productName,
    required this.brand,
    required this.point,
    required this.date,
  });

  PointModel copyWith({String? productName, String? brand, int? point, String? date}) {
    return PointModel(
      productName: productName ?? this.productName,
      brand: brand ?? this.brand,
      point: point ?? this.point,
      date: date ?? this.date,
    );
  }

}