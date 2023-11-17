class ListUtil {
  static List<int> fixedLenList(List<int> codeUnits, {int length = 10}) {
    final resultList = List<int>.filled(length, 0);

    for (var i = 0; i < codeUnits.length && i < resultList.length; i++) {
      resultList[i] = codeUnits[i];
    }
    return resultList;
  }
}
