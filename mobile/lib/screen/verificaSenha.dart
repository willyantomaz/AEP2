import 'package:flutter/material.dart';
import 'package:mobile/screen/dialogResponse.dart';
import 'package:mobile/service/reqVerificaSenha.dart';

class Vericasenha extends StatefulWidget {
  const Vericasenha({super.key});

  @override
  State<Vericasenha> createState() => _VericasenhaState();
}

class _VericasenhaState extends State<Vericasenha> {
  final _formKey = GlobalKey<FormState>();

  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coloque a senha para testar a sua força'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                onSaved: (value) => password = value,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print(password);
                    String response =
                        await ReqVerificaSenha().verificaSenha(password!);
                    String forte =
                        await ReqVerificaSenha().forcaSenha(password!);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialogresponse(
                              response: response, forte: forte);
                        });
                  }
                },
                child: const Text('Verificar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
