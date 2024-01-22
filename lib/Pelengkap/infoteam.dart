import 'package:flutter/material.dart';

class info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Pengembang'),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Image.asset(
          'assets/images/info2.png', // Ganti dengan path gambar yang diinginkan
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
