import 'package:flutter/material.dart';
import 'package:sm7/login&signup/loginPage.dart';

void main() async {
  runApp(
      const MaterialApp(
        //디버그 표시 없애기
          debugShowCheckedModeBanner: false,
          home: MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
        child: Text("SM7",
            style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold)),
        onPressed: () {
          //로그인페이지로 넘어가기
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },
      )),
      backgroundColor: Color.fromARGB(252, 0, 0, 0),
    );
  }
}
