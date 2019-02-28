import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../config/http_headers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String showText = '还没有数据';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //控制界面内容 body 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true。
      //显示 snackbar 或者 bottom sheet 的时候，需要使用当前的 BuildContext 参数调用 Scaffold.of 函数来获取 ScaffoldState 对象，
      //然后使用 ScaffoldState.showSnackBar 和 ScaffoldState.showBottomSheet 函数来显示。
      //Read more: http://blog.chengyunfeng.com/?p=1042#ixzz5gDkHKuMF
      //解决点击文本输入框时，键盘弹出文本框被覆盖问题。
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('伪造请求头'),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[                
                RaisedButton(
                  child: Text('请求数据'),
                  onPressed: _selectBest,
                ),
                Text(
                  showText,
                ),
               ],
            )),
      ),
    );
  }

  void _selectBest() {
    print('正在请求数据中-------');
      getHttp().then((value) {
        setState(() {
          showText = value['data'].toString();
        });
      });
    }
  }

  Future getHttp() async {
    Dio dio = Dio();
    dio.options.headers=hettpHeaders;
    try {
      Response response = await dio.get(
          'https://time.geekbang.org/serv/v1/column/newAll');
      print(response);
      return response.data;
    } catch (e) {
      return print(e);
    }
  }

