import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sm7/entrance/bounding_box.dart';
import 'package:sm7/entrance/camera.dart';
import 'dart:math' as math;
import 'package:tflite/tflite.dart';

//실시간 카메라
class CameraMain extends StatefulWidget {
  @override
  _CameraMainState createState() => _CameraMainState();
}

class _CameraMainState extends State<CameraMain> {
  List<CameraDescription>? cameras;
  List<dynamic>? _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  bool isCamera = false;

  //tflite 모델 load
  loadTfModel() async {
    await Tflite.loadModel(
      model: "assets/mask_detecting.tflite", //mask판단
      labels: "assets/mask_detecting.txt", //got mask,no mask, wear incorrectly
    );
  }
  //카메라셋업
  _setupCameras() async{
    try {
      //사용가능한 카메라를 목록을 저장
      cameras = await availableCameras();
    }on CameraException catch (_){
      print("no camera");
    }
    if (!mounted) return;
    setState(() {
      isCamera = true;
    });
  }

  //인식하기위한 이미지 크기 세팅
  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  void initState(){
    super.initState();
    _setupCameras();
    loadTfModel();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    //카메라 없는 상태
    if (cameras == null) {
      return Center(child: CircularProgressIndicator());
    } //카메라가 있는 상태
    else {
      return Scaffold(
        appBar: AppBar(
          title: Text("출입 마스크 확인", style: TextStyle(fontSize: 20.0)),
          backgroundColor: Colors.black,
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Stack(
          children: <Widget>[
            //카메라작동(camera.dart)
            CameraFeed(cameras!, setRecognitions),
            //박스 그리기(bounding_box.dart)
            BoundingBox(
              //null이면 [], null 아니면 _recognitions
              _recognitions == null ? [] : _recognitions!,
              math.max(_imageHeight, _imageWidth),
              math.min(_imageHeight, _imageWidth),
              screen.height,
              screen.width,
            ),
          ],
        ),
      );
    }
  }
}