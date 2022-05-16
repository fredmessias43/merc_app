import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:merc_app/components/mini_list.dart';
import 'package:merc_app/components/new_list_group_dialog.dart';
import 'package:merc_app/models/item.dart';
import 'package:merc_app/models/items_list.dart';
import 'package:merc_app/models/list_group.dart';
import 'package:merc_app/pages/list_page.dart';
import 'package:merc_app/services/storage.dart';

class ListGroupPage extends StatefulWidget {
  const ListGroupPage({Key? key}) : super(key: key);

  @override
  _ListGroupPageState createState() => _ListGroupPageState();
}

class _ListGroupPageState extends State<ListGroupPage> {
  Random rng = Random();

  late ListGroup group;
  String encoded = "";
  Storage storage = Storage();

  void addItemsList(String name) {
    group.itemsLists
        .add(ItemsList(id: rng.nextInt(9999), name: name, items: []));
  }

  void removeListGroup(int id) {
    group.itemsLists.removeWhere((item) => item.id == id);
  }

  void updateListGroup(ItemsList list) {
    group.itemsLists[
        group.itemsLists.indexWhere((element) => element.id == list.id)] = list;
    debugPrint('${group.itemsLists}');
  }

  void serialize() {
    setState(() {
      encoded = jsonEncode(group);
    });
    storage.writeData(encoded);
  }

  void deserialize() {
    storage.readData().then((String value) {
      setState(() {
        encoded = value;

        Map<String, dynamic> json = jsonDecode(value);

        /* var auxGroup = ListGroup.fromJson(json);
        if (auxGroup.itemsLists.isNotEmpty) {
          group = auxGroup;
        } */
        group = ListGroup.fromJson(json);
      });
    });
  }

  @override
  void initState() {
    group = ListGroup(id: 0, name: "Nome da aplicação", itemsLists: []);
    deserialize();
    super.initState();
  }

  @override
  void dispose() {
    serialize();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(group.name), actions: [
          IconButton(onPressed: serialize, icon: const Icon(Icons.save)),
        ]),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return NewListGroupDialog(
                      onConfirm: (text) => {
                            setState(() {
                              addItemsList(text);
                            })
                          });
                })
          },
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, top: 8),
          child: Column(
            children: <Widget>[
              /* Row(
                children: [
                  ElevatedButton(
                      onPressed: serialize, child: const Text("Serializar")),
                  ElevatedButton(
                      onPressed: deserialize,
                      child: const Text("Deserializar")),
                ],
              ), */
              const Text(
                "Lista de listas",
                style: TextStyle(fontSize: 36),
              ),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 1,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemCount: group.itemsLists.length,
                      itemBuilder: (BuildContext context, index) {
                        final item = group.itemsLists[index];

                        return GestureDetector(
                            onTap: () {
                              final Future res = Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ListPage(itemsList: item);
                              }));
                              res.then((value) {
                                debugPrint(value.toString());
                                setState(() {
                                  updateListGroup(value);
                                });
                              });
                            },
                            child: MiniList(list: item));
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}
