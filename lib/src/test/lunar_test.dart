import 'package:app/src/algorithm/lunar.dart';
import 'package:test/test.dart';

void main() {
  group('LunarYear', () {
    test('lunar year can be generated from date successfully', () {
      DateTime date = DateTime(2020, 6, 17);

      LunarYear lunarYear = LunarYear.fromDate(date);

      expect(lunarYear.tianGan.name, '庚');
      expect(lunarYear.diZhi.name, '子');
    });
  });

  group('LunarTime', () {
    test('lunar time can be generated from name successfully', () {
      DateTime datetime = DateTime(2020, 6, 17, 15, 30, 37);

      LunarTime lunarTime = LunarTime.fromTime(datetime);

      expect(lunarTime.name, '申');
    });
  });

  group('LunarBirth', () {
    test('birthday converting should be success', () {
      DateTime birthday = DateTime(1994, 12, 27, 15, 30, 37);

      LunarBirth lunarBirth = LunarBirth.convert(birthday);

      expect(lunarBirth.year.tianGan.name, '甲');
      expect(lunarBirth.year.diZhi.name, '戌');
      expect(lunarBirth.month, 11);
      expect(lunarBirth.day, 25);
      expect(lunarBirth.time.name, '申');
    });
  });
}
