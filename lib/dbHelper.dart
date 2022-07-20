import 'dart:async';
import 'dart:io';

import 'package:local_db/product.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DbHelper {
  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();

  factory DbHelper() => instance;

  static late Database _db;

  Future<Database> get db async {
    _db = await initializeDb();
    return _db;
  }

  // Creation of & Db
  Future<Database> initializeDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = await getDatabasesPath();
    String dbPath = join(await documentDirectory.path, "product.db");
    var eTradeDb = await openDatabase(dbPath, version: 1, onCreate: createTable);
    return eTradeDb;
  }

  // Creation of Tablle
  FutureOr<void> createTable(Database db, int version) async {
    await db.execute(
        "Create table products("
            "id integer primary key, "
            "name text, "
            "description text, "
            "unitPrice integer)");
  }

  Future<List> getProducts() async {
    Database db = await this.db;
    //get all data from database without any filter
    List<String> col = ['name' , 'unitPrice'];

    var result = await db.query("products" , columns: col , where: "unitPrice > ? AND unitPrice < ?" , whereArgs: ['500' , '1000']);
    //return result;


    // Another Method to fetch all product and generate list
    // List<Product> allProdocuts = [];
    // for(int i = 0 ; i < result.length ;i++){
    //   Product temp = Product.fromKeyValue(result[i]);
    //   allProdocuts.add(temp);
    // }
    // return allProdocuts;


    return List.generate(result.length, (i) {
      return Product.fromKeyValue(result[i]);});
  }

  Future<int> insert(Product product) async {
    Database db = await this.db;
    var result = await db.insert("products", product.toKeyValue());
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from products where id= $id");
    return result;
  }

  Future<int> update(Product product) async {
    Database db = await this.db;
    var result = await db.update("products", product.toKeyValue(),
        where: "id=?", whereArgs: [product.id]);
    return result;
  }
}
