import 'dart:convert';

import 'package:merc_app/models/items_list.dart';

class ListGroup {
  int id;
  String name;

  List<ItemsList> itemsLists;

  ListGroup({required this.id, required this.name, required this.itemsLists});

  ListGroup.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        itemsLists = (json['itemsLists'] as List<dynamic>)
            .map((e) => ItemsList.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'itemsLists': itemsLists};
}
