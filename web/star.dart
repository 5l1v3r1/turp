import 'dart:html';
import 'dart:math';
import 'package:game_loop/game_loop_html.dart';

class Star {
  double startAngle;
  double r1;
  double ratio;
  int edges;
  String color;
  int thickness;
  Point origin;
  double _step;
  double innerAngle;

  Star(this.origin, this.r1, this.edges) {
    startAngle = 0.0;
    thickness = 2;
    color = '#ffaa00';
    _step = 2 * PI / edges;
    innerAngle = _step / 2;
  }

  Point calculatePolar(Point origin, double angle, double radius) =>
     new Point(origin.x + (radius * cos(angle)),
               origin.y + (radius * sin(angle)));

  void draw(CanvasRenderingContext2D context) {
    context.beginPath();
    double r2 = r1 * ratio;

    for (int i = 0; i < edges + 1; i++) {
      Point outer = calculatePolar(origin, startAngle + i * _step, r1);
      Point inner = calculatePolar(origin, innerAngle + i * _step, r2);
      if (i == 0) {
        context.moveTo(outer.x, outer.y);
        context.lineTo(inner.x, inner.y);
      } else {
        context.lineTo(outer.x, outer.y);
        context.lineTo(inner.x, inner.y);
      }
    }
    context.lineWidth = thickness;
    context.strokeStyle = color;
    context.stroke();
  }

}

void main() {
  CanvasElement canvas = query("#canvas");
  CanvasRenderingContext2D context = canvas.getContext("2d");
  GameLoopHtml gameLoop = new GameLoopHtml(canvas);
  List<Star> stars = new List<Star>();
  var r = new Random();
  for (int i=0; i<10; i++) {
    int thickness = r.nextInt(5);
    double ratio = r.nextDouble();
    double size = r.nextInt(60).toDouble() + 20.0;
    int x = r.nextInt(400);
    int y = r.nextInt(400);
    int edges = r.nextInt(10) + 3;
    Star st = new Star(new Point(x, y), size, edges)
        ..color='#ffaa00'
        ..ratio=ratio
        ..thickness=thickness;
    stars.add(st);
  }
  gameLoop.onUpdate = ((gameLoop) {
  });
  int i = 0;
  gameLoop.onRender = ((gameLoop) {
    for (Star s in stars) {
      s.draw(context);
    }
  });
  gameLoop.start();

//  var gameTimer =
//      gameLoop.addTimer((timer) => print('timer fired.'), 0.5, periodic : true);
}