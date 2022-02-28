import 'package:app/src/algorithm/arrangement.dart';
import 'package:lunar/lunar.dart';

import 'arrangement.dart';

class LunarYear {
  TianGan tianGan;
  DiZhi diZhi;

  LunarYear(this.tianGan, this.diZhi);

  static LunarYear fromDate(DateTime date) {
    Lunar lunarDate = Lunar.fromDate(date);

    TianGan gan = TianGan.fromName(lunarDate.getYearGan());
    DiZhi zhi = DiZhi.fromName(lunarDate.getYearZhi());

    return LunarYear(gan, zhi);
  }
}

class LunarTime {
  DiZhi dizhi;
  late int number;
  late String name;

  LunarTime(this.dizhi) {
    number = dizhi.number;
    name = dizhi.name;
  }

  static List<String> names = DiZhi.names;

  static LunarTime fromTime(DateTime dt) {
    String name = Lunar.fromDate(dt).getTimeZhi();

    return LunarTime(DiZhi.fromName(name));
  }
}

class LunarBirth {
  LunarYear year;
  int month;
  int day;
  LunarTime time;

  LunarBirth(this.year, this.month, this.day, this.time);

  static LunarBirth convert(DateTime birthday) {
    Lunar date = Lunar.fromDate(birthday);

    LunarYear lunarYear = LunarYear.fromDate(birthday);
    int month = date.getMonth();
    int day = date.getDay();
    LunarTime time = LunarTime.fromTime(birthday);

    return LunarBirth(lunarYear, month, day, time);
  }
}
