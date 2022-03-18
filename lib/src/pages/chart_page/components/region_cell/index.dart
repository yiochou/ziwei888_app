import 'package:app/src/algorithm/arrangement.dart';
import 'package:app/src/pages/chart_page/components/star.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

import '../centrifugal_force.dart';
import '../centripetal_force.dart';

abstract class RegionCell extends StatefulWidget {
  final Region region;
  Size _size = Size(0, 0);
  Offset _offset = Offset(0, 0);
  Offset _centripetalForceFrom = Offset(0, 0);
  Offset _centripetalForceTo = Offset(0, 0);
  late CentrifugalForceDirection _centrifugalForceDirection;

  late RegionCell oppositeRegionCell;

  RegionCell({
    required Key key,
    required this.region,
  }) : super(key: key);

  setSize(Size size) {
    _size = size;
  }

  Size getSize() {
    return _size;
  }

  setOffset(Offset offset) {
    _offset = offset;
  }

  Offset getOffset() {
    return _offset;
  }

  Border setBorder() {
    return _setBorder();
  }

  void setCentripetalForceFrom() {
    throw UnimplementedError;
  }

  Offset getCentripetalForceFrom() {
    return _centripetalForceFrom;
  }

  void setCentripetalForceTo() {
    throw UnimplementedError;
  }

  Offset getCentripetalForceTo() {
    return _centripetalForceTo;
  }

  CentrifugalForceDirection getCentrifugalForceDirection() {
    return _centrifugalForceDirection;
  }

  Border _setBorder(
      {bool top = false,
      bool left = false,
      bool right = false,
      bool bottom = false}) {
    const defaultBorderSide = BorderSide(width: 0);
    const borderSide = BorderSide(width: 0.5, color: Colors.black);
    return Border(
      top: top ? borderSide : defaultBorderSide,
      left: left ? borderSide : defaultBorderSide,
      right: right ? borderSide : defaultBorderSide,
      bottom: bottom ? borderSide : defaultBorderSide,
    );
  }

  @override
  RegionCellState createState() => RegionCellState();

  static List<RegionCell> generateFromChartInfo(ChartInfo chartInfo) {
    List<RegionCell> cells = [
      RegionCell1(
        key: UniqueKey(),
        region: chartInfo.getRegion(RegionCell1.regionNumber),
      ),
      RegionCell2(
        key: UniqueKey(),
        region: chartInfo.getRegion(RegionCell2.regionNumber),
      ),
      RegionCell3(
        key: UniqueKey(),
        region: chartInfo.getRegion(RegionCell3.regionNumber),
      ),
      RegionCell4(
        key: UniqueKey(),
        region: chartInfo.getRegion(RegionCell4.regionNumber),
      ),
      RegionCell5(
        key: UniqueKey(),
        region: chartInfo.getRegion(RegionCell5.regionNumber),
      ),
      RegionCell6(
        key: UniqueKey(),
        region: chartInfo.getRegion(RegionCell6.regionNumber),
      ),
      RegionCell7(
        key: UniqueKey(),
        region: chartInfo.getRegion(RegionCell7.regionNumber),
      ),
      RegionCell8(
        key: UniqueKey(),
        region: chartInfo.getRegion(RegionCell8.regionNumber),
      ),
      RegionCell9(
        key: UniqueKey(),
        region: chartInfo.getRegion(RegionCell9.regionNumber),
      ),
      RegionCell10(
        key: UniqueKey(),
        region: chartInfo.getRegion(RegionCell10.regionNumber),
      ),
      RegionCell11(
        key: UniqueKey(),
        region: chartInfo.getRegion(RegionCell11.regionNumber),
      ),
      RegionCell12(
        key: UniqueKey(),
        region: chartInfo.getRegion(RegionCell12.regionNumber),
      ),
    ];

    for (int i = 0; i < cells.length; i++) {
      cells[i].oppositeRegionCell = cells[Region.abs(i + 7) - 1];
    }

    return cells;
  }
}

class RegionCellState extends State<RegionCell>
    with AfterLayoutMixin<RegionCell> {
  List<GlobalKey> starKeys = [];

  void _setCellMetadata(BuildContext context) {
    RenderBox? box = context.findRenderObject() as RenderBox?;

    if (box != null) {
      widget.setSize(box.size);
      widget.setOffset(box.localToGlobal(Offset.zero));
      widget.setCentripetalForceFrom();
      widget.setCentripetalForceTo();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> starWidgets = [];
    for (int i = widget.region.stars.length - 1; i >= 0; i--) {
      GlobalKey key = GlobalKey<StarItemState>();
      starKeys.add(key);
      StarItem starItem = StarItem(star: widget.region.stars[i], key: key);
      starWidgets.add(Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          starItem,
          CentrifugalForce(
            widget,
            starItem,
          )
        ],
      ));
    }

    return Stack(alignment: AlignmentDirectional.topStart, children: [
      Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.black12,
          border: widget.setBorder(),
        ),
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: starWidgets)),
          const Spacer(),
          Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.black,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(children: [
                Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Colors.black,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                        child: Column(
                          children: [
                            Text(
                              widget.region.tianGan.name,
                              style: const TextStyle(height: 1.2, fontSize: 10),
                            ),
                            Text(
                              widget.region.diZhi.name,
                              style: const TextStyle(height: 1.2, fontSize: 10),
                            )
                          ],
                        ))),
                Expanded(
                    flex: 1,
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(widget.region.palace.name))),
                //region.palace.name
              ])),
        ]),
      ),
      CentripetalForce(widget),
    ]);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _setCellMetadata(context);
  }
}

