import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc extends Bloc {
  PublishSubject<bool> _enableNotifications;
  BehaviorSubject<bool> _darkMode;
  PublishSubject<int> _navigationType;
  PublishSubject<bool> _loading;

  SettingsBloc() {
    _enableNotifications = PublishSubject();
    _darkMode = BehaviorSubject();
    _navigationType = PublishSubject();
    _loading = PublishSubject();
  }

  Sink<bool> get _setEnableNotifications => _enableNotifications.sink;
  Stream<bool> get getEnableNotifications => _enableNotifications.stream;

  Sink<bool> get _setDarkMode => _darkMode.sink;
  Stream<bool> get getDarkMode => _darkMode.stream;

  bool get isDarkMode => _darkMode.value;

  Sink<int> get _setNavigationType => _navigationType.sink;
  Stream<int> get getNavigationType => _navigationType.stream;

  Sink<bool> get _setLoading => _loading.sink;
  Stream<bool> get getLoading => _loading.stream;

  set setEnableNotifications(bool data) => _setEnableNotifications.add(data);
  set setDarkMode(bool data) => _setDarkMode.add(data);
  set setNavigationType(int data) => _setNavigationType.add(data);
  set setLoading(bool data) => _setLoading.add(data);

  BehaviorSubject<bool> get darkMode => this._darkMode;

  @override
  void dispose() {
    _enableNotifications.close();
    _darkMode.close();
    _navigationType.close();
    _loading.close();
  }
}
