import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc extends Bloc {
  PublishSubject<bool> _enableNotifications;
  PublishSubject<bool> _darkMode;
  PublishSubject<int> _navigationType;

  SettingsBloc() {
    _enableNotifications = PublishSubject();
    _darkMode = PublishSubject();
    _navigationType = PublishSubject();
  }

  Sink<bool> get _setEnableNotifications => _enableNotifications.sink;
  Stream<bool> get getEnableNotifications => _enableNotifications.stream;

  Sink<bool> get _setDarkMode => _darkMode.sink;
  Stream<bool> get getDarkMode => _darkMode.stream;

  Sink<int> get _setNavigationType => _navigationType.sink;
  Stream<int> get getNavigationType => _navigationType.stream;

  set setEnableNotifications(bool data) => _setEnableNotifications.add(data);
  set setDarkMode(bool data) => _setDarkMode.add(data);
  set setNavigationType(int data) => _setNavigationType.add(data);

  @override
  void dispose() {
    _enableNotifications.close();
    _darkMode.close();
    _navigationType.close();
  }
}
