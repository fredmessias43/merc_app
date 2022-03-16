import 'package:merc_app/models/item.dart';

class ItemsList {
  int id;
  String name;
  List<Item> items;

  ItemsList({required this.id, required this.name, required this.items});
}
