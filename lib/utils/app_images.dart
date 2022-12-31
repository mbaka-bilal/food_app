const String baseImagePath = 'assets/images/';

extension ImageExtension on String {
  String get png => '$baseImagePath$this.png';
  String get jpeg => '$baseImagePath$this.jpeg';
  String get jpg => '$baseImagePath$this.jpg';
}

class AppImages {
  static String appLogo = 'app_logo'.jpeg;
  static String success = 'success'.png;
  static String error = 'error'.png;
}
