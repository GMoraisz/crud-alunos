import 'package:flutter/material.dart';
import 'package:aluno_crud_app/services/api_service.dart';
import 'package:aluno_crud_app/models/aluno.dart';

class EditAlunoScreen extends StatefulWidget {
  final Aluno aluno;

  EditAlunoScreen({this.aluno});

  @override
  _EditAlunoScreenState createState() => _EditAlunoScreenState();
}

class _EditAlunoScreenState extends State<EditAlunoScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nomeController;
  TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.aluno?.nome ?? '');
    emailController = TextEditingController(text: widget.aluno?.email ?? '');
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Aluno'),
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
                      id: widget.aluno.id,
                      nome: nomeController.text,
                      email: emailController.text,
                    );
                    await ApiService().updateAluno(aluno);
                    Navigator.pop(context);
                  }
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
