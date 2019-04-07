import 'dart:async';

import 'package:connectivity/connectivity.dart';

import 'bloc.dart';

class NoConnectionBloc implements BlocBase {
  NoConnectionBloc() {
    /*
     * Starts listening for connectivity
     */
    onConnectivityChanged();
  }

  // Connectivity stream controller
  final _connectivityController = StreamController<bool>();

  // Input connectivity sink where you feed the connectivity status
  Sink<bool> get _inConnectivity => _connectivityController.sink;
  // Output connectivity stream which outputs the connectivity status
  Stream<bool> get outConnectivity => _connectivityController.stream;

  onConnectivityChanged() {
    /*
     * Transform connectivity result to bool (connection / no connection)
     * Sink new connection status to stream
     */
    var connectivity = Connectivity();

    connectivity.onConnectivityChanged
        .map((e) => e != ConnectivityResult.none)
        .listen((e) => _inConnectivity.add(e));
  }

  @override
  dispose() {
    /*
     * Provide the super class method dispose to close the stream controllers 
     */
    _connectivityController?.close();
  }
}