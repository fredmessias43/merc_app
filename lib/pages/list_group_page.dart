import 'dart:math';

import 'package:flutter/material.dart';
import 'package:merc_app/components/mini_list.dart';

class ListGroupPage extends StatefulWidget {
  const ListGroupPage({Key? key}) : super(key: key);

  @override
  _ListGroupPageState createState() => _ListGroupPageState();
}

class Item {
  int id;
  String label;
  bool done;

  Item(this.id, this.label, this.done);
}

class ListGroup {
  int id;
  String name;
  List<Item>? itemsList;

  ListGroup(this.id, this.name);
}

class _ListGroupPageState extends State<ListGroupPage> {
  final _formKey = GlobalKey<FormState>();
  Random rng = Random();
  List<ListGroup> listGroupList = [];
  final myController = TextEditingController();

  void addItemToList(String name) {
    listGroupList.add(ListGroup(rng.nextInt(9999), name));
  }

  void removeItemFromList(int id) {
    listGroupList.removeWhere((item) => item.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("widget.title"),
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
                              addItemToList(myController.text);
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
              const Text(
                "Lista de listas",
                style: TextStyle(fontSize: 36),
              ),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemCount: listGroupList.length,
                      itemBuilder: (BuildContext context, index) {
                        final item = listGroupList[index];

                        return GestureDetector(
                            onTap: () {
                              debugPrint(item.name);
                            },
                            child: MiniList(listName: item.name));
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}
