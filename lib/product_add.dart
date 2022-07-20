import 'package:flutter/material.dart';
import 'package:local_db/product.dart';

import 'dbHelper.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductAddState();
  }
}

class ProductAddState extends State {
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();
  var dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Offline Database",
            style: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              buildNameField(),
              buildDescriptionField(),
              buildUnitPriceField(),
              buildSavebutton(),
            ],
          ),
        ));
  }

  Widget buildNameField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Enter Name : ",
      ),
      controller: txtName,
    );
  }

  Widget buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Enter Description : ",
        icon: Icon(Icons.person),
      ),
      controller: txtDescription,
    );
  }

  Widget buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Enter Price : ",
      ),
      controller: txtUnitPrice,
    );
  }

  Widget buildSavebutton() {
    return FlatButton(
      child: Text(
        "Add Product",
        style: TextStyle(
            fontWeight: FontWeight.w900, fontSize: 20, color: Colors.red),
      ),
      onPressed: () {
        addProduct();
      },
    );
  }

  void addProduct() async {
    String name = txtName.text;
    // if(name.isNotEmpty){
    Product p = Product(name: txtName.text, description: txtDescription.text, unitPrice: double.parse(txtUnitPrice.text));
    var result = await dbHelper.insert(p);
     Navigator.pop(context, true);
  }
}
