import 'package:app/src/algorithm/arrangement.dart';
import 'package:app/src/algorithm/lunar.dart';
import 'package:test/test.dart';

void main() {
  group('TianGan', () {
    test('generate from lunar birth successfully', () {
      LunarBirth birth = LunarBirth.convert(DateTime(1994, 12, 27, 15, 30, 25));

      List<TianGan> tiangans = TianGan.generate(birth);
      Region.arrange(tiangans);

      List<String> tianganNames = tiangans.map((t) => t.name).toList();
      expect(tianganNames,
          ['丙', '丁', '戊', '己', '庚', '辛', '壬', '癸', '甲', '乙', '丙', '丁']);
    });
    test('generate from name successfully', () {
      String name = '丁';

      TianGan tiangan = TianGan.fromName(name);

      expect(tiangan.number, 4);
    });
  });
  group('DiZhi', () {
    test('generate from lunar birth successfully', () {
      List<DiZhi> dizhis = DiZhi.generate();
      Region.arrange(dizhis);

      List<String> dizhiNames = dizhis.map((e) => e.name).toList();

      expect(dizhiNames,
          ['寅', '卯', '辰', '巳', '午', '未', '申', '酉', '戌', '亥', '子', '丑']);
    });
    test('generate from name successfully', () {
      String name = '戌';

      DiZhi dizhi = DiZhi.fromName(name);

      expect(dizhi.number, 11);
    });
  });
  group('Palace', () {
    test('generate from lunar birth successfully', () {
      LunarBirth birth = LunarBirth.convert(DateTime(1994, 12, 27, 15, 30, 25));

      List<Palace> palaces = Palace.generate(birth);
      Region.arrange(palaces);

      List<String> palaceNames = palaces.map((e) => e.name).toList();
      expect(palaceNames, [
        '夫妻宮',
        '兄弟宮',
        '命宮',
        '父母宮',
        '福德宮',
        '田宅宮',
        '官祿宮',
        '交友宮',
        '遷移宮',
        '疾厄宮',
        '財帛宮',
        '子女宮',
      ]);
    });
  });
  group('Star', () {
    test('get correct huaqi from tiangan', () {}, skip: 'TODO: implement');
    test('generate ziwei stars group correctly', () {
      LunarBirth birth = LunarBirth.convert(DateTime(1994, 12, 27, 15, 30, 25));
      List<Palace> palaces = Palace.generate(birth);
      WuXingJu wuxing = WuXingJu(
          birth.year.tianGan, DiZhi.fromPalace(Palace.findMainPalace(palaces)));

      List<Star> ziweiStarGroup = Star.generateZiWeiStarGroup(birth, wuxing);
      Region.arrange(ziweiStarGroup);

      List<String> names = ziweiStarGroup.map((e) => e.name).toList();
      expect(names, [
        '廉貞',
        '天同',
        '武曲',
        '太陽',
        '天機',
        '紫微',
      ]);

      List<int> regionNumbers =
          ziweiStarGroup.map((e) => e.regionNumber).toList();
      expect(regionNumbers, [3, 6, 7, 8, 10, 11]);
    });

    test('generate tianfu stars group correctly', () {
      LunarBirth birth = LunarBirth.convert(DateTime(1994, 12, 27, 15, 30, 25));
      List<Palace> palaces = Palace.generate(birth);
      WuXingJu wuxing = WuXingJu(
          birth.year.tianGan, DiZhi.fromPalace(Palace.findMainPalace(palaces)));

      List<Star> tianfuStarGroup = Star.generateTianFuStarGroup(birth, wuxing);
      Region.arrange(tianfuStarGroup);

      List<String> tianfuStarGroupNames =
          tianfuStarGroup.map((e) => e.name).toList();
      expect(tianfuStarGroupNames, [
        '破軍',
        '天府',
        '太陰',
        '貪狼',
        '巨門',
        '天相',
        '天梁',
        '七殺',
      ]);

      List<int> regionNumbers =
          tianfuStarGroup.map((e) => e.regionNumber).toList();
      expect(regionNumbers, [1, 3, 4, 5, 6, 7, 8, 9]);
    });

    test('generate chang correctly', () {
      LunarBirth birth = LunarBirth.convert(DateTime(1994, 12, 27, 15, 30, 25));

      Star star = Star.generateChang(birth);

      expect(star.name, '文昌');
      expect(star.regionNumber, 1);
    });

    test('generate chyu correctly', () {
      LunarBirth birth = LunarBirth.convert(DateTime(1994, 12, 27, 15, 30, 25));

      Star star = Star.generateChyu(birth);

      expect(star.name, '文曲');
      expect(star.regionNumber, 11);
    });

    test('generate fu correctly', () {
      LunarBirth birth = LunarBirth.convert(DateTime(1994, 12, 27, 15, 30, 25));

      Star star = Star.generateFu(birth);

      expect(star.name, '左輔');
      expect(star.regionNumber, 1);
    });

    test('generate bi correctly', () {
      LunarBirth birth = LunarBirth.convert(DateTime(1994, 12, 27, 15, 30, 25));

      Star star = Star.generateBi(birth);

      expect(star.name, '右弼');
      expect(star.regionNumber, 11);
    });

    test('check if all stars are generated', () {
      LunarBirth birth = LunarBirth.convert(DateTime(1994, 12, 27, 15, 30, 25));
      List<Palace> palaces = Palace.generate(birth);
      WuXingJu wuxing = WuXingJu(
          birth.year.tianGan, DiZhi.fromPalace(Palace.findMainPalace(palaces)));

      List<Star> stars = Star.generate(birth, wuxing);

      expect(stars.length, Star.count);
    });
  });
  group('HuaQi', () {
    test('generate huaqi correctly', () {
      TianGan tianGan = TianGan(1);
      Star star = Star(6);

      HuaQi? huaqi = HuaQi.generate(tianGan, star);

      expect(huaqi?.name, '祿');
    });

    test('generate empty huaqi', () {
      TianGan tianGan = TianGan(1);
      Star star = Star(7);

      HuaQi? huaqi = HuaQi.generate(tianGan, star);

      expect(huaqi, null);
    });
  });
}
