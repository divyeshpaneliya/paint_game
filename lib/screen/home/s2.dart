import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class s2 extends StatefulWidget {
  const s2({Key? key}) : super(key: key);

  @override
  State<s2> createState() => _s2State();
}

class _s2State extends State<s2> {
  List<DrawModel> list = [];
  Color c1 = Colors.blue;
  bool value = false;

  @override
  Widget build(BuildContext context) {
    String g1 = ModalRoute.of(context)!.settings.arguments as String;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Paint"),

          actions: [
            IconButton(
              icon: Icon(Icons.replay_outlined), onPressed: () { list.clear(); },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.75,
                width: MediaQuery.of(context).size.width*1,
                  child: Image.asset(
                "$g1",
                fit: BoxFit.fill,
              )),
              GestureDetector(
                onPanStart: (details) {
                  if (value) {
                    setState(() {
                      RenderBox renderBox =
                          context.findRenderObject() as RenderBox;
                      Offset point =
                          renderBox.globalToLocal(details.globalPosition);

                      Paint p1 = Paint()
                        ..strokeWidth = 5
                        ..strokeCap = StrokeCap.round
                        ..color = c1;

                      DrawModel d1 = DrawModel(paint: p1, point: point);
                      list.add(d1);
                    });
                  }
                },
                onPanUpdate: (details) {
                  if (value) {
                    setState(() {
                      RenderBox renderBox =
                          context.findRenderObject() as RenderBox;
                      Offset point =
                          renderBox.globalToLocal(details.globalPosition);

                      Paint p1 = Paint()
                        ..strokeWidth = 5
                        ..strokeCap = StrokeCap.round
                        ..color = c1;

                      DrawModel d1 = DrawModel(paint: p1, point: point);

                      list.add(d1);
                    });
                  }
                },
                onPanEnd: (details) {
                  setState(() {
                    list.add(DrawModel(point: null, paint: null));
                  });
                },
                child: CustomPaint(
                  size: Size.infinite,
                  painter: Drawing(list),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              value = !value;
                            });
                          },
                          icon: Icon(
                            Icons.brush_outlined,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.home_filled,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            bgColor();
                          },
                          icon: Icon(
                            Icons.palette_outlined,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void bgColor() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              ColorPicker(
                  pickerColor: c1,
                  onColorChanged: (color) {
                    setState(() {
                      c1 = color;
                    });
                  }),
              TextButton(onPressed: () { Navigator.pop(context); },
              child: Text("Oaky"),),
            ],

          );
        });
  }
}

class DrawModel {
  Paint? paint;
  Offset? point;

  DrawModel({this.paint, this.point});
}

class Drawing extends CustomPainter {
  Drawing(this.pointlist);

  List<DrawModel> pointlist = [];
  List<Offset> offsetPoints = [];

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointlist.length - 1; i++) {
      if (pointlist[i].point != null && pointlist[i + 1].point != null) {
        canvas.drawLine(
            pointlist[i].point!, pointlist[i + 1].point!, pointlist[i].paint!);
      } else if (pointlist[i].point != null && pointlist[i + 1].point == null) {
        offsetPoints.clear();
        offsetPoints.add(pointlist[i].point!);
        offsetPoints.add(
            Offset(pointlist[i].point!.dx + 0.1, pointlist[i].point!.dy + 0.1));
        canvas.drawPoints(PointMode.points, offsetPoints, pointlist[i].paint!);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
