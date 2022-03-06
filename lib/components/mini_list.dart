import 'package:flutter/material.dart';

class MiniList extends StatefulWidget {
  final String listName;

  const MiniList({Key? key, required this.listName}) : super(key: key);

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
                    widget.listName,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.only(
                          top: 2, bottom: 2, left: 4, right: 100),
                      child: Text(
                        "Item 1",
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  )
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
