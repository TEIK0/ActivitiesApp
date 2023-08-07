import 'package:equatable/equatable.dart';

abstract class PageState extends Equatable {
  const PageState();

  @override
  List<Object> get props => [];
}

class Empty extends PageState {}

class Loading extends PageState {}

class Error extends PageState {
  /// The [message] that describes the error.
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}

class Loaded<T> extends PageState {
  /// The [value] loaded.
  final T? value;

  const Loaded({this.value});

  @override
  List<Object> get props => [];
}
