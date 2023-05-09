import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyLogoPicker extends StatefulWidget {
  final void Function(File) onImageSelected;

  CompanyLogoPicker({required this.onImageSelected});

  @override
  _CompanyLogoPickerState createState() => _CompanyLogoPickerState();
}

class _CompanyLogoPickerState extends State<CompanyLogoPicker> {
  File? _image;
  String? imageUrl;
  final ImagePicker _picker = ImagePicker();

  Future getImageFromCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      widget.onImageSelected(_image!);
      print(_image);
    }
  }

  Future getImageFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      widget.onImageSelected(_image!);
      print('your image path is :${_image}');
      // widget.onImageSelected(_image);
    }
  }

  _upload() async {
    Reference storage =
        FirebaseStorage.instance.ref().child("images/${_image!.path}");
    if (_image != null) storage.putFile(_image!);
  }

  // String? _uploadedFileURL;

  // Future<void> _uploadFile() async {
  //   final FirebaseStorage storage = FirebaseStorage.instance;
  //   final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   final Reference reference = storage.ref().child('images/$fileName');
  //   final UploadTask uploadTask = reference.putFile(_image!);
  //   final TaskSnapshot downloadUrl = (await uploadTask);
  //   final String url = (await uploadTask.snapshot.ref.getDownloadURL());
  //   setState(() {
  //     _uploadedFileURL = url;
  //   });
  //   widget.onImageSelected(_image!, _uploadedFileURL);
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text('Company Logo'),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SafeArea(
                  child: Container(
                    child: Wrap(
                      children: [
                        ListTile(
                          leading: Icon(Icons.camera_alt),
                          title: Text('Take a photo'),
                          onTap: () {
                            getImageFromCamera();
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.photo_library),
                          title: Text('Choose from gallery'),
                          onTap: () {
                            getImageFromGallery();
                            //_upload();
                            // _uploadFile();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: _image == null
                ? Icon(Icons.add_a_photo, color: Colors.grey[400])
                : Image.file(_image!, fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}
