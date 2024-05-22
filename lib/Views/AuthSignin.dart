import 'package:flutter/material.dart';
import 'package:plantdisease/Services/Auth.dart';
import 'package:plantdisease/Views/AuthLogin.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SignInForm(),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _password = '';
  Future<bool> _signup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Map<String, String> logind = {};
      final d = <String, String>{
        'username': _username,
        'password': _password,
        'email': _email
      };

      logind.addEntries(d.entries);
      bool st = await Auth().signup(logind);
      print('Logging in with username: $_username and password: $_password');
      if (st) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Logged in successfully!')));
      }
      return st;
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Fill Data!')));
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Username'),
            onSaved: (value) {
              _username = value!;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            onSaved: (value) {
              _email = value!;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            onSaved: (value) {
              _password = value!;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: ()async {
             if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                bool s = await _signup();
                if (s) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
              }
            },
            child: Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
