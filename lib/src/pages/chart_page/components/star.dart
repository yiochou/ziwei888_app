import 'package:after_layout/after_layout.dart';
import 'package:app/src/algorithm/arrangement.dart';
import 'package:app/src/widget/vertial_text.dart';
import 'package:flutter/material.dart';

class StarItem extends StatefulWidget {
  final Star star;
  Size _size = Size(0, 0);

  StarItem({required Key key, required this.star}) : super(key: key);

  setSize(Size size) {
    _size = size;
  }

  Size getSize() {
    return _size;
  }

  @override
  State<StatefulWidget> createState() => StarItemState();
}

class StarItemState extends State<StarItem> with AfterLayoutMixin<StarItem> {
  void _setCellMetadata(BuildContext context) {
    RenderBox? box = context.findRenderObject() as RenderBox?;

    if (box != null) {
      widget.setSize(box.size);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            VerticalText(text: widget.star.name),
            VerticalText(text: widget.star.huaQi?.name, color: Colors.red),
          ],
        ));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _setCellMetadata(context);
  }
}
