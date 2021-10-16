import 'package:flutter/widgets.dart';

typedef _RoutePredicate = bool Function(Route<dynamic>);

class NavigationService {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  static NavigationService instance = NavigationService();

  Future<T> pushNamed<T extends Object>(
      String routeName, {
        Object args,
      }) {
    return navigationKey.currentState?.pushNamed<T>(
      routeName,
      arguments: args,
    );
  }

  Future<T> push<T extends Object>(Route<T> route) {
    return navigationKey.currentState?.push<T>(route);
  }

  Future<T> pushReplacementNamed<T extends Object, TO extends Object>(
      String routeName, {
        Object args,
        TO result,
      }) {
    return navigationKey.currentState?.pushReplacementNamed<T, TO>(
      routeName,
      arguments: args,
      result: result,
    );
  }

  Future<T> pushNamedAndRemoveUntil<T extends Object>(
      String routeName, {
        Object args,
        _RoutePredicate predicate,
      }) {
    return navigationKey.currentState?.pushNamedAndRemoveUntil<T>(
      routeName,
      predicate ?? (_) => false,
      arguments: args,
    );
  }

  Future<T> pushAndRemoveUntil<T extends Object>(
      Route<T> route, {
        _RoutePredicate predicate,
      }) {
    return navigationKey.currentState?.pushAndRemoveUntil<T>(
      route,
      predicate ?? (_) => false,
    );
  }

  Future<bool> maybePop<T extends Object>([T result]) {
    return navigationKey.currentState?.maybePop<T>(result);
  }

  bool canPop() => navigationKey.currentState.canPop();

  void goBack<T extends Object>({T result}) {
    navigationKey.currentState?.pop<T>(result);
  }

  void popUntil(String route) {
    navigationKey.currentState?.popUntil(ModalRoute.withName(route));
  }

  RouteSettings pageSettings(BuildContext context) {
    return ModalRoute.of<RouteSettings>(context)?.settings;
  }
}
