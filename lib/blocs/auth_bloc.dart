import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc extends Bloc {
  PublishSubject<bool> _loading;
  PublishSubject<bool> _rememberMe;
  BehaviorSubject<bool> _pwdVisibility;
  BehaviorSubject<bool> _cPwdVisibility;

  AuthBloc() {
    _loading = PublishSubject();
    _rememberMe = PublishSubject();
    _pwdVisibility = BehaviorSubject();
    _cPwdVisibility = BehaviorSubject();
  }

  Sink<bool> get _setLoading => _loading.sink;
  Stream<bool> get getLoading => _loading.stream;

  Sink<bool> get _setRememberMe => _rememberMe.sink;
  Stream<bool> get getRememberMe => _rememberMe.stream;

  Sink<bool> get _setPwdVisibility => _pwdVisibility.sink;
  Stream<bool> get getPwdVisibility => _pwdVisibility.stream;

  Sink<bool> get _setCpwdVisibility => _cPwdVisibility.sink;
  Stream<bool> get getCpwdVisibility => _cPwdVisibility.stream;

  set setPwdVisibility(bool data) => _setPwdVisibility.add(data);
  set setRememberMe(bool data) => _setRememberMe.add(data);
  set setCpwdVisibility(bool data) => _setCpwdVisibility.add(data);
  set setLoading(bool data) => _setLoading.add(data);

  @override
  void dispose() {
    _loading.close();
    _rememberMe.close();
    _pwdVisibility.close();
    _cPwdVisibility.close();
  }
}
