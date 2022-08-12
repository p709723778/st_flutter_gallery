import 'dart:async';

import 'package:flutter/foundation.dart';

extension FunctionExtension on Function {
  VoidCallback throttle() {
    return FunctionProxy(this).throttle;
  }

  VoidCallback throttleWithTimeout({int? timeout}) {
    return FunctionProxy(this, timeout: timeout).throttleWithTimeout;
  }

  VoidCallback debounce({int? timeout}) {
    return FunctionProxy(this, timeout: timeout).debounce;
  }
}

class FunctionProxy {
  FunctionProxy(this.target, {int? timeout}) : timeout = timeout ?? 500;

  static final Map<String, bool> _funcThrottle = {};
  static final Map<String, Timer> _funcDebounce = {};
  final Function? target;

  final int timeout;

  Future<void> throttle() async {
    final key = hashCode.toString();
    final enable = _funcThrottle[key] ?? true;
    if (enable) {
      _funcThrottle[key] = false;
      try {
        Function.apply(target!, null);
      } on Exception catch (e) {
        debugPrint(e.toString());
        rethrow;
      } finally {
        _funcThrottle.remove(key);
      }
    }
  }

  void throttleWithTimeout() {
    final key = hashCode.toString();
    final enable = _funcThrottle[key] ?? true;
    if (enable) {
      _funcThrottle[key] = false;
      Timer(Duration(milliseconds: timeout), () {
        _funcThrottle.remove(key);
      });
      Function.apply(target!, null);
    }
  }

  void debounce() {
    final key = hashCode.toString();
    var timer = _funcDebounce[key];
    timer?.cancel();
    timer = Timer(Duration(milliseconds: timeout), () {
      final t = _funcDebounce.remove(key);
      t?.cancel();
      Function.apply(target!, null);
    });
    _funcDebounce[key] = timer;
  }
}
