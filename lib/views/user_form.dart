import 'package:esoft/models/user.dart';
import 'package:esoft/provider/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User? user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['titulo'] = user.titulo;
      _formData['descricao'] = user.descricao;
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final user = ModalRoute.of(context)!.settings.arguments as User?;
    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Anotações'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState?.validate();

              if (isValid!) {
                _form.currentState?.save();

                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'].toString(),
                    titulo: _formData['titulo'].toString(),
                    descricao: _formData['descricao'].toString(),
                  ),
                );

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _formData['titulo'],
                  decoration: const InputDecoration(labelText: 'Título'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Titulo inválido';
                    }
                    if (value.trim().length < 3) {
                      return 'Titulo muito pequeno. Minimo 3 letras.';
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['titulo'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['descricao'],
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  onSaved: (value) => _formData['descricao'] = value!,
                ),
              ],
            )),
      ),
    );
  }
}
