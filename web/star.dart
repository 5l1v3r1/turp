import 'dart:html';
import 'dart:math';
import 'package:polymer/polymer.dart';

@CustomTag('star-demo')
class Star extends PolymerElement {
  @published int points;
  double startAngle;
  double r1;
  double ratio;
  String color;
  int thickness;
  Point origin;
  double _step;
  double innerAngle;
  CanvasElement canvas;
  CanvasRenderingContext2D context;

  Star.created() : super.created() {
    startAngle = 0.0;
    thickness = 2;
    color = '#ffaa00';
    ratio = 0.4;
    canvas = $["canvas"];
    context = canvas.getContext("2d");
    //points = 5;
    r1 = 100.0;
    origin = new Point(250,250);
    draw();
  }

  Point calculatePolar(Point origin, double angle, double radius) =>
     new Point(origin.x + (radius * cos(angle)),
               origin.y + (radius * sin(angle)));

  void draw() {
    context.clearRect ( 0, 0, 500, 500);
    context.beginPath();
    _step = 2 * PI / points;
    innerAngle = _step / 2;
    double r2 = r1 * ratio;
    for (int i = 0; i < points + 1; i++) {
      Point outer = calculatePolar(origin, startAngle + i * _step, r1);
      Point inner = calculatePolar(origin, innerAngle + i * _step, r2);
      if (i == 0) {
        context.moveTo(outer.x, outer.y);
      } else {
        context.lineTo(outer.x, outer.y);
      }
      context.lineTo(inner.x, inner.y);
    }
    context.lineWidth = thickness;
    context.strokeStyle = color;
    context.stroke();
  }


  incrementPoints(Event e, var detail, Node target) {
    this.points++;
    draw();
  }

  decrementPoints(Event e, var detail, Node target) {
   points = points > 3 ? points-1 : 3;
   draw();
  }
}


//void main() {
//  CanvasElement canvas = querySelector("#canvas");
//  CanvasRenderingContext2D context = canvas.getContext("2d");
//  GameLoopHtml gameLoop = new GameLoopHtml(canvas);
//  List<Star> stars = new List<Star>();
//  var r = new Random();
//  for (int i=0; i<10; i++) {
//    int thickness = r.nextInt(5);
//    double ratio = r.nextDouble();
//    double size = r.nextInt(60).toDouble() + 20.0;
//    int x = r.nextInt(400);
//    int y = r.nextInt(400);
//    int edges = r.nextInt(10) + 3;
//    Star st = new Star(new Point(x, y), size, edges)
//        ..color='#ffaa00'
//        ..ratio=ratio
//        ..thickness=thickness;
//    stars.add(st);
//  }
//  gameLoop.onUpdate = ((gameLoop) {
//  });
//  int i = 0;
//  gameLoop.onRender = ((gameLoop) {
//    for (Star s in stars) {
//      s.draw(context);
//    }
//  });
//  gameLoop.start();

//  var gameTimer =
//      gameLoop.addTimer((timer) => print('timer fired.'), 0.5, periodic : true);
//}