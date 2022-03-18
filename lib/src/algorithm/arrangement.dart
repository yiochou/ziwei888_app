import 'package:app/src/algorithm/lunar.dart';

class TianGan with RegionItem {
  int number;

  TianGan(this.number);

  String get name => TianGan.names[number - 1];

  static List<String> names = [
    '甲', // 1
    '乙', // 2
    '丙', // 3
    '丁', // 4
    '戊', // 5
    '己', // 6
    '庚', // 7
    '辛', // 8
    '壬', // 9
    '癸' // 10
  ];

  static List<TianGan> generate(LunarBirth birth) {
    int startNumber =
        (birth.year.tianGan.number * 2 + 1) % TianGan.names.length;
    List<TianGan> tianGans = [];

    for (int regionNumber = 1; regionNumber <= Region.count; regionNumber++) {
      int number = (startNumber + regionNumber - 1) % TianGan.names.length;
      number = number == 0 ? TianGan.names.length : number;

      TianGan tiangan = TianGan(number);
      tiangan.setRegionNumber(regionNumber);

      tianGans.add(tiangan);
    }

    return tianGans;
  }

  static TianGan fromName(String name) {
    for (int i = 0; i < TianGan.names.length; i++) {
      if (name == TianGan.names[i]) {
        return TianGan(i + 1);
      }
    }
    throw ('unsupported tian gan name');
  }
}

class DiZhi with RegionItem {
  int number;

  DiZhi(this.number) {
    regionNumber = DiZhi.numberToRegionNumber(number);
  }

  String get name => DiZhi.names[number - 1];

  static List<String> names = [
    '子', // 1
    '丑', // 2
    '寅', // 3
    '卯', // 4
    '辰', // 5
    '巳', // 6
    '午', // 7
    '未', // 8
    '申', // 9
    '酉', // 10
    '戌', // 11
    '亥', // 12
  ];
  static int regionStartNumber = 11;

  static int numberToRegionNumber(int number) =>
      Region.abs(DiZhi.regionStartNumber + number - 1);

  static List<DiZhi> generate() {
    List<DiZhi> diZhis = [];

    for (int number = 1; number <= DiZhi.names.length; number++) {
      diZhis.add(DiZhi(number));
    }

    return diZhis;
  }

  static DiZhi fromName(String name) {
    for (int i = 0; i < DiZhi.names.length; i++) {
      if (name == DiZhi.names[i]) {
        return DiZhi(i + 1);
      }
    }
    throw ('unsupported di zhi name');
  }

  static DiZhi fromPalace(Palace palace) =>
      DiZhi(Region.abs(palace.regionNumber - DiZhi.regionStartNumber + 1));
}

class Palace with RegionItem {
  int number;

  Palace(this.number);

  String get name => Palace.names[number - 1];

  static List<String> names = [
    '命宮', // 1
    '兄弟宮', // 2
    '夫妻宮', // 3
    '子女宮', // 4
    '財帛宮', // 5
    '疾厄宮', // 6
    '遷移宮', // 7
    '交友宮', // 8
    '官祿宮', // 9
    '田宅宮', // 10
    '福德宮', // 11
    '父母宮', // 12
  ];

  static List<Palace> generate(LunarBirth birth) {
    List<Palace> palaces = [];
    int startRegionNumber = birth.month - birth.time.number + 1;

    for (int number = 1; number <= Palace.names.length; number++) {
      Palace palace = Palace(number);

      int regionNumber = Region.abs(startRegionNumber - number + 1);
      palace.setRegionNumber(regionNumber);

      palaces.add(palace);
    }

    return palaces;
  }

  static Palace findMainPalace(List<Palace> palaces) =>
      palaces.firstWhere((palace) => palace.number == 1);
}

class WuXingJu {
  TianGan tianGan;
  DiZhi diZhi;
  int number;

  WuXingJu(this.tianGan, this.diZhi)
      : number = WuXingJu.numberMap[tianGan.number][diZhi.number];

  String get name => WuXingJu.names[number - 1];
  int get offset => WuXingJu.offsets[number - 1];

