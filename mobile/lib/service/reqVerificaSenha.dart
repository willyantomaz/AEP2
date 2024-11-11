import 'dart:convert';
import 'package:http/http.dart' as http;

class ReqVerificaSenha {
  Future<void> verificaSenha(String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/verificaSenha'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print('Senha forte');
    } else {
      print('Senha fraca');
    }
  }
}
