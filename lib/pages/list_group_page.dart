import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:merc_app/components/mini_list.dart';
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
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
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

        debugPrint("ItemsList.fromJson(json['itemsLists']).toString()");
        group = ListGroup.fromJson(json);
      });
    });
  }

  @override
  void initState() {
    group = ListGroup(id: 0, name: "Nome da aplicação", itemsLists: []);
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
        appBar: AppBar(
          title: Text(group.name),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: SizedBox(
                      height: 100,
                      child: Column(
                        children: <Widget>[
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text(
                                  'Escreva o nome da lista a ser criada:',
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: myController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Fechar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Criar'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            //_formKey.currentState!.save();
                            setState(() {
                              addItemsList(myController.text);
                              myController.clear();
                            });
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ],
                  );
                })
          },
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, top: 8),
          child: Column(
            children: <Widget>[
              ElevatedButton(
                  onPressed: serialize, child: const Text("Serializar")),
              ElevatedButton(
                  onPressed: deserialize, child: const Text("Deserializar")),
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
