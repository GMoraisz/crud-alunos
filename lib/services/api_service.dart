import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aluno_crud_app/models/aluno.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8080/alunos';

  Future<List<Aluno>> fetchAlunos() async {
    final response = await http.get(baseUrl); // Correção aqui
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Aluno.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar alunos');
    }
  }

  Future<void> deleteAluno(int id) async {
    final response = await http.delete('$baseUrl/$id'); // Correção aqui
    if (response.statusCode != 200) {
      throw Exception('Falha ao excluir aluno');
    }
  }

  Future<void> addAluno(Aluno aluno) async {
    final response = await http.post(
      baseUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(aluno.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Falha ao adicionar aluno');
    }
  }

  Future<void> updateAluno(Aluno aluno) async {
    final response = await http.put(
      '$baseUrl/${aluno.id}', // Correção aqui
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(aluno.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar aluno');
    }
  }
}
