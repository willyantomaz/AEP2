import 'package:flutter/material.dart';
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
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                onSaved: (value) => password = value,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print(password);
                    ReqVerificaSenha().verificaSenha(password!);
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
