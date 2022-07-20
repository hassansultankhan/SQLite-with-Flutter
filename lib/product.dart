import 'dart:math';
class Product {
  int id  = 0;
  String name = "";
  String description = "";
  double unitPrice = 0.0;

  Product({ required this.name, required this.description, required this.unitPrice});
  Product.withId({required  this.id,   required this.name,   required this.description,   required this.unitPrice});


  // To save your data in Database
    Map<String, dynamic> toKeyValue() {
    var map = Map<String, dynamic>();
    map["name"] = name;
    map["description"] = description;
    map["unitPrice"] = unitPrice;
    if (id != null) {
      map["id"] = Random().nextInt(1000000);
    }

    return map;
  }

  // TO get data from Database


  Product.fromKeyValue(dynamic o) {
    this.id = int.parse(o["id"].toString());
    this.name = o["name"];
    this.description = o["description"];
    this.unitPrice = double.parse(o["unitPrice"].toString());
  }

   a(){
    var urun = new Product(name: "Laptop", description: "Aciklama", unitPrice: 2500);

    var keyVal = urun.toKeyValue();

    Product p = Product.fromKeyValue(keyVal);
  }

}
