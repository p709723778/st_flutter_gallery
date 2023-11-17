import 'package:characters/characters.dart';

const String nullChar = '\u{200B}';

const _spaceVariant =
    r"\u0020|\u00A0|\u1680|\u180E|[\u2000-\u200F]|\u202F|\u205F|\u3000|\uFEFF";

final _spaceVariantReg = RegExp("(:?^$_spaceVariant*)(:?$_spaceVariant*\$)");

extension StringExtension on String {
  bool get hasValue => isNotEmpty;

  bool get noValue => isEmpty;

  String get pureValue {
    var value = '';
    value = replaceAll('\r', '');
    value = value.replaceAll('\n', '');
    value = value.replaceAll(' ', '');
    return value;
  }

  String takeCharacter(int count, {bool ellipsis = true}) {
    return characters.length <= count
        ? characters.toString()
        : '${characters.take(count)}...';
  }

  String get breakWord {
    return characters.map((e) => "$e$nullChar").join();
  }

  Future<String> replaceAllMappedAsync(
    Pattern exp,
    Future<String> Function(Match match) replace,
  ) async {
    final replaced = StringBuffer();
    var currentIndex = 0;
    for (final match in exp.allMatches(this)) {
      final prefix = match.input.substring(currentIndex, match.start);
      currentIndex = match.end;
      replaced
        ..write(prefix)
        ..write(await replace(match));
    }
    replaced.write(substring(currentIndex));
    return replaced.toString();
  }

  bool isPureNumber() {
    final reg = RegExp('^-?[0-9]+');
    return reg.hasMatch(this);
  }

  String trimEmptyEnd() => replaceAll(RegExp(r'\n+$'), '');

  String trimLeftStr(String str) {
    var tempString = this;
    while (tempString.startsWith(str)) {
      tempString = tempString.substring(1);
    }
    return tempString;
  }

  String removeUnprintable() => replaceAll(_spaceVariantReg, "");

  String escapeRegExp() => replaceAllMapped(
        RegExp(r'([.?*+^$[\]\\(){}|-])'),
        (e) => "\\${e.group(1)}",
      );
}

extension OptionStringExtension on String? {
  bool get hasValue => this?.isNotEmpty ?? false;

  bool get noValue => this?.isEmpty ?? true;

  String get pureValue {
    var value = '';
    if (this == null) return value;
    value = this!.replaceAll('\r', '');
    value = value.replaceAll('\n', '');
    value = value.replaceAll(' ', '');
    return value;
  }
}
