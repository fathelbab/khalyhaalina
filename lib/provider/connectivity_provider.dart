// import 'dart:io';

// import 'package:connectivity/connectivity.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';

// class ConnectivityProvider with ChangeNotifier {
//   Connectivity _connectivity = Connectivity();
//   bool _isOnline=false;
//   bool get isOnline => _isOnline;
//   startMonitoring() async {
//     await initConnectivity();
//     _connectivity.onConnectivityChanged.listen((event) async {
//       if (event == ConnectivityResult.none) {
//         _isOnline = false;
//         notifyListeners();
//       } else {
//         await _updateConnectionState().then((bool isConnected) {
//           _isOnline = isConnected;
//           notifyListeners();
//         });
//       }
//     });
//   }

//   Future<void> initConnectivity() async {
//     try {
//       var status = await _connectivity.checkConnectivity();
//       if (status == ConnectivityResult.none) {
//         _isOnline = false;
//         notifyListeners();
//       } else {
//         _isOnline = true;
//         notifyListeners();
//       }
//     } on PlatformException catch (e) {
//       print(e.toString());
//     }
//   }

//   Future<bool> _updateConnectionState() async {
//     bool isConnected = false;
//     try {
//       final List<InternetAddress> result =
//           await InternetAddress.lookup('google.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         isConnected = true;
//       }
//     } on SocketException catch (e) {
//       isConnected = false;
//     }
//     return isConnected;
//   }
// }
