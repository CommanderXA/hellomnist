import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hellomnist/dl_model/classifier.dart';
import '../size_config.dart';

class DrawPage extends StatefulWidget {
  @override
  _DrawPageState createState() => _DrawPageState();
}

class _DrawPageState extends State<DrawPage> {
  Classifier classifier = Classifier();
  List<Offset> points = List<Offset>();
  int digit = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(
          FluentIcons.dismiss_20_filled,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            points.clear();
            digit = -1;
          });
        },
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(40)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Digit Recognizer',
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(24),
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Text(
              'Draw inside the box',
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    color: Colors.white,
                  ),
                  height: getProportionateScreenHeight(300) + 2 * 2.0,
                  width: getProportionateScreenHeight(300) + 2 * 2.0,
                  child: GestureDetector(
                    onPanUpdate: (DragUpdateDetails details) {
                      Offset localPosition = details.localPosition;
                      setState(() {
                        if (localPosition.dx >= 0 &&
                            localPosition.dx <=
                                getProportionateScreenHeight(300) &&
                            localPosition.dy >= 0 &&
                            localPosition.dy <=
                                getProportionateScreenHeight(300))
                          points.add(localPosition);
                      });
                    },
                    onPanEnd: (DragEndDetails details) async {
                      points.add(null);
                      digit = await classifier.classifyDrawing(points);
                      setState(() {});
                    },
                    child: CustomPaint(
                      painter: Painter(points: points),
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Predicition',
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    digit == -1 ? "None" : "$digit",
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(32),
                        fontWeight: FontWeight.w800,
                        color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Painter extends CustomPainter {
  final List<Offset> points;
  Painter({this.points});

  final Paint paintDetails = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0
    ..color = Colors.black;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(points[i], points[i + 1], paintDetails);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
