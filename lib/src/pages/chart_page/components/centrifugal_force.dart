import 'package:after_layout/after_layout.dart';
import 'package:app/src/algorithm/arrangement.dart';
import 'package:app/src/pages/chart_page/components/star.dart';
import 'package:arrow_path/arrow_path.dart';

import 'package:flutter/material.dart';

import 'region_cell/index.dart';

enum CentrifugalForceDirection { Left, Right, Top, Bottom }

// 離心力
class CentrifugalForcePainter extends CustomPainter {
  final Offset from;
  final Offset to;
  final List<HuaQi> huaQis;
  final CentrifugalForceDirection direction;

  CentrifugalForcePainter(this.from, this.to, this.huaQis, this.direction);

  @override
  void paint(Canvas canvas, Size size) {
    Path path;
    Paint paint = Paint()
      ..color = Colors.black
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
  bool shouldRepaint(CentrifugalForcePainter oldDelegate) {
    return oldDelegate.from != from || oldDelegate.to != to;
  }
}

class CentrifugalForce extends StatefulWidget {
  final RegionCell regionCell;
  final StarItem starItem;

  CentrifugalForce(this.regionCell, this.starItem);

  @override
  State<StatefulWidget> createState() => CentrifugalForceState();
}

class CentrifugalForceState extends State<CentrifugalForce>
    with AfterLayoutMixin<CentrifugalForce> {
  Offset _from = const Offset(0, 0);
  Offset _to = const Offset(0, 0);
  CentrifugalForceDirection _direction = CentrifugalForceDirection.Bottom;

  @override
  Widget build(BuildContext context) {
    HuaQi? huaQi =
        widget.starItem.star.getHuaQi(widget.regionCell.region.tianGan);

    if (huaQi == null) {
      return const SizedBox.shrink();
    }

    return Positioned(
      child: CustomPaint(
          painter: CentrifugalForcePainter(_from, _to, [huaQi], _direction)),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    RegionCell regionCell = widget.regionCell;
    GlobalKey starItemKey = widget.starItem.key as GlobalKey;
    CentrifugalForceDirection direction =
        widget.regionCell.getCentrifugalForceDirection();
    Offset from;
    Offset to;

    RenderBox? starBox =
        starItemKey.currentContext?.findRenderObject() as RenderBox?;
    if (starBox == null) {
      throw Exception('invalid');
    }
    double toBias = 8;
    double fromBias = 0;
    switch (direction) {
      case CentrifugalForceDirection.Bottom:
        double x = -starBox.size.width / 2;
        double y = starBox.size.height + fromBias;
        from = Offset(x, y);
        y = regionCell.getSize().height + toBias;
        to = Offset(x, y);
        break;
      case CentrifugalForceDirection.Left:
        Offset starOffset = starBox.localToGlobal(Offset.zero);
        double x = -starBox.size.width / 2;
        double y = starBox.size.height + fromBias;
        double slope = -0.5;
        from = Offset(x, y);
        x = -starOffset.dx - toBias;
        // y = y + starBox.size.height / 4;
        y = y + x * slope;
        to = Offset(x, y);
        break;
      case CentrifugalForceDirection.Right:
        Offset starOffset = starBox.localToGlobal(Offset.zero);
        double x = -starBox.size.width / 2;
        double y = starBox.size.height + fromBias;
        double slope = 0.5;
        from = Offset(x, y);

        x = regionCell.getOffset().dx +
            regionCell.getSize().width -
            starOffset.dx -
            starBox.size.width +
            toBias;
        // y = y + starBox.size.height / 4;
        y = y + x * slope;
        to = Offset(x, y);
        break;
      case CentrifugalForceDirection.Top:
        double x = -starBox.size.width / 2;
        double y = 0;
        from = Offset(x, y);
        y = -toBias - 12;
        to = Offset(x, y);
        break;
    }

    setState(() {
      _from = from;
      _to = to;
      _direction = direction;
    });
  }
}
