import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project1/profile/try.dart';
import 'dart:io';
import '../models/job_seeker_profile_model.dart';

class profilePicture extends StatefulWidget {
  static const routeName = '/profilePicture';
  const profilePicture({Key? key}) : super(key: key);

  @override
  State<profilePicture> createState() => _profilePictureState();
}

class _profilePictureState extends State<profilePicture> {
  late PickedFile _imageFile;
  final ImagePicker Picker = ImagePicker();
  File imageFile = new File('');
  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text('choose profile picture'),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                  onPressed: () => takePhoto(ImageSource.camera),
                  icon: Icon(Icons.camera),
                  label: Text('Camera')),
              TextButton.icon(
                  onPressed: () => takePhoto(ImageSource.gallery),
                  icon: Icon(Icons.image),
                  label: Text('Gallery')),
            ],
          )
        ],
      ),
    );
  }

  Widget imageProfile(BuildContext ctx) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 80,
          backgroundImage: imageFile == null
              ? AssetImage('assets/profile.png') as ImageProvider
              : FileImage(File(imageFile.path)),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Builder(builder: (context) {
            return InkWell(
              // onTap: () => showBottomSheet(
              //     onClosing: () {}, builder: (context) => bottomSheet()),
              onTap: () => Scaffold.of(context)
                  .showBottomSheet((context) => bottomSheet()),
              // onTap: () {
              //   showBottomSheet(
              //       context: context, builder: (ctx) => bottomSheet());
              // },
              child: Icon(
                color: Colors.white,
                Icons.camera_alt,
                size: 25,
              ),
            );
          }),
        )
      ],
    );
  }

  void takePhoto(ImageSource source) async {
    final _PickedFile = await Picker.pickImage(source: source);
    if (_PickedFile == null) return null;
    setState(() {
      _imageFile = _PickedFile as PickedFile;
      imageFile = File(_imageFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Upload profile'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Upload your profile'),
              imageProfile(context),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MyWidget()));
                  },
                  child: Text('Finish profile'))
            ],
          ),
        ));
  }
}
