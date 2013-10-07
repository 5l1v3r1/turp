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
  int x;
  int y;

  Star(this.x, this.y, this.r1, this.edges) {
    startAngle = 0.0;
    ratio = 0.4;
    thickness = 2;
    color = '#ffaa00';
  }

  void draw(CanvasRenderingContext2D context) {
    double step = 2 * PI / edges;
    double innerAngle = step / 2;
    double r2 = r1 * ratio;

    context.beginPath();

    for (int i = 0; i < edges + 1; i++) {
      double px = x + (r1 * cos(startAngle + i * step));
      double py = y + (r1 * sin(startAngle + i * step));

      double tx = x + (r2 * cos(innerAngle + i * step));
      double ty = y + (r2 * sin(innerAngle + i * step));

      if (i == 0) {
        context.moveTo(px, py);
        context.lineTo(tx, ty);
      } else {
        context.lineTo(px, py);
        context.lineTo(tx, ty);
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
    double size = r.nextInt(100).toDouble() + 10.0;
    int x = r.nextInt(300);
    int y = r.nextInt(300);
    int edges = r.nextInt(10) + 3;
    Star st = new Star(x, y, size, edges)..color='#ffaa00'..ratio=ratio..thickness=thickness;
    stars.add(st);
  }
//  Star s = new Star(250, 250, 100.0, 5);
  gameLoop.onUpdate = ((gameLoop) {
  });
  int i = 0;
  gameLoop.onRender = ((gameLoop) {
    for (Star s in stars) {
      s.draw(context);
    }
    //s.draw(context);
  });
  gameLoop.start();

//  var gameTimer =
//      gameLoop.addTimer((timer) => print('timer fired.'), 0.5, periodic : true);
}