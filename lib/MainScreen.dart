import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import 'FormsWidget.dart';

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  
  final _dbHelper = DatabaseHelper.instance;

  Widget _buildDbEntries() {
    return FutureBuilder<List<Map<String, dynamic>>> (
      future: _dbHelper.queryAllRows(),
      initialData: List<Map<String, dynamic>>(),
      builder: (context, snapshot) {
        if(snapshot.hasData && snapshot.data.length > 0) {
          return _buildDbEntriesAux(snapshot.data);
        } else {
          return Text('Acessando o banco de dados');
        }
      },
    );
  }

  Widget _buildDbEntriesAux(dataList) {
    return Expanded(
      child: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, i) {
          //return ListTile(title:Text(dataList[i]['nome']));
          return Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: _buildRow(dataList[i]),
            ),
          );
        },
      )
    );
  }

  Widget _buildRow(data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nome: ' + data['nome']),
        Text('Sobrenome: ' + data['sobrenome']),
        Text('Email: ' + data['email']),
        Text('Idade: ' + data['idade'].toString()),
        Text('Salário: ' + data['salario'].toString()),
        Text('Sexo: ' + data['sexo']),
      ]
    );
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      


      appBar: AppBar(
        title: Text('Cadastro')
      ),
      
      body: Column(
        children: [
          
          Center(
            child: RaisedButton(
              child: Text('Inserir No cadastro'),
              onPressed: () {
                print('pressed');
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => FormsWidget(),
                  )
                );
              },
            ),
          ),

          _buildDbEntries(),


        ],
      ),
    );
  }


}