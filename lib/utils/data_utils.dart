//intl 라이브러리 사용
import 'package:intl/intl.dart';

class DataUtils {
  static final oCcy = new NumberFormat('#,###', "ko_KR");

//스트링 값의 price를 받아서 won으로 바꾸는 메소드
  static String calcStringToWon(String priceString) {
    if (priceString == "무료나눔") {
      return priceString;
    }
    return "${oCcy.format(int.parse(priceString))}원";
  }
}
