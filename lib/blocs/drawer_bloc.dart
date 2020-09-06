import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class DrawerBloc extends Bloc {
  PublishSubject<bool> _loading;
  PublishSubject<bool> _isMapReady;

  DrawerBloc() {
    _loading = PublishSubject();
    _isMapReady = PublishSubject();
  }

  Sink<bool> get _setLoading => _loading.sink;
  Stream<bool> get getLoading => _loading.stream;

  Sink<bool> get _setIsMapReady => _isMapReady.sink;
  Stream<bool> get getIsMapReady => _isMapReady.stream;

  set setLoading(bool data) => _setLoading.add(data);
  set setIsMapReady(bool data) => _setIsMapReady.add(data);

  @override
  void dispose() {
    _loading.close();
    _isMapReady.close();
  }
}
