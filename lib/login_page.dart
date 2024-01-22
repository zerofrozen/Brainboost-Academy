import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';
import 'register_page.dart';
import 'homepage.dart';
import 'forgotpassword.dart';
import 'selectloginregister.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';

  Future<bool> _onWillPop() async {
    // Navigate to choosePage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Choose()),
    );
    return false; // Prevent back navigation
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login Ke akun Anda'),
          backgroundColor: Color.fromARGB(255, 30, 144, 255),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Image.asset(
                    'assets/images/signin.png', // Replace with the actual image path
                    height: 200.0,
                  ),
                  SizedBox(height: 20.0),
                  Column(
                    children: [
                      Text(
                        "Masuk ke Akun Anda",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                        validator: (val) => val?.isEmpty ?? true
                            ? 'Kamu Belum Masukkan Email'
                            : null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          hintText: 'Email',
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                        validator: (val) => val!.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          hintText: 'Password',
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Lupa Kata Sandi?',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 30, 144, 255),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              UserCredential userCredential = await _authService
                                  .signInWithEmailAndPassword(email, password);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomePage(user: userCredential.user)),
                              );
                            } catch (e) {
                              setState(() {
                                error = 'Email / Password kamu Salah';
                              });
                            }
                          }
                        },
                        child: Text('Masuk'),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 30, 144, 255),
                          primary: Colors.white,
                          fixedSize: const Size(320, 60),
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Belum punya akun?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()),
                              );
                            },
                            child: Text(
                              'Daftar',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 146, 17),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
