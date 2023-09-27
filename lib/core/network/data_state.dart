import 'package:location_test/core/network/error_handler.dart';

abstract class DataState<T> {
  final T? data;
  final ErrorHandler? error;

  const DataState(
    this.data,
    this.error,
  );
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T? data) : super(data, null);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(
    ErrorHandler error,
  ) : super(null, error);
}
