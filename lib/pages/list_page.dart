import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/getColor.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class Item {
  int id;
  String label;
  bool done;

  Item(this.id, this.label, this.done);
}

class _ListPageState extends State<ListPage> {
  Random rng = Random();
  List<Item> itemsList = [];
  final myController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void fillItemsList() {
    for (var i = 0; i < 1000; i++) {
      int rand = rng.nextInt(9999);
      setState(() {
        itemsList.add(Item(rand, rand.toString(), false));
      });
    }
  }

  void addItemToList(value) {
    itemsList.add(Item(rng.nextInt(9999), value, false));
  }

  void removeItemFromList(int id) {
    itemsList.removeWhere((item) => item.id == id);
  }

  void toggleItemAsDone(int id) {
    final int index = itemsList.indexWhere((item) => item.id == id);

    itemsList[index].done = !itemsList[index].done;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => fillItemsList(),
          child: const Icon(Icons.format_color_fill)),
      appBar: AppBar(
        title: const Text("Pagina da lista de items"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Adicione os itens que irá comprar no mercado:',
              ),
              Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
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
                    ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            //debugPrint(_formKey.toString());

                            setState(() {
                              addItemToList(myController.text);
                              myController.clear();
                            });
                          }
                        },
                        child: const Text("Adicionar"))
                  ])),
              Expanded(
                  child: SizedBox(
                height: 100.0,
                child: ListView.builder(
                  //reverse: true,
                  //cacheExtent: 15,
                  //addAutomaticKeepAlives: false,

                  scrollDirection: Axis.vertical,
                  itemCount: itemsList.length,
                  itemBuilder: (item, index) {
                    final item = itemsList.reversed.toList()[index];

                    return Container(
                      height: 50,
                      color: getColor(index),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.label,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  decoration: item.done
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  decorationThickness: 3.0),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        toggleItemAsDone(item.id);
                                      });
                                    },
                                    icon: Icon(
                                        !item.done ? Icons.done : Icons.close)),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        removeItemFromList(item.id);
                                      });
                                    },
                                    icon: const Icon(Icons.delete)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
