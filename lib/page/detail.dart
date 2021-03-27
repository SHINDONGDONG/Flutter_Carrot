import 'package:flutter/material.dart';

class DetailContentView extends StatefulWidget {
  Map<String,String> data;

  DetailContentView(this.data);

  @override
  _DetailContentViewState createState() => _DetailContentViewState();

}

class _DetailContentViewState extends State<DetailContentView> {
  Size size;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,  //body 이하로 확장하겠다는
        appBar: appBarWidget(),
        body: _bodyWidget(),
      ),
    );
  }

  Widget appBarWidget(){
    return AppBar(
      backgroundColor: Colors.transparent,

      elevation: 0.0,
      actions: [
        IconButton(icon: Icon(Icons.share), onPressed: () {}),
        IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
      ],
    );
  }

Widget _bodyWidget(){
  return Container(
    child: Hero(        //Hero로 왔다갔다할 때 이미지가 스타일리쉬적으로 넘어갈수잇게
      tag: widget.data["cid"],  //데이터에서 추가한 cid로 판별
      child: Image.asset(widget.data["image"],
        width: size.width,
      fit: BoxFit.fill,
      ),
    ),
  );
  }
}