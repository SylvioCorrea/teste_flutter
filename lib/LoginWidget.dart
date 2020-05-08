import 'package:flutter/material.dart';
import 'FormsWidget.dart';
import 'MainScreen.dart';

class LoginWidget extends StatefulWidget {
  @override
  LoginWidgetState createState() {
    return LoginWidgetState();
  }
}

class LoginInput {
  String username;
  String password;
}

class LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();

  final _loginInput = LoginInput();

  bool _shoudlDisplayError = false;

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          
          Text(
            'Insira nome de usuário e senha:',
            style: const TextStyle(fontSize: 18.0),
          ),
          
          TextFormField(
            onSaved: (val) { setState(() {_loginInput.username = val;}); },
          ),
          
          TextFormField(
            onSaved: (val) { setState(() {_loginInput.password = val;}); },
          ),
          
          if(_shoudlDisplayError)
            Text('Usuário e/ou senha inválidos', style: TextStyle(color: Colors.red)),
          
          RaisedButton(
            onPressed: () {
              final form = _formKey.currentState;
              form.save();
              
              if(_loginInput.username == 'DWU' && _loginInput.password == 'DWU') {
                
                print('logged in');
                setState( () {
                  _shoudlDisplayError = false;
                });
                
                _goToFormScreen();
              
              } else {
                
                print('login failed');
                setState( () {
                  _shoudlDisplayError = true;
                });

              }
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }

  void _goToFormScreen() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => MainScreen(),
      )
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login')),
      ),
      body: _buildForm(),
    );
  }
}