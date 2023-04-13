import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CompanyLogoPicker extends StatefulWidget {
  final Function(File) onImageSelected;

  CompanyLogoPicker({required this.onImageSelected});

  @override
  _CompanyLogoPickerState createState() => _CompanyLogoPickerState();
}

class _CompanyLogoPickerState extends State<CompanyLogoPicker> {
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      widget.onImageSelected(_image!);
    }
  }

  Future getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      widget.onImageSelected(_image!);
    }
  }

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
