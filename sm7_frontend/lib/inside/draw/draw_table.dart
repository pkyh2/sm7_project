//테이블과 사람을 확인하여 빈자리 유무 확인
//table1 그리기

class draw_table {
  final String target;
  late String result = "no";
  final Map<String, dynamic>? yolo_result;

  draw_table({required this.target, required this.yolo_result});

  String check_table() {
    //table1
    if (target == 't1') {
      //빈자리
      if ((yolo_result?["table1"]['object']['notebook'] == 0) &&
          (yolo_result?["table1"]['object']['book'] == 0) &&
          (yolo_result?["table1"]['object']['bag'] == 0) &&
          (yolo_result?["table1"]['object']['cup'] == 0) &&
          (yolo_result?["table1"]['chair']['up'] == 0) &&
          (yolo_result?["table1"]['chair']['down'] == 0)) {
        return result;
      }
      //자리있음
      else {
        result = "yes";
        return result;
      }
    } //table2
    else if (target == 't2') {
      if ((yolo_result?["table2"]['object']['notebook'] == 0) &&
          (yolo_result?["table2"]['object']['book'] == 0) &&
          (yolo_result?["table2"]['object']['bag'] == 0) &&
          (yolo_result?["table2"]['object']['cup'] == 0) &&
          (yolo_result?["table2"]['chair']['up'] == 0) &&
          (yolo_result?["table2"]['chair']['down'] == 0)) {
        return result;
      } else {
        result = "yes";
        return result;
      }
    } //table3
    else {
      if ((yolo_result?["table3"]['object']['notebook'] == 0) &&
          (yolo_result?["table3"]['object']['book'] == 0) &&
          (yolo_result?["table3"]['object']['bag'] == 0) &&
          (yolo_result?["table3"]['object']['cup'] == 0) &&
          (yolo_result?["table3"]['chair']['up'] == 0) &&
          (yolo_result?["table3"]['chair']['down'] == 0)) {
        return result;
      } else {
        result = "yes";
        return result;
      }
    }
  }
}