  static List<String> names = ['金四局', '木三局', '水二局', '火六局', '土五局'];
  static List<int> offsets = [4, 3, 2, 6, 5];
  static Map<dynamic, dynamic> numberMap = {
    1: {
      1: 3,
      2: 3,
      3: 4,
      4: 4,
      5: 2,
      6: 2,
      7: 5,
      8: 5,
      9: 1,
      10: 1,
      11: 4,
      12: 4
    },
    2: {
      1: 4,
      2: 4,
      3: 5,
      4: 5,
      5: 1,
      6: 1,
      7: 2,
      8: 2,
      9: 3,
      10: 3,
      11: 5,
      12: 5
    },
    3: {
      1: 5,
      2: 5,
      3: 2,
      4: 2,
      5: 3,
      6: 3,
      7: 1,
      8: 1,
      9: 4,
      10: 4,
      11: 2,
      12: 2
    },
    4: {
      1: 2,
      2: 2,
      3: 1,
      4: 1,
      5: 4,
      6: 4,
      7: 3,
      8: 3,
      9: 5,
      10: 5,
      11: 1,
      12: 1
    },
    5: {
      1: 1,
      2: 1,
      3: 3,
      4: 3,
      5: 5,
      6: 5,
      7: 4,
      8: 4,
      9: 2,
      10: 2,
      11: 3,
      12: 3
    },
    6: {
      1: 3,
      2: 3,
      3: 4,
      4: 4,
      5: 2,
      6: 2,
      7: 5,
      8: 5,
      9: 1,
      10: 1,
      11: 4,
      12: 4
    },
    7: {
      1: 4,
      2: 4,
      3: 5,
      4: 5,
      5: 1,
      6: 1,
      7: 2,
      8: 2,
      9: 3,
      10: 3,
      11: 5,
      12: 5
    },
    8: {
      1: 5,
      2: 5,
      3: 2,
      4: 2,
      5: 3,
      6: 3,
      7: 1,
      8: 1,
      9: 4,
      10: 4,
      11: 2,
      12: 2
    },
    9: {
      1: 2,
      2: 2,
      3: 1,
      4: 1,
      5: 4,
      6: 4,
      7: 3,
      8: 3,
      9: 5,
      10: 5,
      11: 1,
      12: 1
    },
    10: {
      1: 1,
      2: 1,
      3: 3,
      4: 3,
      5: 5,
      6: 5,
      7: 4,
      8: 4,
      9: 2,
      10: 2,
      11: 3,
      12: 3
    }
  };
}

class Star with RegionItem {
  int number;
  late HuaQi? huaQi;

  Star(this.number) {
    if (number <= 0) throw ('invalid star number');
  }

  String get name => Star.names[number - 1];

  HuaQi? getHuaQi(TianGan tianGan) => HuaQi.generate(tianGan, this);

  // 向心力
  HuaQi? getCentripetalForce(Region oppositeRegion) {
    return HuaQi.generate(oppositeRegion.tianGan, this);
  }

  // 離心力
  HuaQi? getCentrifugalForce(Region region) {
    return HuaQi.generate(region.tianGan, this);
  }

  static int get count => Star.names.length;

  static int getZiWeiStartRegion(LunarBirth birth, WuXingJu wuxing) {
    List orderToWuxing = [4, 5, 1, 2, 3];
    Map wuxingStartRegionNumber = {
      4: 8,
      5: 5,
      1: 10,
      2: 3,
      3: 12,
    };
    int quotient = birth.day ~/ wuxing.offset;
    int reminder = birth.day % wuxing.offset;

    if (reminder == 0) {
      return quotient;
    }

    int order = (orderToWuxing.indexOf(wuxing.number) + reminder - 1) %
        orderToWuxing.length;
    int startRegionNumber = wuxingStartRegionNumber[orderToWuxing[order]];

    return Region.abs(startRegionNumber + quotient);
  }

  static List<Star> generateZiWeiStarGroup(LunarBirth birth, WuXingJu wuxing) {
    List<int?> order = [1, 2, null, 3, 4, 5, null, null, 6];
    int startRegionNumber = Star.getZiWeiStartRegion(birth, wuxing);
    List<Star> stars = [];

    for (int i = 0; i < order.length; i++) {
      int? number = order[i];
      if (number == null) continue;

      Star star = Star(number);
      star.setRegionNumber(Region.abs(startRegionNumber - i));

      stars.add(star);
    }

    return stars;
  }

  static List<Star> generateTianFuStarGroup(LunarBirth birth, WuXingJu wuxing) {
    List<int?> order = [7, 8, 9, 10, 11, 12, 13, null, null, null, 14];
    int ziweiStartRegionNumber = Star.getZiWeiStartRegion(birth, wuxing);
    int tianfuStartRegionNumber =
        Region.abs(Region.count - (ziweiStartRegionNumber - 1) + 1);
    List<Star> stars = [];

    for (int i = 0; i < order.length; i++) {
      int? number = order[i];
      if (number == null) continue;

      Star star = Star(number);
      int regionNumber = Region.abs(i + tianfuStartRegionNumber);
      star.setRegionNumber(regionNumber);

      stars.add(star);
    }

    return stars;
  }

  static Star generateChang(LunarBirth birth) {
    int changStartRegionNumber = 9;

    Star star = Star(15);
    int regionNumber =
        Region.abs(changStartRegionNumber - birth.time.number + 1);
    star.setRegionNumber(regionNumber);

    return star;
  }

  static Star generateChyu(LunarBirth birth) {
    int chyuStartRegionNumber = 3;

    Star star = Star(16);
    int regionNumber =
        Region.abs(chyuStartRegionNumber + birth.time.number - 1);
    star.setRegionNumber(regionNumber);

    return star;
  }

