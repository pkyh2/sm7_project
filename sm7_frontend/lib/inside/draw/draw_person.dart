//table별 사람들 그리기

class draw_person {
  final String target;
  late String result = "noperson";
  final Map<String, dynamic>? yolo_result;

  draw_person({required this.target, required this.yolo_result});

  String check_person() {
    //p1, table1, up
    if (target == "p1" &&
        yolo_result?["table1"]["chair"].keys.elementAt(0) == "up") {
      //사람 없음
      if (yolo_result?["table1"]["chair"]["up"] == 0) {
        return result;
      } //마스크 쓴 사람
      else if (yolo_result?["table1"]["chair"]["up"] == 1) {
        result = "mask";
        return result;
      } //마스크 안쓴사람
      else if (yolo_result?["table1"]["chair"]["up"] == 2) {
        result = "nomask";
        return result;
      } //에러인 사람
      else {
        result = "error";
        return result;
      }
    } //p2, table1, down
    else if (target == "p2" &&
        yolo_result?["table1"]["chair"].keys.elementAt(1) == "down") {
      if (yolo_result?["table1"]["chair"]["down"] == 0) {
        return result;
      } else if (yolo_result?["table1"]["chair"]["down"] == 1) {
        result = "mask";
        return result;
      } else if (yolo_result?["table1"]["chair"]["down"] == 2) {
        result = "nomask";
        return result;
      } else {
        result = "error";
        return result;
      }
    } //p3, table2, up
    else if (target == "p3" &&
        yolo_result?["table2"]["chair"].keys.elementAt(0) == "up") {
      if (yolo_result?["table2"]["chair"]["up"] == 0) {
        return result;
      } else if (yolo_result?["table2"]["chair"]["up"] == 1) {
        result = "mask";
        return result;
      } else if (yolo_result?["table2"]["chair"]["up"] == 2) {
        result = "nomask";
        return result;
      } else {
        result = "error";
        return result;
      }
    } //p4, table2, down
    else if (target == "p4" &&
        yolo_result?["table2"]["chair"].keys.elementAt(1) == "down") {
      if (yolo_result?["table2"]["chair"]["down"] == 0) {
        return result;
      } else if (yolo_result?["table2"]["chair"]["down"] == 1) {
        result = "mask";
        return result;
      } else if (yolo_result?["table2"]["chair"]["down"] == 2) {
        result = "nomask";
        return result;
      } else {
        result = "error";
        return result;
      }
    } //p5, table3, up
    else if (target == "p5" &&
        yolo_result?["table3"]["chair"].keys.elementAt(0) == "up") {
      if (yolo_result?["table3"]["chair"]["up"] == 0) {
        return result;
      } else if (yolo_result?["table3"]["chair"]["up"] == 1) {
        result = "mask";
        return result;
      } else if (yolo_result?["table3"]["chair"]["up"] == 2) {
        result = "nomask";
        return result;
      } else {
        result = "error";
        return result;
      }
    } //p6, table3, down
    else {
      if (yolo_result?["table3"]["chair"]["down"] == 0) {
        return result;
      } else if (yolo_result?["table3"]["chair"]["down"] == 1) {
        result = "mask";
        return result;
      } else if (yolo_result?["table3"]["chair"]["down"] == 2) {
        result = "nomask";
        return result;
      } else {
        result = "error";
        return result;
      }
    }
  }
}
