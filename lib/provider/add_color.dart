import 'package:demoapp/provider/model.dart';
import 'package:flutter/material.dart';

class AddColor extends ChangeNotifier {
  List<ColorRow> items = [];
  List<ColorRow> get _items => items;
  List<Items> data = [];

  void addRow(ColorRow data) {
    items.add(data);
    print(items);
    notifyListeners();
  }

  void deleteRow(index) {
    items.removeAt(index);
    notifyListeners();
  }

  int getLength(index) {
    int length = 0;
    for (int i = 0; i > data[index].colorRow.length; i++) {
      length = length + int.parse(data[index].colorRow[i].value);
      print(length);
      print('data');
    }
    return length;
  }

  void addData(int Value) {
    Items lastitem = Items(items.toList(), Value);
    print(lastitem.colorRow.length);
    data.add(lastitem);
    items.clear();
    print(data);
    notifyListeners();
  }
}
