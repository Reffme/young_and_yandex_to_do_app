import 'package:logger/logger.dart';

class BaseLogger {
  static final Logger _logger = Logger();

  static void log(String message) {
    _logger.d(message);
  }

  static void error(String message) {
    _logger.e(message);
  }

  static void info(String message) {
    _logger.i(message);
  }

  static void warning(String message) {
    _logger.w(message);
  }
}
