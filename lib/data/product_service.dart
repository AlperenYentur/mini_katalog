import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/product.dart';

Future<List<Product>> urunleriYukle() async {
  String metin = await rootBundle.loadString('assets/data/products.json');
  List liste = jsonDecode(metin);

  List<Product> urunler = [];
  for (var eleman in liste) {
    urunler.add(Product.fromJson(eleman));
  }
  return urunler;
}
