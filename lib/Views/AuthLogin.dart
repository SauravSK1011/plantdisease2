import 'package:flutter/material.dart';
import 'package:plantdisease/Services/Auth.dart';
import 'package:plantdisease/Views/AuthSignin.dart';
import 'package:plantdisease/Views/HomePage.dart';
import 'package:plantdisease/Widgets/appbar.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(context),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  Future<bool> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Map<String, String> logind = {};
      final d = <String, String>{'username': _username, 'password': _password};

      logind.addEntries(d.entries);
      bool st = await Auth().login(logind);
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

  bool? st = false;

  getst() async {
    st = await Auth().presentloginornot();
    if (st!) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  }

  @override
  void initState() {
    getst();
    super.initState();
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
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                bool s = await _login();
                if (s) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                }
              }
            },
            child: Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
            child: Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
