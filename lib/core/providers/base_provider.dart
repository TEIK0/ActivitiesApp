import 'dart:async';

import 'package:activities_app/core/providers/page_state.dart';
import 'package:flutter/material.dart';

import 'package:rxdart/streams.dart';
import 'package:rxdart/subjects.dart';

abstract class BaseProvider extends ChangeNotifier {
  late StreamSubscription<PageState> _subscription;
  late BehaviorSubject<PageState> _stateController;

  /// The [stream] of the controller.
  ValueStream<PageState> get stream => _stateController.stream;

  /// The [initialState].
  PageState get initialState => Empty();

  /// The current [state].
  PageState get state => _stateController.stream.value;

  set state(PageState nextState) {
    if (_stateController.isClosed) return;

    _stateController.add(nextState);
  }

  bool _isDisposed = false;

  /// Tells if the object [isDisposed].
  bool get isDisposed => _isDisposed;

  BaseProvider() {
    _handleStateChange();
  }

  /// Handles the state change.
  void _handleStateChange() {
    _stateController = BehaviorSubject();
    state = initialState;

    // Notifies the changes.
    _subscription = _stateController.stream.listen((event) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _isDisposed = true;

    _subscription.cancel();
    _stateController.close();

    super.dispose();
  }
}
