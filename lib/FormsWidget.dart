import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import 'MainScreen.dart';

class FormsWidget extends StatefulWidget {
  @override
  FormsWidgetState createState() {
    return FormsWidgetState();
  }
}

class FormsWidgetState extends State<FormsWidget> {
  
  final _formKey = GlobalKey<FormState>();

  final dbHelper = DatabaseHelper.instance;

  String nome;
  String sobrenome;
  String email;
  int idade;
  double salario;
  String sexo;

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          
          Text(
            'Formulário de cadastramento:',
            style: const TextStyle(fontSize: 18.0),
          ),
          
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Nome',
            ),
            validator: (val) {
              if(val == null || val.length == 0) {
                return "Campo de preenchimento obrigatório";
              } else {
                return null;
              }
            },
            onSaved: (val) { setState(() {nome = val;}); },
          ),
          
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Sobrenome',
            ),
            onSaved: (val) { setState(() {sobrenome = val;}); },
          ),

          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
            onSaved: (val) { setState(() {email = val;}); },
          ),

          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Idade',
            ),
            validator: (val) {
              if(val == null || int.tryParse(val) == null) {
                return "Use apenas números";
              } else {
                return null;
              }
            },
            onSaved: (val) { setState(() {idade = int.parse(val);}); },
          ),

          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Salário',
            ),
            validator: (val) {
              if(val == null || double.tryParse(val.replaceAll(',', '.')) == null) {
                return "Use apenas números";
              } else {
                return null;
              }
            },
            onSaved: (val) { setState(() {salario = double.parse(val.replaceAll(',', '.'));}); },
          ),

          Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: Text('Masculino'),
                  leading: Radio(
                    value: 'Masculino',
                    groupValue: sexo,
                    onChanged: (val) {
                      setState(() {sexo = val;});
                    }
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text('Feminino'),
                  leading: Radio(
                    value: 'Feminino',
                    groupValue: sexo,
                    onChanged: (val) {
                      setState(() {sexo = val;});
                    }
                  ),
                ),
              ),
            ]
          ),
          
          RaisedButton(
            onPressed: () {
              final form = _formKey.currentState;
              if(form.validate()) {
                form.save();
                print(nome);
                print(sobrenome);
                print(email);
                print(idade);
                print(salario);
                print(sexo);
              }

              Map<String, dynamic> inputMap = {
                DatabaseHelper.columnNome: nome,
                DatabaseHelper.columnSobrenome: sobrenome,
                DatabaseHelper.columnEmail: email,
                DatabaseHelper.columnIdade: idade,
                DatabaseHelper.columnSalario: salario,
                DatabaseHelper.columnSexo: sexo,
              };
              _insert(inputMap);
              form.reset();
              _goToMainScreen();
            },
            child: Text('Cadastrar'),
          ),
        ],
      ),
    );
  }

  void _insert (Map<String, dynamic> map) async {
    final id = await dbHelper.insert(map);
    print('Row $id inserted');
  }
  
  
  void _goToMainScreen() {
    Navigator.of(this.context).push(
      MaterialPageRoute<void>(
        builder: (context) => MainScreen(),
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Cadastramento')
      ),
      
      body: Center(
        child: _buildForm(),
      ),
    );
  }
}