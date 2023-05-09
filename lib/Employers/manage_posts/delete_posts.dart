import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DeleteJobPosts extends StatefulWidget {
  const DeleteJobPosts({Key? key}) : super(key: key);

  @override
  State<DeleteJobPosts> createState() => _DeleteJobPostsState();
}

class _DeleteJobPostsState extends State<DeleteJobPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete posts'),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
