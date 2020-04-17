class Product {
  final int id;
  final String name;
  final String package;
  final String unit;
  final double unitsPerPackage;
  final double pricePerUnit;
  final List<String> images;

  Product(this.id, this.name, this.package, this.unit, this.unitsPerPackage, this.pricePerUnit, this.images);

  String getPriceLabel() {
    return pricePerUnit.toInt().toString() + " руб. за " + unit;
  }

  toJson() {
    return {
      "id": id,
      "name": name,
      "package": package,
      "unit": unit,
      "unitsPerPackage": unitsPerPackage,
      "pricePerUnit": pricePerUnit,
      "images": images,
    };
  }

  static Product fromJson(json) {
    List<String> images = [];
    (json['images'] as List).forEach((value) {
      images.add(value as String);
    });
    return Product(
        json['id'], json['name'], json['package'], json['unit'], json['unitsPerPackage'], json['pricePerUnit'], images);
  }
}
