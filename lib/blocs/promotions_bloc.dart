import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class PromotionsBloc extends Bloc {
  PublishSubject<bool> _loading;
  PublishSubject<int> _screen;

  PromotionsBloc() {
    _loading = PublishSubject();
    _screen = PublishSubject();
  }

  Sink<bool> get _setLoading => _loading.sink;
  Stream<bool> get getLoading => _loading.stream;

  Sink<int> get _setScreen => _screen.sink;
  Stream<int> get getScreen => _screen.stream;

  set setLoading(bool data) => _setLoading.add(data);
  set setScreen(int data) => _setScreen.add(data);

  @override
  void dispose() {
    _loading.close();
    _screen.close();
  }
}
