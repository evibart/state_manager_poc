import '../../core/utils/status.dart';

class Data<T> {
  final Status state;
  final T? actualData;
  final String? error;

  Data({required this.state, this.actualData, this.error});
}
