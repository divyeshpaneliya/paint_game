import 'package:flutter/material.dart';
class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List img = [
    "assets/images/apple.jpeg",
    "assets/images/car.png",
    "assets/images/helicopter.png",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Paint"),
        ),
        body: GridView.builder(
          itemCount: img.length,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                onTap: (){ Navigator.pushNamed(context, 's2',arguments: img[index]);},
                child: Container(
                  child: Image.asset("${img[index]}"),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

