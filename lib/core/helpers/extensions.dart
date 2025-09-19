import 'package:flutter/material.dart';

extension ContextEx on BuildContext {
  void pushNamed(String route,Object? arguments) {
    Navigator.pushNamed(this, route,arguments:arguments );
  }

  void pushNamedAndRemoveUntil(String route) {
    Navigator.pushNamedAndRemoveUntil(this, route, (_) => false);
  }

  void pushReplacementNamed(String route) {
    Navigator.pushReplacementNamed(this, route);
  }

  void pop() {
    Navigator.pop(this);
  }
}
