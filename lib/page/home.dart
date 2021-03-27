import 'package:flutter/material.dart';
import 'package:flutter_carrot/page/detail.dart';
import 'package:flutter_carrot/repository/contents_repository.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ContentsRepository contentsRepository;
  String _curruntLocation;
  final Map<String, String> locationTypeToString = { //밑에서 value를 키로 받은다음
    "ara": "아라동", //키에다가 넣어준다 ㅠㅠ
    "ora": "오라동",
    "idong": "이동",
    "sadong": "사동",
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _curruntLocation = "ara";
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    contentsRepository = ContentsRepository();
  }

  _loadContent(){
    return contentsRepository.loadContentsFormLoaction(_curruntLocation);  //로드컨텐트를 리턴해줌 //데이터들
  }

  _makeDataList(List<Map<String,String>> datas){
    return ListView.separated(
      //세퍼레이트는 개별개별의 아이템마다 사이간격 라인을 손쉽게 나눌수 잇게해줌
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
           print("${datas[index]["title"]} 번 클릭됨");
           return Get.to(DetailContentView(datas[index]));
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                ClipRRect(
                  //ClipRRect 로 보더레디우스 올 전체값을 레디우스 서클로 20줌
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Hero(
                      tag: datas[index]["cid"],
                      child: Image.asset(
                        datas[index]["image"],
                        height: 100,
                        width: 100,
                      ),
                    )),
                //현재 datas 리스트 맵형식에 index(리스트인덱스) ("image")맵형식의 데이터를 불러옴
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 20),
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          datas[index]["title"],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          datas[index]["location"],
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.3)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          calcStringToWon(datas[index]["price"]),
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/heart_off.svg",
                                  height: 13,
                                  width: 13,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
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
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          height: 1,
          color: Colors.black.withOpacity(0.4),
        );
      },
      itemCount: 10,
    );
  }

  Widget _bodyWidget() {
    return FutureBuilder(
      future: _loadContent(), //loadcontent를 불러오고 (어떤 데이터가 오기 모르기때문에 퓨처로..)
      builder: (content,snapshot) { //오브젝트를 만들거나 클래스를 선언할떄 dynamic에 지정가능
        if(snapshot.connectionState != ConnectionState.done){       //커넥션 스테이트가 끝났는지 안긑났는지 !
          return Center(child: CircularProgressIndicator());         //데이터를 받고있는경우 로딩처리해줌.
        }
        if(snapshot.hasError){
          return Center(child: Text('데이터 오류가 났습니다.'),);
        }

        if(snapshot.hasData){
         return _makeDataList(snapshot.data);
        }

        return Center(child: Text('해당지역에 데이터가 없습니다.'),);  //지역에 데이터가없으면
      },
    );
  }


    Widget appBarWidget() {
      return AppBar(
        title: GestureDetector(
          onTap: () {
            print('Click');
          },
          // onLongPress: (){
          //   print('Long press');
          // },
          child: PopupMenuButton<String>( //pop업 메뉴버튼을 생산할 수 있음!!
            offset: Offset(0, 0),
            shape: ShapeBorder.lerp( //쉐이프로 팝업된 메뉴를 둥글게 만들수있음 라운드렉팅!!
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                1
            ),
            onSelected: (String where) {
              setState(() {
                _curruntLocation =
                    where; //밑에서 받은 value를 where에 넣고 커런트 로케이션에 넣어줌.
              });
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: "ara", child: Text('아라동'),),
                //팝업메뉴 아이템을 설정하면 클릭시 팝업메뉴가 밑으로 쫘르륵나옴
                PopupMenuItem(value: "ora", child: Text('오라동'),),
                PopupMenuItem(value: "idong", child: Text('이동'),),
                PopupMenuItem(value: "sadong", child: Text('사동'),),
              ];
            },

            child: Row(
              children: [
                Text(locationTypeToString[_curruntLocation]),
                //커런트 로케이션을 맵의 키에넣어주면 value값이 나오게된다.
                Icon(Icons.arrow_drop_down_outlined),
              ],
            ),
          ),
        ),
        elevation: 0.0,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.tune), onPressed: () {}),
          IconButton(icon: SvgPicture.asset("assets/svg/bell.svg", width: 22,),
              onPressed: () {}),
        ],
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: appBarWidget(),
        body: _bodyWidget(),
      );
    }
  }

//intl 라이브러리 사용
  final oCcy = new NumberFormat('#,###', "ko_KR");

//스트링 값의 price를 받아서 won으로 바꾸는 메소드
  String calcStringToWon(String priceString) {
    if(priceString == "무료나눔"){return priceString;}
    return "${oCcy.format(int.parse(priceString))}원";
  }

  BottomNavigationBarItem _bottomNavigationBarItem(String iconName,
      String label) {
    return BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SvgPicture.asset(
            "assets/svg/${iconName}_off.svg",
            width: 22,
          ),
        ),
        label: label);
  }
