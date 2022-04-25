// ignore_for_file: deprecated_member_use

import 'package:esoft/provider/users.dart';
import 'package:esoft/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

class UserTile extends StatefulWidget {
  final User user;

  // ignore: use_key_in_widget_constructors
  UserTile(this.user);

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  bool checkValue = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(widget.user.titulo),
        subtitle: Text(widget.user.descricao),
        trailing: Container(
          width: 120,
          child: Row(children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              color: Colors.orange,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                  arguments: widget.user,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Excluir Anotação'),
                    content: const Text('Tem certeza?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Não'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: const Text('Sim'),
                        onPressed: () {
                          Provider.of<Users>(context, listen: false)
                              .remove(widget.user);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            Row(
              children: [
                Checkbox(
                    value: checkValue,
                    onChanged: (checked) {
                      setState(() {
                        checkValue = checked!;
                      });
                    })
              ],
            )
          ]),
        ));
  }
}
