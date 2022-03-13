import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:merc_app/models/items_list.dart';
import 'package:merc_app/utils/getColor.dart';

class MiniList extends StatefulWidget {
  final ItemsList list;

  const MiniList({Key? key, required this.list}) : super(key: key);

  @override
  _MiniListState createState() => _MiniListState();
}

class _MiniListState extends State<MiniList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.topCenter,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    // ignore: unnecessary_string_interpolations
                    '${widget.list.name}',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: widget.list.items.length,
                      itemBuilder: (item, index) {
                        final item = widget.list.items.reversed.toList()[index];

                        return Container(
                          color: getColor(index),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 2, bottom: 2, left: 4, right: 100),
                            child: Text(
                              item.name,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
