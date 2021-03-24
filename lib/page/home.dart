
import 'package:flutter/material.dart';
import 'package:flutter_carrot/Widgets/app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}



class _HomeState extends State<Home> {
  List<Map<String,String>> datas =[];
  int _curruntPageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     datas = [
      {
        "image": "assets/images/1.jpg",
        "title": "네메시스 축구화275",
        "location": "제주 제주시 아라동",
        "price": "30000",
        "likes": "2"
      },
      {
        "image": "assets/images/2.jpg",
        "title": "LA갈비 5kg팔아요~",
        "location": "제주 제주시 아라동",
        "price": "100000",
        "likes": "5"
      },
      {
        "image": "assets/images/3.jpg",
        "title": "치약팝니다",
        "location": "제주 제주시 아라동",
        "price": "5000",
        "likes": "0"
      },
      {
        "image": "assets/images/4.jpg",
        "title": "[풀박스]맥북프로16인치 터치바 실버그레이 ",
        "location": "제주 제주시 아라동",
        "price": "2500000",
        "likes": "6"
      },
      {
        "image": "assets/images/5.jpg",
        "title": "디월트존기임팩",
        "location": "제주 제주시 아라동",
        "price": "150000",
        "likes": "2"
      },
      {
        "image": "assets/images/6.jpg",
        "title": "갤럭시s10",
        "location": "제주 제주시 아라동",
        "price": "180000",
        "likes": "2"
      },
      {
        "image": "assets/images/7.jpg",
        "title": "선반",
        "location": "제주 제주시 아라동",
        "price": "15000",
        "likes": "2"
      },
      {
        "image": "assets/images/8.jpg",
        "title": "냉장 쇼케이스",
        "location": "제주 제주시 아라동",
        "price": "80000",
        "likes": "3"
      },
      {
        "image": "assets/images/9.jpg",
        "title": "대우 미니냉장고",
        "location": "제주 제주시 아라동",
        "price": "30000",
        "likes": "3"
      },
      {
        "image": "assets/images/10.jpg",
        "title": "멜킨스 풀업 턱걸이 판매합니다.",
        "location": "제주 제주시 아라동",
        "price": "50000",
        "likes": "7"
      },
    ];
  }


  //intl 라이브러리 사용
  final oCcy = new NumberFormat('#,###',"ko_KR");
  //스트링 값의 price를 받아서 won으로 바꾸는 메소드
  String calcStringToWon(String priceString){
    return "${oCcy.format(int.parse(priceString))}원";
  }

  Widget _bodyWidget(){
    return ListView.separated( //세퍼레이트는 개별개별의 아이템마다 사이간격 라인을 손쉽게 나눌수 잇게해줌
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              ClipRRect(  //ClipRRect 로 보더레디우스 올 전체값을 레디우스 서클로 20줌
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(datas[index]["image"],height: 100,width: 100,)), //현재 datas 리스트 맵형식에 index(리스트인덱스) ("image")맵형식의 데이터를 불러옴
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20),
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(datas[index]["title"],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),),
                      SizedBox(height: 5,),
                      Text(datas[index]["location"],style: TextStyle(fontSize: 12,color: Colors.black.withOpacity(0.3)),),
                      SizedBox(height: 5,),
                      Text(calcStringToWon(datas[index]["price"]),style: TextStyle(fontWeight: FontWeight.w500),),
                      SizedBox(height: 5,),
                      Expanded(
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SvgPicture.asset("assets/svg/heart_off.svg",height: 13,width: 13,),
                              SizedBox(width: 5,),
                              Text(datas[index]["likes"]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Container(height: 1, color: Colors.black.withOpacity(0.4),);
      },
      itemCount: datas.length,
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(String iconName,String label){
    return BottomNavigationBarItem(icon: Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: SvgPicture.asset("assets/svg/${iconName}_off.svg",width: 22,),
    ),label: label);
  }
  
  Widget _bottomNavigationBarWidget(){
    return BottomNavigationBar(
      selectedFontSize: 12,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      onTap: (index) {  //탭을 눌렀을 때 몇번째 인자인지를 받고
        setState(() {
          _curruntPageIndex = index;
        });
      },
        currentIndex: _curruntPageIndex,    //현재 인덱스는 _curruntpageindex라고 지정해준다
        items: [
          _bottomNavigationBarItem("home","홈"),
          _bottomNavigationBarItem("notes","동네생활"),
          _bottomNavigationBarItem("location","내 근처"),
          _bottomNavigationBarItem("chat","채팅"),
          _bottomNavigationBarItem("user","나의 당근"),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }
}
