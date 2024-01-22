import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_picture_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String username = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Akun'),
        backgroundColor: Color.fromARGB(255, 255, 146, 17),
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
                  'assets/images/signup.png', // Replace with the actual image path
                  height: 200.0,
                ),
                SizedBox(height: 20.0),
                Column(
                  children: [
                    Text(
                      "Buat Akun Baru",
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
                      validator: (val) =>
                          val?.isEmpty ?? true ? 'Enter an email' : null,
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
                    SizedBox(height: 20.0),
                    TextFormField(
                      onChanged: (val) {
                        setState(() => username = val);
                      },
                      validator: (val) =>
                          val?.isEmpty ?? true ? 'Enter a username' : null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        hintText: 'NamaAbsen (Contoh: Rizki23)',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            UserCredential userCredential = await _authService
                                .registerWithEmailAndPassword(email, password);
                            String? imageUrl = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePicturePage(
                                    user: userCredential.user),
                              ),
                            );
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(userCredential.user!.uid)
                                .set({
                              'username': username,
                              'imageUrl': imageUrl
                            });
                            Navigator.pop(context);
                          } catch (e) {
                            setState(() {
                              error = 'Failed to register';
                            });
                          }
                        }
                      },
                      child: Text('Register'),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 146, 17),
                        primary: Colors.white,
                        fixedSize: const Size(320, 60),
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Sudah punya akun?',
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
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: Text('Masuk'),
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
    );
  }
}
