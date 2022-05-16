import 'package:flutter/material.dart';

class NewListGroupDialog extends StatelessWidget {
  NewListGroupDialog({Key? key, required this.onConfirm}) : super(key: key);

  final void Function(String text) onConfirm;

  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              onConfirm(myController.text);
              myController.clear();
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
