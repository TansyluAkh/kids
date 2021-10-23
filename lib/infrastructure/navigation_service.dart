import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef PageBuilder = Widget Function(BuildContext);

class NavigationService {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  static NavigationService instance = NavigationService();

  NavigatorState get _nav => navigationKey.currentState!;
  bool get canGoBack => _nav.canPop();

  Future pushTo(PageBuilder builder) {
    return _nav.push(MaterialPageRoute(builder: builder));
  }

  Future replaceTo(PageBuilder builder) {
    return _nav.pushReplacement(MaterialPageRoute(builder: builder));
  }

  void goBack<T extends Object>({T? result}) {
    return _nav.pop<T>(result);
  }
}
