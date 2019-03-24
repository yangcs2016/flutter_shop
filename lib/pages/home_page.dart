import 'package:flutter/material.dart';
import '../services/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent ='正在获取数据';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
      ),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var data=json.decode(snapshot.data.toString());
            List<Map> swiper=(data['data']['slides'] as List).cast();
            List<Map> navigatorList=(data['data']['category'] as List).cast();
            String adPicture=data['data']['advertesPicture']['PICTURE_ADDRESS'];
            return Column(
              children:<Widget>[
                SwiperDiy(swiperDataList: swiper),
                TopNavigator(navigatorList:navigatorList),
                AdBanner(adPicture:adPicture)
                ],              
            );
          } else {
            return Center(
              child: Text('加载中....'),
            );
          }
        },
      ),
    );
  }
}
//首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return Container(
            //padding: const EdgeInsets.all(4.0),
            child: Image.network("${swiperDataList[index]['image']}",fit: BoxFit.fill,),
          );          
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context,item){
    return InkWell(
      onTap: (){print('taped');},
      child: Column(
        children: <Widget>[
          Image.network(item['image'],width:ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    if(this.navigatorList.length>10){
      this.navigatorList.removeRange(10,this.navigatorList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: const EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: const EdgeInsets.all(5.0),
        children: navigatorList.map((item){
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}