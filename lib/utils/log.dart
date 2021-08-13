import 'package:logger/logger.dart';

class Log {
  static final logger = Logger(printer: PrettyPrinter(colors: true));

  static void d(String message) {
    return logger.d(message);
  }

  static void e(String message) {
    return logger.e(message);
  }

  static void i(String message) {
    return logger.i(message);
  }

  static void w(String message) {
    return logger.w(message);
  }
}
