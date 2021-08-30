import 'dart:async';
import 'app_bottom_bar.dart';
import 'tab_navigator.dart';

class AppStreamer {
  static final AppStreamer _singleton = AppStreamer();
  static AppStreamer get instance => _singleton;

  /// General Stream builder for app
  StreamController _streamBuilder = new StreamController<int>.broadcast();

  StreamController get streamBuilder => _streamBuilder;

  set streamBuilder(StreamController streamBuilder) {
    _streamBuilder = new StreamController.broadcast();
    _streamBuilder = streamBuilder;
  }

  /// Tab bar Stream builder
  StreamController _tabSelectedStreamBuilder =
      new StreamController<TabObject>.broadcast();

  StreamController get tabSelectedStreamBuilder => _tabSelectedStreamBuilder;

  set tabSelectedStreamBuilder(StreamController streamBuilder) {
    _tabSelectedStreamBuilder = new StreamController.broadcast();
    _tabSelectedStreamBuilder = streamBuilder;
  }
}
