import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:aluno_crud_app/models/aluno.dart';

class ApiService {
  final Dio _dio = Dio();
  final String baseUrl = 'http://192.168.0.107:8080/alunos';

  Future<List<Aluno>> fetchAlunos() async {
    try {
      final response =
          await _dio.get(Uri.parse(baseUrl).toString()); // Correção aqui
      final List<dynamic> data = response.data;
      return data.map((json) => Aluno.fromJson(json)).toList();
    } on DioError catch (e) {
      throw Exception('Falha ao carregar alunos: ${e.response?.statusMessage}');
    }
  }

  Future<void> deleteAluno(int id) async {
    try {
      await _dio.delete(Uri.parse('$baseUrl/$id').toString()); // Correção aqui
    } on DioError catch (e) {
      throw Exception('Falha ao excluir aluno: ${e.response?.statusMessage}');
    }
  }

  Future<void> addAluno(Aluno aluno) async {
    try {
      final response = await _dio.post(
        Uri.parse(baseUrl).toString(), // Correção aqui
        options: Options(
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
        ),
        data: json.encode(aluno.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception('Falha ao adicionar aluno');
      }
    } on DioError catch (e) {
      throw Exception('Falha ao adicionar aluno: ${e.response?.statusMessage}');
    }
  }

  Future<void> updateAluno(Aluno aluno) async {
    try {
      final response = await _dio.put(
        Uri.parse('$baseUrl/${aluno.id}').toString(), // Correção aqui
        options: Options(
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
        ),
        data: json.encode(aluno.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Falha ao atualizar aluno');
      }
    } on DioError catch (e) {
      throw Exception('Falha ao atualizar aluno: ${e.response?.statusMessage}');
    }
  }
}
