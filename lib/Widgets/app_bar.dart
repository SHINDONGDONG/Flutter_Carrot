import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget appBarWidget(){
  return AppBar(
    title: GestureDetector(
      onTap: (){
        print('Click');
      },
      // onLongPress: (){
      //   print('Long press');
      // },
      child: Row(
        children: [
          Text('아라동'),
          Icon(Icons.arrow_drop_down_outlined),
        ],
      ),
    ),
    elevation: 0.0,
    actions: [
      IconButton(icon: Icon(Icons.search), onPressed: (){}),
      IconButton(icon: Icon(Icons.tune), onPressed: (){}),
      IconButton(icon: SvgPicture.asset("assets/svg/bell.svg",width: 22,), onPressed: (){}),
    ],
  );
}