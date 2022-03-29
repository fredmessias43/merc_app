import 'dart:convert';

import 'package:merc_app/models/item.dart';

class ItemsList {
  int id;
  String name;
  List<Item> items;

  ItemsList({required this.id, required this.name, required this.items});

  ItemsList.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        items = (json['items'] as List<dynamic>)
            .map((e) => Item.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'items': items};
}
