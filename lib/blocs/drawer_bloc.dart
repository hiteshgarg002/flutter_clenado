import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class DrawerBloc extends Bloc {
  PublishSubject<bool> _loading;
  PublishSubject<bool> _isMapReady;
  PublishSubject<DateTime> _from;
  PublishSubject<DateTime> _to;
  PublishSubject<int> _hours;
  PublishSubject<double> _amount;

  DrawerBloc() {
    _loading = PublishSubject();
    _isMapReady = PublishSubject();
    _from = PublishSubject();
    _to = PublishSubject();
    _hours = PublishSubject();
    _amount = PublishSubject();
  }

  Sink<bool> get _setLoading => _loading.sink;
  Stream<bool> get getLoading => _loading.stream;

  Sink<bool> get _setIsMapReady => _isMapReady.sink;
  Stream<bool> get getIsMapReady => _isMapReady.stream;

  Sink<DateTime> get _setFrom => _from.sink;
  Stream<DateTime> get getFrom => _from.stream;

  Sink<DateTime> get _setTo => _to.sink;
  Stream<DateTime> get getTo => _to.stream;

  Sink<double> get _setAmount => _amount.sink;
  Stream<double> get getAmount => _amount.stream;

  Sink<int> get _setHours => _hours.sink;
  Stream<int> get getHours =>
      CombineLatestStream.combine2(_from, _to, (DateTime a, DateTime b) {
        if (a != null && b != null) {
          return ((b.difference(a).inDays) * 24).abs();
        }

        return null;
      });

  set setLoading(bool data) => _setLoading.add(data);
  set setIsMapReady(bool data) => _setIsMapReady.add(data);
  set setFrom(DateTime data) => _setFrom.add(data);
  set setTo(DateTime data) => _setTo.add(data);
  set setHours(int data) => _setHours.add(data);
  set setAmount(double data) => _setAmount.add(data);

  @override
  void dispose() {
    _loading.close();
    _isMapReady.close();
    _from.close();
    _to.close();
    _hours.close();
    _amount.close();
  }
}
