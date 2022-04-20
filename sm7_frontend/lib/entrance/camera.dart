import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

typedef void Callback(List<dynamic> list, int h, int w);

class CameraFeed extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;

  CameraFeed(this.cameras, this.setRecognitions);

  @override
  _CameraFeedState createState() => new _CameraFeedState();
}

class _CameraFeedState extends State<CameraFeed> {
  CameraController? controller;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();
    //카메라 설정
    controller = new CameraController(
      widget.cameras[0], //0(후면 or 내장카메라),1(전면, 외부카메라)
      ResolutionPreset.high, //해상도
    );
    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});

      //카메라 영상 -> 이미지
      //android, ios만 가능 웹캠 지원 안함
      controller?.startImageStream((CameraImage img) {
        //작동 잘될 때
        if (!isDetecting) {
          isDetecting = true;
          Tflite.detectObjectOnFrame(
            bytesList: img.planes.map((plane) {
              return plane.bytes;
            }).toList(),
            imageHeight: img.height,
            imageWidth: img.width,
            imageMean: 127.5,
            imageStd: 127.5,
            numResultsPerClass: 5,
            threshold: 0.3,
          ).then((recognitions) {
            widget.setRecognitions(recognitions!, img.height, img.width);
            isDetecting = false;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //카메라 없을 때
    if (controller == null || !controller!.value.isInitialized) {
      return Container(); //빈 컨테이너 return
    }

    //카메라 있을 때
    var tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    tmp = controller!.value.previewSize!;
    var previewH = math.max(tmp.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;

    return OverflowBox(
      maxHeight:
          screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
      maxWidth:
          screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
      //카메라 보여줌
      child: CameraPreview(controller!),
    );
  }
}
