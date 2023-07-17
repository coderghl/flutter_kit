import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void push(Widget page, {bool clearStack = false, void Function(dynamic v)? callback}) {
  clearStack
      ? Navigator.pushAndRemoveUntil(
          navigatorKey.currentContext!,
          CupertinoPageRoute(builder: (context) => page),
          (route) => false,
        ).then((value) => callback?.call(value))
      : Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => page),
        ).then((value) => callback?.call(value));
}

void pop([dynamic result]) {
  Navigator.pop(navigatorKey.currentContext!, result);
}