class RegionCell1 extends RegionCell {
  static int regionNumber = 1;
  RegionCell1({
    required Key key,
    required Region region,
  }) : super(key: key, region: region);

  @override
  final CentrifugalForceDirection _centrifugalForceDirection =
      CentrifugalForceDirection.Bottom;

  @override
  Border setBorder() {
    return super._setBorder(top: true, left: true, bottom: true, right: true);
  }

  @override
  void setCentripetalForceFrom() {
    _centripetalForceFrom = Offset(_size.width, 0);
  }

  @override
  void setCentripetalForceTo() {
    Offset from = _centripetalForceFrom;
    _centripetalForceTo =
        Offset(from.dx + _size.width * 2, from.dy - _size.height * 2);
  }
}

class RegionCell2 extends RegionCell {
  static int regionNumber = 2;

  RegionCell2({
    required Key key,
    required Region region,
  }) : super(key: key, region: region);

  @override
  final CentrifugalForceDirection _centrifugalForceDirection =
      CentrifugalForceDirection.Left;
  @override
  Border setBorder() {
    return super._setBorder(top: true, left: true, right: true);
  }

  @override
  void setCentripetalForceFrom() {
    _centripetalForceFrom = Offset(_size.width, _size.height / 2);
  }

  @override
  void setCentripetalForceTo() {
    Offset from = _centripetalForceFrom;
    _centripetalForceTo =
        Offset(from.dx + _size.width * 2, from.dy - _size.height * 1);
  }
}

class RegionCell3 extends RegionCell {
  static int regionNumber = 3;
  RegionCell3({
    required Key key,
    required Region region,
  }) : super(key: key, region: region);

  @override
  final CentrifugalForceDirection _centrifugalForceDirection =
      CentrifugalForceDirection.Left;
  @override
  Border setBorder() {
    return super._setBorder(top: true, left: true, right: true);
  }

  @override
  void setCentripetalForceFrom() {
    _centripetalForceFrom = Offset(_size.width, _size.height / 2);
  }

  @override
  void setCentripetalForceTo() {
    Offset from = _centripetalForceFrom;
    _centripetalForceTo =
        Offset(from.dx + _size.width * 2, from.dy + _size.height * 1);
  }
}

class RegionCell4 extends RegionCell {
  static int regionNumber = 4;
  RegionCell4({
    required Key key,
    required Region region,
  }) : super(key: key, region: region);

  @override
  final CentrifugalForceDirection _centrifugalForceDirection =
      CentrifugalForceDirection.Top;
  @override
  Border setBorder() {
    return super._setBorder(top: true, left: true, right: true);
  }

  @override
  void setCentripetalForceFrom() {
    _centripetalForceFrom = Offset(_size.width, _size.height);
  }

  @override
  void setCentripetalForceTo() {
    Offset from = _centripetalForceFrom;
    _centripetalForceTo =
        Offset(from.dx + _size.width * 2, from.dy + _size.height * 2);
  }
}

class RegionCell5 extends RegionCell {
  static int regionNumber = 5;
  RegionCell5({
    required Key key,
    required Region region,
  }) : super(key: key, region: region);

  @override
  final CentrifugalForceDirection _centrifugalForceDirection =
      CentrifugalForceDirection.Top;
  @override
  Border setBorder() {
    return super._setBorder(top: true, bottom: true, right: true);
  }

  @override
  void setCentripetalForceFrom() {
    _centripetalForceFrom = Offset(_size.width / 2, _size.height);
  }

  @override
  void setCentripetalForceTo() {
    Offset from = _centripetalForceFrom;
    _centripetalForceTo =
        Offset(from.dx + _size.width * 1, from.dy + _size.height * 2);
  }
}

class RegionCell6 extends RegionCell {
  static int regionNumber = 6;
  RegionCell6({
    required Key key,
    required Region region,
  }) : super(key: key, region: region);

  @override
  final CentrifugalForceDirection _centrifugalForceDirection =
      CentrifugalForceDirection.Top;
  @override
  Border setBorder() {
    return super._setBorder(top: true, bottom: true, right: true);
  }

