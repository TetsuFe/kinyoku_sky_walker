import 'package:kinyoku_continue/title/models/current_title_names.dart';
import 'package:kinyoku_continue/title/models/title_names.dart';

class TitleService {
  static int getTitleIndex(int stoicDays) {
    var i = 0;
    for (var d in titleUnlockDays) {
      if (stoicDays < d) {
        return i;
      }
      i++;
    }
    return i;
  }

  static int getCurrentTitleIndex(int stoicDays) {
    var i = 0;
    for (var d in currentTitleUnlockDays) {
      if (stoicDays < d) {
        return i;
      }
      i++;
    }
    return i;
  }

  static int getDaysForNextTitle(int stoicDays) {
    for (var i = 0; i < titleUnlockDays.length - 1; i++) {
      if (i == 0) {
        if (stoicDays <= titleUnlockDays[i]) {
          if (stoicDays == 0) {
            return titleUnlockDays[i] - stoicDays;
          }
          if (stoicDays == 1) {
            return titleUnlockDays[i + 1] - stoicDays;
          }
        }
      }
      if (i != 0) {
        if (stoicDays >= titleUnlockDays[i] &&
            stoicDays < titleUnlockDays[i + 1]) {
          return titleUnlockDays[i + 1] - stoicDays;
        }
        if (stoicDays <= titleUnlockDays[i]) {
          return titleUnlockDays[i] - stoicDays;
        }
      }
    }
    return 0;
  }

  static int getDaysForNextCurrentTitle(int stoicDays) {
    for (var i = 0; i < currentTitleUnlockDays.length - 1; i++) {
      if (i == 0) {
        if (stoicDays <= currentTitleUnlockDays[i]) {
          if (stoicDays == 0) {
            return currentTitleUnlockDays[i] - stoicDays;
          }
          if (stoicDays == 1) {
            return currentTitleUnlockDays[i + 1] - stoicDays;
          }
        }
      }
      if (i != 0) {
        if (stoicDays >= currentTitleUnlockDays[i] &&
            stoicDays < currentTitleUnlockDays[i + 1]) {
          return currentTitleUnlockDays[i + 1] - stoicDays;
        }
        if (stoicDays <= currentTitleUnlockDays[i]) {
          return currentTitleUnlockDays[i] - stoicDays;
        }
      }
    }
    return 0;
  }

  static String stoicDaysToTitle(int stoicDays) {
    String name;
    if (stoicDays == null ||
        stoicDays == 0 ||
        stoicDays >= titleUnlockDays[0]) {
      name = titleNames[0];
    }
    if (stoicDays >= titleUnlockDays[1]) {
      name = titleNames[1];
    }
    if (stoicDays >= titleUnlockDays[2]) {
      name = titleNames[2];
    }
    if (stoicDays >= titleUnlockDays[3]) {
      name = titleNames[3];
    }
    if (stoicDays >= titleUnlockDays[4]) {
      name = titleNames[4];
    }
    if (stoicDays >= titleUnlockDays[5]) {
      name = titleNames[5];
    }
    if (stoicDays >= titleUnlockDays[6]) {
      name = titleNames[6];
    }
    if (stoicDays >= titleUnlockDays[7]) {
      name = titleNames[7];
    }
    if (stoicDays >= titleUnlockDays[8]) {
      name = titleNames[8];
    }
    if (stoicDays >= titleUnlockDays[9]) {
      name = titleNames[9];
    }
    if (stoicDays >= titleUnlockDays[10]) {
      name = titleNames[10];
    }
    if (stoicDays >= titleUnlockDays[11]) {
      name = titleNames[11];
    }
    if (stoicDays >= titleUnlockDays[12]) {
      name = titleNames[12];
    }
    if (stoicDays >= titleUnlockDays[13]) {
      name = titleNames[13];
    }
    if (stoicDays >= titleUnlockDays[14]) {
      name = titleNames[14];
    }
    if (stoicDays >= titleUnlockDays[15]) {
      name = titleNames[15];
    }
    if (stoicDays >= titleUnlockDays[16]) {
      name = titleNames[16];
    }
    if (stoicDays >= titleUnlockDays[17]) {
      name = titleNames[17];
    }
    if (stoicDays >= titleUnlockDays[18]) {
      name = titleNames[18];
    }
    if (stoicDays >= titleUnlockDays[19]) {
      name = titleNames[19];
    }
    if (stoicDays >= titleUnlockDays[20]) {
      name = titleNames[20];
    }
    if (stoicDays >= titleUnlockDays[21]) {
      name = titleNames[21];
    }
    if (stoicDays >= titleUnlockDays[22]) {
      name = titleNames[22];
    }
    if (stoicDays >= titleUnlockDays[23]) {
      name = titleNames[23];
    }
    if (stoicDays >= titleUnlockDays[24]) {
      name = titleNames[24];
    }
    if (stoicDays >= titleUnlockDays[25]) {
      name = titleNames[25];
    }
    if (stoicDays >= titleUnlockDays[26]) {
      name = titleNames[26];
    }
    if (stoicDays >= titleUnlockDays[27]) {
      name = titleNames[27];
    } else {
      Error();
    }
    return name;
  }

