import 'dart:math';

import 'package:flutter/material.dart';
import 'package:merc_app/models/item.dart';
import 'package:merc_app/models/items_list.dart';

import '../utils/get_color.dart';

class ListPage extends StatefulWidget {
  final ItemsList itemsList;

  const ListPage({Key? key, required this.itemsList}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Random rng = Random();
  final myController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void fillItemsList() {
    for (var i = 0; i < 10; i++) {
      int rand = rng.nextInt(9999);
      setState(() {
        widget.itemsList.items.add(Item(id: rand, name: rand.toString(), done: false,
            color: getColor(widget.itemsList.items.length)));
      });
    }
  }

  void addItemToList(value) {
    widget.itemsList.items.add(Item(id: rng.nextInt(9999), name: value, done: false,
        color: getColor(widget.itemsList.items.length)));
  }

  void removeItemFromList(int id) {
    widget.itemsList.items.removeWhere((item) => item.id == id);
  }

  void toggleItemAsDone(int id) {
    final int index =
        widget.itemsList.items.indexWhere((item) => item.id == id);

    widget.itemsList.items[index].done = !widget.itemsList.items[index].done;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => fillItemsList(),
          child: const Icon(Icons.format_color_fill)),
      appBar: AppBar(
        title: Text(widget.itemsList.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
              context,
              widget.itemsList,
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
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
                          child: const Text("Adicionar")),
                    )
                  ])),
              Expanded(
                  child: SizedBox(
                height: 100.0,
                child: ListView.builder(
                  //reverse: true,
                  //cacheExtent: 15,
                  //addAutomaticKeepAlives: false,

                  scrollDirection: Axis.vertical,
                  itemCount: widget.itemsList.items.length,
                  itemBuilder: (item, index) {
                    final item =
                        widget.itemsList.items.reversed.toList()[index];

                    return Container(
                      height: 50,
                      color: item.color,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.name,
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
