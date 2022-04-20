// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sm7/inside/icons/custom_icons.dart';
import 'package:sm7/inside/draw/draw_person.dart';
import 'package:sm7/inside/draw/draw_table.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class EmptyCheck extends StatefulWidget {
  const EmptyCheck({Key? key}) : super(key: key);

  @override
  _EmptyCheckState createState() => _EmptyCheckState();
}

//초기값
Map<String, dynamic>? yolo_result;

class myPainter extends CustomPainter {
  //아이콘 정의, 변수 선언
  final chair_icon = Icons.chair_outlined;
  final mask_icon = CustomIcons.mask2;
  final nomask_icon = CustomIcons.mask2_2;
  final error_icon = CustomIcons.error2_1;
  String target;

  //생성자
  myPainter(this.target);

  //사람그리기
  void personPainter(Canvas canvas, Size size, String personResult) {
    TextPainter textPainter = TextPainter(textDirection: TextDirection.rtl);
    //사람 없음
    if (personResult == "noperson") {
      textPainter.text = TextSpan(
          text: String.fromCharCode(chair_icon.codePoint),
          style: TextStyle(
              fontSize: 46.0,
              fontFamily: chair_icon.fontFamily,
              color: Colors.grey[600]));
      textPainter.layout();
      textPainter.paint(canvas, Offset(-23, -23));
    } //마스크 착용
    else if (personResult == "mask") {
      textPainter.text = TextSpan(
          text: String.fromCharCode(mask_icon.codePoint),
          style: TextStyle(
              fontSize: 48.0,
              fontFamily: mask_icon.fontFamily,
              color: Colors.green));
      textPainter.layout();
      textPainter.paint(canvas, Offset(-24, -24));
    } //마스크 미착용
    else if (personResult == "nomask") {
      textPainter.text = TextSpan(
          text: String.fromCharCode(nomask_icon.codePoint),
          style: TextStyle(
              fontSize: 48.0,
              fontFamily: nomask_icon.fontFamily,
              color: Colors.red));
      textPainter.layout();
      textPainter.paint(canvas, Offset(-24, -24));
    } //error
    else {
      textPainter.text = TextSpan(
          text: String.fromCharCode(error_icon.codePoint),
          style: TextStyle(
              fontSize: 44.0,
              fontFamily: error_icon.fontFamily,
              color: Colors.yellow));
      textPainter.layout();
      textPainter.paint(canvas, Offset(-22, -22));
    }
  }

  //테이블 그리기
  void tablePainter(Canvas canvas, Size size, String tableResult) {
    //페인트 정의
    //빈자리
    Paint paint1 = Paint()
      ..color = Colors.grey
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    //자리있음
    Paint paint2 = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    //빈자리
    if (tableResult == "no") {
      canvas.drawRect(Offset(-80, -24) & const Size(160, 48), paint1);
    } //자리있음
    else if (tableResult == "yes") {
      canvas.drawRect(Offset(-80, -24) & const Size(160, 48), paint2);
    }
  }

  //그림 그리기 시작
  @override
  void paint(Canvas canvas, Size size) {
    //person 그리기
    if (target[0] == 'p') {
      //객체 생성
      var person = draw_person(target: target, yolo_result: yolo_result);
      String personResult = person.check_person();   //noperson, mask, nomask, error
      personPainter(canvas, size, personResult); //no, yes

    } // table 그리기
    else {
      var table = draw_table(target: target, yolo_result: yolo_result);
      String tableResult = table.check_table();
      tablePainter(canvas, size, tableResult);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _EmptyCheckState extends State<EmptyCheck> {
  WebSocketChannel? channel;

  //웹소켓 연결
  websocket_connect() {
    channel =
        WebSocketChannel.connect(Uri.parse('ws://35.77.144.191/ws/detectData'));
  }

  @override
  void initState() {
    super.initState();
    websocket_connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("좌석 & 마스크 확인", style: TextStyle(fontSize: 20.0)),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const [
                      Color.fromARGB(195, 0, 0, 0),
                      Color.fromARGB(215, 0, 0, 0),
                      Color.fromARGB(235, 0, 0, 0),
                      Color.fromARGB(252, 0, 0, 0),
                    ],
                    stops: const [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              //웹소켓에서 값 받아서 보여주는 부분
              StreamBuilder(
                stream: channel?.stream,
                builder: (context, snapshot) {
                  //null 신호 일 때
                  if (snapshot.data == null) {
                    return Center(child: CircularProgressIndicator());
                  } //값이 들어왔을 때
                  else {
                    yolo_result = jsonDecode('${snapshot.data}'); //들어온 값 json -> string,dynamic
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: SafeArea(
                          child: Center(
                              child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(yolo_result.toString(),
                                        style: TextStyle(
                                            fontSize: 5,
                                            color: Colors.black.withOpacity(0))),
                                    SizedBox(
                                      height: 45,
                                    ),
                                    Container(
                                      child: CustomPaint(
                                        painter: myPainter("p1"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      child: CustomPaint(
                                        painter: myPainter("t1"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      child: CustomPaint(
                                        painter: myPainter("p2"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 80,
                                    ),
                                    Container(
                                      child: CustomPaint(
                                        painter: myPainter("p3"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      child: CustomPaint(
                                        painter: myPainter("t2"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      child: CustomPaint(
                                        painter: myPainter("p4"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 80,
                                    ),
                                    Container(
                                      child: CustomPaint(
                                        painter: myPainter("p5"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      child: CustomPaint(
                                        painter: myPainter("t3"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      child: CustomPaint(
                                        painter: myPainter("p6"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 80,
                                    ),
                                  ])),
                        ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
