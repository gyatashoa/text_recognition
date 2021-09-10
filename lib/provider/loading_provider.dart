import 'package:flutter/cupertino.dart';

class LoadingProvider with ChangeNotifier {
  late bool _state;
  LoadingProvider() {
    this._state = false;
  }

  set setLoading(bool state) {
    this._state = state;
    notifyListeners();
  }

  bool get isLoading => this._state;
}
