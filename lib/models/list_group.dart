import 'package:merc_app/models/items_list.dart';

class ListGroup {
  int id;
  String name;

  List<ItemsList>? itemsLists;

  ListGroup(this.id, this.name, this.itemsLists);
}