  @override
  void setCentripetalForceFrom() {
    _centripetalForceFrom = Offset(_size.width / 2, _size.height);
  }

  @override
  void setCentripetalForceTo() {
    Offset from = _centripetalForceFrom;
    _centripetalForceTo =
        Offset(from.dx - _size.width * 1, from.dy + _size.height * 2);
  }
}

class RegionCell7 extends RegionCell {
  static int regionNumber = 7;
  RegionCell7({
    required Key key,
    required Region region,
  }) : super(key: key, region: region);

  @override
  final CentrifugalForceDirection _centrifugalForceDirection =
      CentrifugalForceDirection.Top;
  @override
  Border setBorder() {
    return super._setBorder(top: true, bottom: true, right: true);
  }

  @override
  void setCentripetalForceFrom() {
    _centripetalForceFrom = Offset(0, _size.height);
  }

  @override
  void setCentripetalForceTo() {
    Offset from = _centripetalForceFrom;
    _centripetalForceTo =
        Offset(from.dx - _size.width * 2, from.dy + _size.height * 2);
  }
}

class RegionCell8 extends RegionCell {
  static int regionNumber = 8;
  RegionCell8({
    required Key key,
    required Region region,
  }) : super(key: key, region: region);

  @override
  final CentrifugalForceDirection _centrifugalForceDirection =
      CentrifugalForceDirection.Right;
  @override
  Border setBorder() {
    return super._setBorder(left: true, bottom: true, right: true);
  }

  @override
  void setCentripetalForceFrom() {
    _centripetalForceFrom = Offset(0, _size.height / 2);
  }

  @override
  void setCentripetalForceTo() {
    Offset from = _centripetalForceFrom;
    _centripetalForceTo =
        Offset(from.dx - _size.width * 2, from.dy + _size.height * 1);
  }
}

class RegionCell9 extends RegionCell {
  static int regionNumber = 9;
  RegionCell9({
    required Key key,
    required Region region,
  }) : super(key: key, region: region);

  @override
  final CentrifugalForceDirection _centrifugalForceDirection =
      CentrifugalForceDirection.Right;
  @override
  Border setBorder() {
    return super._setBorder(left: true, bottom: true, right: true);
  }

  @override
  void setCentripetalForceFrom() {
    _centripetalForceFrom = Offset(0, _size.height / 2);
  }

  @override
  void setCentripetalForceTo() {
    Offset from = _centripetalForceFrom;
    _centripetalForceTo =
        Offset(from.dx - _size.width * 2, from.dy - _size.height * 1);
  }
}

class RegionCell10 extends RegionCell {
  static int regionNumber = 10;
  RegionCell10({
    required Key key,
    required Region region,
  }) : super(key: key, region: region);

  @override
  final CentrifugalForceDirection _centrifugalForceDirection =
      CentrifugalForceDirection.Bottom;
  @override
  Border setBorder() {
    return super._setBorder(left: true, bottom: true, right: true);
  }

  @override
  void setCentripetalForceFrom() {
    _centripetalForceFrom = Offset(0, 0);
  }

  @override
  void setCentripetalForceTo() {
    Offset from = _centripetalForceFrom;
    _centripetalForceTo =
        Offset(from.dx - _size.width * 2, from.dy - _size.height * 2);
  }
}

class RegionCell11 extends RegionCell {
  static int regionNumber = 11;
  RegionCell11({
    required Key key,
    required Region region,
  }) : super(key: key, region: region);

  @override
  final CentrifugalForceDirection _centrifugalForceDirection =
      CentrifugalForceDirection.Bottom;
  @override
  Border setBorder() {
    return super._setBorder(top: true, left: true, bottom: true);
  }

  @override
  void setCentripetalForceFrom() {
    _centripetalForceFrom = Offset(_size.width / 2, 0);
  }

  @override
  void setCentripetalForceTo() {
    Offset from = _centripetalForceFrom;
    _centripetalForceTo =
        Offset(from.dx - _size.width * 1, from.dy - _size.height * 2);
  }
}

class RegionCell12 extends RegionCell {
  static int regionNumber = 12;
  RegionCell12({
    required Key key,
    required Region region,
  }) : super(key: key, region: region);

  @override
  final CentrifugalForceDirection _centrifugalForceDirection =
      CentrifugalForceDirection.Bottom;
  @override
  Border setBorder() {
    return super._setBorder(top: true, bottom: true);
  }

  @override
  void setCentripetalForceFrom() {
    _centripetalForceFrom = Offset(_size.width / 2, 0);
  }

  @override
  void setCentripetalForceTo() {
    Offset from = _centripetalForceFrom;
    _centripetalForceTo =
        Offset(from.dx + _size.width * 1, from.dy - _size.height * 2);
  }
}
