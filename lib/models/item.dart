import 'dart:ui';

class Item {
  int id;
  String name;
  bool done;
  Color? color;

  Item({required this.id, required this.name, required this.done, this.color});

  Item.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        done = json['done'],
        color = Color(json['color']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'done': done, 'color': color?.value};
}
