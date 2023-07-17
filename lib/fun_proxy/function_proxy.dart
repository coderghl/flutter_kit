import 'dart:async';
import 'package:flutter/material.dart';

import '../log/log.dart';

class FunctionProxy {
  static final Map<String, dynamic> _funcThrottle = {};
  final Function target;
  final Duration timeout;

  FunctionProxy(this.target, {this.timeout = const Duration(milliseconds: 500)});

  void throttle() async {
    String key = hashCode.toString();
    bool enable = _funcThrottle[key] ?? true;
    if (enable) {
      try {
        _funcThrottle[key] = false;
        log("funThrottle", "start");
        await target();
        log("funThrottle", "end");
      } catch (e) {
        rethrow;
      } finally {
        _funcThrottle.remove(key);
      }
    }
  }

  void debounce() {
    String key = hashCode.toString();
    Timer? timer = _funcThrottle[key];
    timer?.cancel();
    timer = Timer(timeout, () {
      Timer? t = _funcThrottle.remove(key);
      t?.cancel();
      target.call();
    });
    _funcThrottle[key] = timer;
  }
}

extension FunctionExt on Function {
  VoidCallback throttle() {
    return FunctionProxy(this).throttle;
  }

  VoidCallback debounce({Duration timeout = const Duration(milliseconds: 300)}) {
    return FunctionProxy(this, timeout: timeout).debounce;
  }
}
