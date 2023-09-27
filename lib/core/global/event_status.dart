import 'package:flutter/material.dart';

@immutable
abstract class EventStatus<T> {}

class EventLoading<T> extends EventStatus<T> {
  final int? itemId;

  EventLoading({this.itemId});
}

class EventCompleted<T> extends EventStatus<T> {
  final T data;

  EventCompleted(this.data);
}

class EventInitial<T> extends EventStatus<T> {}

class EventError<T> extends EventStatus<T> {
  final String message;
  EventError(this.message);
}
