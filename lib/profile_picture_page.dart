import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePicturePage extends StatefulWidget {
  final User? user;

  ProfilePicturePage({Key? key, this.user}) : super(key: key);

  @override
  _ProfilePicturePageState createState() => _ProfilePicturePageState();
}

class _ProfilePicturePageState extends State<ProfilePicturePage> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Picture'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('Belum ada Gambar yang dipilih.')
                : ClipOval(
                    child: Image.file(
                      _image!,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickImage,
              child: Text('Pilih gambar dari Galeri'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_image != null) {
                  String imageUrl = await uploadImage();
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.user!.uid)
                      .set({'imageUrl': imageUrl});

                  Navigator.pop(context, imageUrl);
                }
              },
              child: Text('Simpan Gambar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String> uploadImage() async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_pictures')
          .child('${widget.user!.uid}.jpg');

      await ref.putFile(_image!);
      return await ref.getDownloadURL();
    } catch (e) {
      // You can show a custom error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while uploading the image.')),
      );
      throw e; // This will rethrow the exception, allowing you to handle it elsewhere if needed
    }
  }
}
