import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController carSelectController = TextEditingController();
  String showText = '欢迎来到至尊商城，敬请期待您的选择';
  FocusNode secondTextFieldNode = FocusNode();
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
        title: Text('至尊商城'),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: carSelectController,
                  decoration: InputDecoration(
                    helperText: '请选择您的最爱',
                    hintText: '任君选用',
                  ),
                  autofocus: false,
                  focusNode: secondTextFieldNode,
                ),
                RaisedButton(
                  child: Text('随意选'),
                  onPressed: _selectBest,
                ),
                Text(
                  showText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
               ],
            )),
      ),
    );
  }

  void _selectBest() {
    print('正在根据您的选择进行挑选-------');
    String type = carSelectController.text.toString();
    if (type == '') {
      showDialog(
          context: context,
          builder: (context) {
            AlertDialog(
              title: Text('选择类型不能为空'),
            );
          });
    } else {
      getHttp(type).then((value) {
        setState(() {
          showText = value['data']['name'];
        });
      });
    }
  }

  Future getHttp(String name) async {
    Dio dio = Dio();
    try {
      Response response = await dio.get(
          'https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian',
          queryParameters: {'name': name});
      print(response);
      return response.data;
    } catch (e) {
      return e;
    }
  }
}
