import 'package:flutter/material.dart';
import 'package:aluno_crud_app/services/api_service.dart';
import 'package:aluno_crud_app/models/aluno.dart';

class AddAlunoScreen extends StatefulWidget {
  @override
  _AddAlunoScreenState createState() => _AddAlunoScreenState();
}

class _AddAlunoScreenState extends State<AddAlunoScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Aluno'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Por favor, insira o email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    final aluno = Aluno(
                      nome: nomeController.text,
                      email: emailController.text,
                    );
                    await ApiService().addAluno(aluno);
                    Navigator.pop(context);
                  }
                },
                child: Text('Adicionar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
