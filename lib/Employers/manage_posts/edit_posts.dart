import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class EditJobPosts extends StatefulWidget {
  const EditJobPosts({Key? key}) : super(key: key);

  @override
  State<EditJobPosts> createState() => _EditJobPostsState();
}

class _EditJobPostsState extends State<EditJobPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit posts'),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
