import 'package:flutter/material.dart';
import 'package:super_medic/widgets/forAuth_widget/itemClass.dart';

class ItemList extends ChangeNotifier {
  final List<Item> _items = [
    Item(data: "카카오톡", page: 'assets/images/kakao.png', isChecked: false),
    Item(data: "네이버", page: 'assets/images/naver.png', isChecked: false),
    Item(data: "통신사패스", page: 'assets/images/pass.png', isChecked: false),
    Item(data: "KB 모바일", page: 'assets/images/kb.png', isChecked: false),
    Item(data: "토스", page: 'assets/images/tos.png', isChecked: false),
    Item(data: "삼성패스", page: 'assets/images/ss.png', isChecked: false)
  ];

  Item getItem(idx) => _items[idx];

  void addItem(Item itemData) {
    _items.add(itemData);
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  void changeFalse() {
    for (var item in _items) {
      item.isChecked = false;
    }
    notifyListeners();
  }
}
