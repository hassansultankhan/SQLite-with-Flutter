import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_db/product.dart';

import 'dbHelper.dart';


class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductDetailState(product);
  }
}

enum Options { delete, update , search }

class _ProductDetailState extends State {
  Product product;
  _ProductDetailState(this.product);
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    txtName.text = product.name;
    txtDescription.text = product.description;
    txtUnitPrice.text = product.unitPrice.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product : ${product.name}",
          style: TextStyle(
              fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("Delete"),
              ),
              PopupMenuItem<Options>(
                value: Options.update,
                child: Text("Update"),
              ),
            ],
          )
        ],
      ),
      body: buildProductDetail(),
    );
  }

  Widget buildProductDetail() {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          buildNameField(),
          buildDescriptionField(),
          buildUnitPriceField(),
        ],
      ),
    );
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
      ),
      controller: txtDescription,
    );
  }

  Widget buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Enter Price: ",
      ),
      controller: txtUnitPrice,
    );
  }

  void selectProcess(Options options) async {
    //print(value);
    switch (options) {
      case Options.delete:
        await dbHelper.delete(product.id);
        Navigator.pop(context, true);
        break;
      case Options.update:
        await dbHelper.update(Product.withId(
            id: product.id,
            name: txtName.text,
            description: txtDescription.text,
            unitPrice: double.parse(txtUnitPrice.text)));
        Navigator.pop(context, true);
        break;
      default:
    }
  }
}
