import 'package:flutter/material.dart';
import 'auth_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lupa Kata Sandi'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 80.0),
              Image.asset(
                'assets/images/reset_password.png',
                height: 200.0,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                onChanged: (val) {
                  setState(() => email = val);
                },
                validator: (val) =>
                    val?.isEmpty ?? true ? 'Masukkan Email Kamu' : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  hintText: 'Masukkan Email',
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await _authService.sendPasswordResetEmail(email);
                      setState(() {
                        message =
                            'Periksa email Kamu untuk tautan Reset kata sandi';
                      });
                    } catch (e) {
                      setState(() {
                        message = 'An error occurred, please try again';
                      });
                    }
                  }
                },
                child: Text('Submit Email Kamu'),
              ),
              Text(
                message,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