  static Star generateFu(LunarBirth birth) {
    int fuStartRegionNumber = 3;

    Star star = Star(17);
    int regionNumber = Region.abs(fuStartRegionNumber + birth.month - 1);
    star.setRegionNumber(regionNumber);

    return star;
  }

  static Star generateBi(LunarBirth birth) {
    int biStartRegionNumber = 9;

    Star star = Star(18);
    int regionNumber = Region.abs(biStartRegionNumber - birth.month + 1);
    star.setRegionNumber(regionNumber);

    return star;
  }

  static List<Star> generate(LunarBirth birth, WuXingJu wuxing) {
    List<Star> ziweiStarGroup = Star.generateZiWeiStarGroup(birth, wuxing);
    List<Star> tianfuStarGroup = Star.generateTianFuStarGroup(birth, wuxing);
    Star chang = Star.generateChang(birth);
    Star chyu = Star.generateChyu(birth);
    Star fu = Star.generateFu(birth);
    Star bi = Star.generateBi(birth);

    List<Star> stars = [
      ...ziweiStarGroup,
      ...tianfuStarGroup,
      chang,
      chyu,
      fu,
      bi,
    ];

    return stars;
  }

  static List names = [
    '紫微', // 1
    '天機', // 2
    '太陽', // 3
    '武曲', // 4
    '天同', // 5
    '廉貞', // 6
    '天府', // 7
    '太陰', // 8
    '貪狼', // 9
    '巨門', // 10
    '天相', // 11
    '天梁', // 12
    '七殺', // 13
    '破軍', // 14
    '文昌', // 15
    '文曲', // 16
    '左輔', // 17
    '右弼' // 18
  ];
}

class HuaQi {
  int number;

  HuaQi(this.number);

  String get name => HuaQi.names[number - 1];

  static List names = ['祿', '權', '科', '忌'];

  // 十干四化: 天干 -> (化氣, 星辰)
  static Map<int, List<int>> huaQiByTianGan = {
    1: [6, 14, 4, 3],
    2: [2, 12, 1, 8],
    3: [5, 2, 15, 6],
    4: [8, 5, 2, 10],
    5: [9, 8, 18, 2],
    6: [4, 9, 12, 16],
    7: [3, 4, 8, 5],
    8: [10, 3, 16, 15],
    9: [12, 1, 17, 4],
    10: [14, 10, 8, 9]
  };

  static HuaQi? generate(TianGan tianGan, Star star) {
    if (!HuaQi.huaQiByTianGan.containsKey(tianGan.number)) {
      throw Exception('invalid tianGan number');
    }
    List<int> list = HuaQi.huaQiByTianGan[tianGan.number]!;

    for (int i = 0; i < list.length; i++) {
      if (star.number == list[i]) {
        return HuaQi(i + 1);
      }
    }
  }
}

class Region {
  final int number;
  static int count = 12;

  late TianGan tianGan;
  late DiZhi diZhi;
  late Palace palace;
  late List<Star> stars;
  late HuaQi huaQi;

  Region(this.number) {
    if (number <= 0 || number > Region.count) {
      throw 'invalid region number';
    }
  }

  setStars(List<Star> stars) {}

  static int abs(int number) {
    number = (Region.count + number) % Region.count;

    return number == 0 ? Region.count : number;
  }

  static void arrange(List list) {
    list.sort((a, b) => a.regionNumber - b.regionNumber);
  }

  List filterRegionItems(List items) {
    return items.where((item) => item.regionNumber == number).toList();
  }

  filterRegionItem(List items) {
    return filterRegionItems(items)[0];
  }
}

mixin RegionItem {
  late int regionNumber;

  int getRegionNumber() {
    return regionNumber;
  }

  setRegionNumber(int number) {
    regionNumber = number;
  }
}

class ChartInfo {
  late List<Region> regions;
  ChartInfo({required LunarBirth birth}) {
    regions = ChartInfo.generateRegions(birth);
  }

  Region getRegion(int regionNumber) {
    return regions[regionNumber - 1];
  }

  static List<Region> generateRegions(LunarBirth birth) {
    List<Region> regions = [];

    List<TianGan> tianGans = TianGan.generate(birth);
    List<DiZhi> diZhis = DiZhi.generate();
    List<Palace> palaces = Palace.generate(birth);

    WuXingJu wuxing = WuXingJu(
        birth.year.tianGan, DiZhi.fromPalace(Palace.findMainPalace(palaces)));
    List<Star> stars = Star.generate(birth, wuxing);
    // 化氣
    for (Star star in stars) {
      star.huaQi = HuaQi.generate(birth.year.tianGan, star);
    }

    for (int regionNumber = 1; regionNumber <= Region.count; regionNumber++) {
      Region region = Region(regionNumber);

      // 天干
      region.tianGan = region.filterRegionItem(tianGans);

      // 地支
      region.diZhi = region.filterRegionItem(diZhis);

      // 宮位
      region.palace = region.filterRegionItem(palaces);

      // 星
      region.stars = region.filterRegionItems(stars) as List<Star>;

      regions.add(region);
    }

    return regions;
  }
}
