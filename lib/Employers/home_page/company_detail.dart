import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class company_detail extends StatefulWidget {
  const company_detail({Key? key}) : super(key: key);

  @override
  State<company_detail> createState() => _company_detailState();
}

class _company_detailState extends State<company_detail> {
  String randomText =
      '   Porttitor eget dolor morbi non arcu risus. Eget arcu dictum varius duis at consectetur lorem. Velit sed ullamcorper morbi tincidunt ornare massa. At volutpat diam ut venenatis tellus. Tortor at auctor urna nunc id cursus metus aliquam eleifend. Amet commodo nulla facilisi nullam vehicula ipsum a. Vitae nunc sed velit dignissim sodales ut eu. Facilisis leo vel fringilla est ullamcorper. Faucibus scelerisque eleifend donec pretium vulputate sapien nec sagittis. Tempus egestas sed sed risus pretium quam vulputate dignissim suspendisse. Arcu non odio euismod lacinia at quis risus. Ante metus dictum at tempor commodo ullamcorper a lacus vestibulum. Ut placerat orci nulla pellentesque dignissim. Sed nisi lacus sed viverra tellus in. Posuere morbi leo urna molestie at elementum eu. Nibh sit amet commodo nulla facilisi nullam vehicula ipsum a. Non nisi est sit amet facilisis magna etiam tempor orci. Posuere sollicitudin aliquam ultrices sagittis orci a scelerisque purus semper. Mauris in aliquam sem fringilla ut morbi. Vitae nunc sed velit dignissim sodales ut eu. Dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Urna molestie at elementum eu facilisis sed odio morbi quis. Odio ut sem nulla pharetra diam. Nam libero justo laoreet sit amet. Mauris in aliquam sem fringilla ut morbi. Massa tincidunt nunc pulvinar sapien et. A lacus vestibulum sed arcu non odio euismod lacinia. Maecenas volutpat blandit aliquam etiam. Nunc sed id semper risus. Vel pharetra vel turpis nunc eget lorem dolor. Tellus rutrum tellus pellentesque eu tincidunt. Cum sociis natoque penatibus et. Sapien nec sagittis aliquam malesuada bibendum. Nulla posuere sollicitudin aliquam ultrices sagittis orci a. Massa vitae tortor condimentum lacinia quis. Odio tempor orci dapibus ultrices in iaculis nunc. Eu augue ut lectus arcu bibendum. Eu consequat ac felis donec et odio. Auctor neque vitae tempus quam pellentesque nec nam. Venenatis lectus magna fringilla urna porttitor rhoncus dolor purus. Lorem ipsum dolor sit amet consectetur adipiscing. Justo eget magna fermentum iaculis eu non diam phasellus vestibulum. Egestas integer eget aliquet nibh. Est ullamcorper eget nulla facilisi etiam dignissim. Feugiat in ante metus dictum.';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(randomText),
        ),
      ],
    );
  }
}
