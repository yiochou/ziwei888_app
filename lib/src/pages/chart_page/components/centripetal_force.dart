import 'package:after_layout/after_layout.dart';
import 'package:app/src/algorithm/arrangement.dart';

import 'package:app/src/pages/chart_page/components/region_cell/index.dart';
import 'package:arrow_path/arrow_path.dart';
import 'package:flutter/material.dart';

// 向心力
class CentripetalForcePainter extends CustomPainter {
  final Offset from;
  final Offset to;
  final List<HuaQi> huaQis;

  CentripetalForcePainter(this.from, this.to, this.huaQis);

  @override
  void paint(Canvas canvas, Size size) {
    Path path;
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 1.0;

    path = Path();
    path.moveTo(from.dx, from.dy);
    path.lineTo(to.dx, to.dy);

    path = ArrowPath.make(path: path, tipLength: 5);
    canvas.drawPath(path, paint..color = Colors.blue);

    String text = huaQis.map((e) => e.name).toList().join('');
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final offset = Offset(to.dx, to.dy);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CentripetalForcePainter oldDelegate) {
    return oldDelegate.from != from || oldDelegate.to != to;
  }
}

class CentripetalForce extends StatefulWidget {
  final RegionCell regionCell;

  CentripetalForce(this.regionCell);

  @override
  State<StatefulWidget> createState() => CentripetalForceState();
}

class CentripetalForceState extends State<CentripetalForce>
    with AfterLayoutMixin<CentripetalForce> {
  Offset from = const Offset(0, 0);
  Offset to = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    List<HuaQi> huaQis = widget.regionCell.region.stars
        .map((star) => star
            .getCentripetalForce(widget.regionCell.oppositeRegionCell.region))
        .whereType<HuaQi>()
        .toList();

    if (huaQis.isEmpty) {
      return const SizedBox.shrink();
    }

    return Positioned(
      child: CustomPaint(
          size: const Size(20, 20),
          painter: CentripetalForcePainter(from, to, huaQis)),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    RegionCell cell = widget.regionCell;
    setState(() {
      from = cell.getCentripetalForceTo();
      to = cell.getCentripetalForceFrom();
    });
  }
}
