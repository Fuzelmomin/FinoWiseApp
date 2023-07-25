import 'package:rxdart/rxdart.dart';

class StreamUtils {
  static BehaviorSubject<SelectCountry> selectedCountrySubject =
  BehaviorSubject<SelectCountry>.seeded(SelectCountry('🇮🇳', ' (+91)', '+91'));
  static BehaviorSubject<int> selectedPageSubject = BehaviorSubject<int>.seeded(0);

}


class SelectCountry {
  String flag;
  String countryName;
  String countryCode;

  SelectCountry(this.flag, this.countryName, this.countryCode);
}