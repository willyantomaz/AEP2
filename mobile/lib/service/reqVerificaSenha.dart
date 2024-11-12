import 'dart:convert';
import 'package:http/http.dart' as http;

class ReqVerificaSenha {
  Future<String> verificaSenha(String password) async {
    print(password);
    final response = await http.post(
      Uri.parse('http://localhost:5000/analyze'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print('${jsonDecode(response.body)}');
      return jsonDecode(response.body).toString();
    } else {
      throw Exception('Não foi possivel testar a senha');
    }
  }

  Future<String> forcaSenha(String password) async {
    final url = Uri.parse('http://localhost:5000/predict');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['vulnerability'].toString();
    } else {
      throw Exception('Failed to verify password');
    }
  }
}
