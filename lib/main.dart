// ignore_for_file: avoid_print

// import 'package:app/src/pages/chart_page/index.dart';
import 'package:app/src/pages/chart_page/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: ChartPage(birthday: DateTime(1971, 2, 15, 3, 30, 25))
      home: const MyHomePage(title: '排盤 Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _birthDate = DateTime.now();
  TimeOfDay _birthTime = TimeOfDay.now();

  void _setBirthDate(DateTime date) {
    setState(() {
      _birthDate = date;
    });
  }

  void _setBirthTime(TimeOfDay time) {
    setState(() {
      _birthTime = time;
    });
  }

  DateTime _getBirthDay() {
    return DateTime(_birthDate.year, _birthDate.month, _birthDate.day,
        _birthTime.hour, _birthTime.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  TextButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true, onConfirm: (date) {
                          _setBirthDate(date);
                        }, currentTime: DateTime.now(), locale: LocaleType.zh);
                      },
                      child: Text(
                        DateFormat('yyyy-MM-dd').format(_getBirthDay()),
                        style: const TextStyle(
                            height: 1.2, fontSize: 20, color: Colors.black),
                      )),
                  TextButton(
                      onPressed: () {
                        DatePicker.showTimePicker(context,
                            showTitleActions: true, onConfirm: (time) {
                          _setBirthTime(TimeOfDay.fromDateTime(time));
                        }, currentTime: DateTime.now(), locale: LocaleType.zh);
                      },
                      child: Text(
                        DateFormat('kk:mm').format(_getBirthDay()),
                        style: const TextStyle(
                            height: 1.2, fontSize: 20, color: Colors.black),
                      ))
                ]),
            const SizedBox(height: 40),
            OutlinedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                  side: MaterialStateProperty.all(
                      const BorderSide(width: 1, color: Colors.black)),
                ),
                child: const Text('排盤'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChartPage(birthday: _getBirthDay())));
                }),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
