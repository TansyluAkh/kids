import 'package:flutter/foundation.dart';

class ViewModel extends ChangeNotifier {
  final loadingStateNotifier = ValueNotifier(false);

  bool get isLoading => loadingStateNotifier.value;
  void setLoading(bool value) {
    loadingStateNotifier.value = value;
  }

  void init() {}

  @mustCallSuper
  @override
  void dispose() {
    super.dispose();
  }
}
