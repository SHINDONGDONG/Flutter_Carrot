import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carrot/components/manor_temperat_widget.dart';

class DetailContentView extends StatefulWidget {
  Map<String,String> data;

  DetailContentView(this.data);

  @override
  _DetailContentViewState createState() => _DetailContentViewState();

}

class _DetailContentViewState extends State<DetailContentView> {
  Size size;
  List<Map<String,String>> imgList;
  int _current;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _current = 0;
    size = MediaQuery.of(context).size;
    imgList = [
      {"id" : "0", "url" : widget.data["image"]},
      {"id" : "1", "url" : widget.data["image"]},
      {"id" : "2", "url" : widget.data["image"]},
      {"id" : "3", "url" : widget.data["image"]},
      {"id" : "4", "url" : widget.data["image"]},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,  //body 이하로 확장하겠다는
        appBar: appBarWidget(),
        body: _bodyWidget(),
        bottomNavigationBar: _bottomNavigation(),
      ),
    );
  }
  
  Widget _bottomNavigation(){
    return Container(
      width: size.width,
      height: 55,
      color: Colors.red,
    );
  }

  Widget appBarWidget(){
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: Colors.white
      ),
      elevation: 0.0,
      actions: [
        IconButton(icon: Icon(Icons.share), onPressed: () {}),
        IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
      ],
    );
  }

  Widget _makeSilderImage(){
    return Container(
      child: Stack(
        children: [
          Hero(        //Hero로 왔다갔다할 때 이미지가 스타일리쉬적으로 넘어갈수잇게
            tag: widget.data["cid"],  //데이터에서 추가한 cid로 판별
            child: CarouselSlider(      //캐러설 슬라이드 패키지적용
              items: imgList.map((map){       //이미지 리스트를 맵으로 돌려서 하나씩 빼옴   //itmes = 슬라이드를 보여줄 이미지
                return Image.asset(map["url"],
                  width: size.width,
                  fit: BoxFit.fill,
                );
              }).toList(),                   //리스트는 항상 toList로 빼줘야함
              options: CarouselOptions(
                height: size.width,        //height는 width의 크기만큼 오라고 width사이즈를줌
                initialPage: 0,            //기본페이지는 0번
                enableInfiniteScroll: true, //사진 스크롤이 무한으로 넘어가는것을 막음
                viewportFraction: 1,          //1로 두게되면 화면사이즈를 1로차지함.
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
            // child:
          ),
          Positioned(
            bottom: 0,
            left: 0,         // 렣프트 라이트 0을 사용하면 오른쪽 왼쪽 다사용하게되어서 가운데로감!!!
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.map((map){
                return Container(
                  height: 10.0,
                  width : 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,                //BoxDecoration 인디케이터 만들때 박스쉐이프 써클로만들자!!
                    color: _current == int.parse(map["id"])
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),

                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
  Widget _sellerSimpleInfo(){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/user.png"),
            radius: 25,
          ),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('개발하는남자',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              Text('제주도 도담시',style: TextStyle(fontSize: 13),),
            ],
          ),
          Expanded(child: ManorTemperature(manorTemp: 37.5,)),

        ],
      ),
    );
  }

Widget _bodyWidget(){
  return Column(
    children: [
      _makeSilderImage(),
      _sellerSimpleInfo(),
    ],
  );
  }
}