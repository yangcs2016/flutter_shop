import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import './pages/index_page.dart';

void main(){
  //debugPaintSizeEnabled = true;
  //debugPaintBaselinesEnabled = true;
  //debugPaintPointersEnabled = true;
  runApp(MyApp());
}  

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        //去掉调试的debug标识
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
           primarySwatch: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}


