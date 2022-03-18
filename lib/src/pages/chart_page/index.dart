import 'package:app/src/algorithm/arrangement.dart';
import 'package:app/src/algorithm/lunar.dart';
import 'package:flutter/material.dart';

import 'components/region_cell/index.dart';

class ChartPage extends StatefulWidget {
  late LunarBirth birth;
  late ChartInfo chartInfo;

  ChartPage({Key? key, required DateTime birthday}) : super(key: key) {
    birth = LunarBirth.convert(birthday);
    chartInfo = ChartInfo(birth: birth);
  }

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    ChartInfo chartInfo = widget.chartInfo;
    List<RegionCell> regionCells = RegionCell.generateFromChartInfo(chartInfo);

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              title: const Text('命盤', style: TextStyle(color: Colors.black)),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
            )),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Center(
              child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              TableRow(
                children: <Widget>[
                  regionCells[RegionCell4.regionNumber - 1],
                  regionCells[RegionCell5.regionNumber - 1],
                  regionCells[RegionCell6.regionNumber - 1],
                  regionCells[RegionCell7.regionNumber - 1],
                ],
              ),
              TableRow(
                children: <Widget>[
                  regionCells[RegionCell3.regionNumber - 1],
                  Container(),
                  Container(),
                  regionCells[RegionCell8.regionNumber - 1],
                ],
              ),
              TableRow(
                children: <Widget>[
                  regionCells[RegionCell2.regionNumber - 1],
                  Container(),
                  Container(),
                  regionCells[RegionCell9.regionNumber - 1],
                ],
              ),
              TableRow(
                children: <Widget>[
                  regionCells[RegionCell1.regionNumber - 1],
                  regionCells[RegionCell12.regionNumber - 1],
                  regionCells[RegionCell11.regionNumber - 1],
                  regionCells[RegionCell10.regionNumber - 1],
                ],
              ),
            ],
          )),
        ));
  }
}
