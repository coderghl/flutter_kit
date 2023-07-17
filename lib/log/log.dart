import 'dart:developer' as developer;

void log(String keywords, message, {LogLevel level = LogLevel.info}) {
  String resultMessage = "";
  switch (level) {
    case LogLevel.info:
      resultMessage = "\x1B[34m$message\x1B[0m";
      break;
    case LogLevel.success:
      resultMessage = "\x1B[32m$message\x1B[0m";
      break;
    case LogLevel.warning:
      resultMessage = "\x1B[33m$message\x1B[0m";
      break;
    case LogLevel.error:
      resultMessage = "\x1B[31m$message\x1B[0m";
      break;
  }
  developer.log(resultMessage, name: keywords);
}

enum LogLevel {
  info,
  success,
  warning,
  error,
}