  static String currentStoicDaysToTitle(int stoicDays) {
    String name;
    if (stoicDays == null ||
        stoicDays == 0 ||
        stoicDays >= currentTitleUnlockDays[0]) {
      name = currentTitleNames[0];
    }
    if (stoicDays >= currentTitleUnlockDays[1]) {
      name = currentTitleNames[1];
    }
    if (stoicDays >= currentTitleUnlockDays[2]) {
      name = currentTitleNames[2];
    }
    if (stoicDays >= currentTitleUnlockDays[3]) {
      name = currentTitleNames[3];
    }
    if (stoicDays >= currentTitleUnlockDays[4]) {
      name = currentTitleNames[4];
    }
    if (stoicDays >= currentTitleUnlockDays[5]) {
      name = currentTitleNames[5];
    }
    if (stoicDays >= currentTitleUnlockDays[6]) {
      name = currentTitleNames[6];
    }
    if (stoicDays >= currentTitleUnlockDays[7]) {
      name = currentTitleNames[7];
    }
    if (stoicDays >= currentTitleUnlockDays[8]) {
      name = currentTitleNames[8];
    }
    if (stoicDays >= currentTitleUnlockDays[9]) {
      name = currentTitleNames[9];
    }
    if (stoicDays >= currentTitleUnlockDays[10]) {
      name = currentTitleNames[10];
    }
    if (stoicDays >= currentTitleUnlockDays[11]) {
      name = currentTitleNames[11];
    }
    if (stoicDays >= currentTitleUnlockDays[12]) {
      name = currentTitleNames[12];
    }
    if (stoicDays >= currentTitleUnlockDays[13]) {
      name = currentTitleNames[13];
    }
    if (stoicDays >= currentTitleUnlockDays[14]) {
      name = currentTitleNames[14];
    }
    if (stoicDays >= currentTitleUnlockDays[15]) {
      name = currentTitleNames[15];
    }
    if (stoicDays >= currentTitleUnlockDays[16]) {
      name = currentTitleNames[16];
    }
    if (stoicDays >= currentTitleUnlockDays[17]) {
      name = currentTitleNames[17];
    }
    if (stoicDays >= currentTitleUnlockDays[18]) {
      name = currentTitleNames[18];
    }
    if (stoicDays >= currentTitleUnlockDays[19]) {
      name = currentTitleNames[19];
    }
    if (stoicDays >= currentTitleUnlockDays[20]) {
      name = currentTitleNames[20];
    }
    if (stoicDays >= currentTitleUnlockDays[21]) {
      name = currentTitleNames[21];
    }
    if (stoicDays >= currentTitleUnlockDays[22]) {
      name = currentTitleNames[22];
    }
    if (stoicDays >= currentTitleUnlockDays[23]) {
      name = currentTitleNames[23];
    }
    if (stoicDays >= currentTitleUnlockDays[24]) {
      name = currentTitleNames[24];
    }
    if (stoicDays >= currentTitleUnlockDays[25]) {
      name = currentTitleNames[25];
    }
    if (stoicDays >= currentTitleUnlockDays[26]) {
      name = currentTitleNames[26];
    }
    if (stoicDays >= currentTitleUnlockDays[27]) {
      name = currentTitleNames[27];
    }
    if (stoicDays >= currentTitleUnlockDays[28]) {
      name = currentTitleNames[28];
    }
    if (stoicDays >= currentTitleUnlockDays[29]) {
      name = currentTitleNames[29];
    }
    {
      Error();
    }
    return name;
  }
}
