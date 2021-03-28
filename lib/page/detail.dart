import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carrot/components/manor_temperat_widget.dart';

class DetailContentView extends StatefulWidget {
  Map<String, String> data;

  DetailContentView(this.data);

  @override
  _DetailContentViewState createState() => _DetailContentViewState();

}

class _DetailContentViewState extends State<DetailContentView> {
  Size size;
  List<Map<String, String>> imgList;
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
    size = MediaQuery
        .of(context)
        .size;
    imgList = [
      {"id": "0", "url": widget.data["image"]},
      {"id": "1", "url": widget.data["image"]},
      {"id": "2", "url": widget.data["image"]},
      {"id": "3", "url": widget.data["image"]},
      {"id": "4", "url": widget.data["image"]},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true, //body 이하로 확장하겠다는
        appBar: appBarWidget(),
        body: _bodyWidget(),
        bottomNavigationBar: _bottomNavigation(),
      ),
    );
  }

  Widget _bottomNavigation() {
    return Container(
      child: Center(
        child: ListTile(
          leading: IconButton(icon: Icon(Icons.favorite_border),onPressed: () {},),
          title: Text('10000'),
          subtitle: Text('100'),
          // trailing: ,
        ),
      ),
      width: size.width,
      height: 55,
    );
  }

  Widget appBarWidget() {
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

  Widget _makeSilderImage() {
    return Container(
      child: Stack(
        children: [
          Hero( //Hero로 왔다갔다할 때 이미지가 스타일리쉬적으로 넘어갈수잇게
            tag: widget.data["cid"], //데이터에서 추가한 cid로 판별
            child: CarouselSlider( //캐러설 슬라이드 패키지적용
              items: imgList.map((
                  map) { //이미지 리스트를 맵으로 돌려서 하나씩 빼옴   //itmes = 슬라이드를 보여줄 이미지
                return Image.asset(map["url"],
                  width: size.width,
                  fit: BoxFit.fill,
                );
              }).toList(), //리스트는 항상 toList로 빼줘야함
              options: CarouselOptions(
                height: size.width,
                //height는 width의 크기만큼 오라고 width사이즈를줌
                initialPage: 0,
                //기본페이지는 0번
                enableInfiniteScroll: true,
                //사진 스크롤이 무한으로 넘어가는것을 막음
                viewportFraction: 1,
                //1로 두게되면 화면사이즈를 1로차지함.
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
            left: 0, // 렣프트 라이트 0을 사용하면 오른쪽 왼쪽 다사용하게되어서 가운데로감!!!
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.map((map) {
                return Container(
                  height: 10.0,
                  width: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    //BoxDecoration 인디케이터 만들때 박스쉐이프 써클로만들자!!
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

  Widget _sellerSimpleInfo() {
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
              Text('개발하는남자',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              Text('제주도 도담시', style: TextStyle(fontSize: 13),),
            ],
          ),
          Expanded(child: ManorTemperature(manorTemp: 37.5,)),

        ],
      ),
    );
  }

  Widget _line() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      height: 1, color: Colors.grey.withOpacity(0.3),);
  }

  Widget _contentDetail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 15,),
          Text(widget.data["title"],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          Text("디지털 가전/가전 22시간 전",
              style: TextStyle(color: Colors.grey, fontSize: 12)),
          SizedBox(height: 15,),
          Text("선물받은 상품이고\n한번밖에 꺼내보지 않아고\n맛있겠습죠?",
              style: TextStyle(fontSize: 15, height: 1.5)),
          SizedBox(height: 15,),
          Text("채팅 3・관심 17・조회 295",
              style: TextStyle(color: Colors.grey, fontSize: 12)),
          SizedBox(height: 15,),
        ],
      ),
    );
  }

  Widget _otherCellContest() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('판매자님의 판매 상품',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
          Text('모두보기',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),

        ],),
    );
  }

  Widget _bodyWidget() {
    return CustomScrollView(                //일반 스크롤뷰말고 커스텀 스크롤뷰로 
        slivers: [ 
      SliverList(delegate: SliverChildListDelegate(          //슬리버 리스트로 델리게이트 슬리버차일드리스트 딜레게이트
        [
            _makeSilderImage(),
            _sellerSimpleInfo(),
            _line(),
            _contentDetail(),
            _line(),
            _otherCellContest(),
          ],
    ),
      ),
          SliverPadding(padding: EdgeInsets.symmetric(horizontal: 15),           //패딩도 슬리버 패딩
            sliver: SliverGrid(                                       //가로 개수     //가로 넓이            //세로 넓이
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10),
            delegate: SliverChildListDelegate(List.generate(20,(index){         //실질적 리스트 제네레이터 
            return Container(child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius:BorderRadius.circular(10),
                    child: Container(color: Colors.grey,height: 120,)),
                Text('상품 제목',style: TextStyle(fontSize: 14),),
                Text('금액',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
              ],
            ),);                //실제 컨텐츠
          }).toList(),
          ),
          ),
          ),
    ],
    );
  }
}