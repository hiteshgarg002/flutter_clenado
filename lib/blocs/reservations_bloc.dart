import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class ReservationsBloc extends Bloc {
  PublishSubject<bool> _loading;

  ReservationsBloc() {
    _loading = PublishSubject();
  }

  Sink<bool> get _setLoading => _loading.sink;
  Stream<bool> get getLoading => _loading.stream;
  
  set setLoading(bool data) => _setLoading.add(data);

  @override
  void dispose() {
    _loading.close();
  }
}
