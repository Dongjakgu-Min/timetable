import 'package:flutter/cupertino.dart';

class KoreanCupertinoLocalizations extends DefaultCupertinoLocalizations {
  @override
  String get anteMeridiemAbbreviation => '오전';

  @override
  String get postMeridiemAbbreviation => '오후';
}

class KoreanCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const KoreanCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ko';

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    return KoreanCupertinoLocalizations();
  }

  @override
  bool shouldReload(
          covariant LocalizationsDelegate<CupertinoLocalizations> old) =>
      false;
}