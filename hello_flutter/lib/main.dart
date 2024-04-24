import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Hello Flutter",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                //요소가 배열로 들어 감,
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Image.network(
                    "https://i.ibb.co/nngK6j3/startup.png",
                    width: 81,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "E-Mail"),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password"),
                ),
                Container(
                  width: double.infinity, //본인의 부모 위젯의 최대치까지 붙겠다.
                  margin: EdgeInsets.only(top: 24),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Login"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
