import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

Future<void> checkInternetConnection() async {
  final ConnectivityResult connectivityStatus =
  await (Connectivity().checkConnectivity());

  if (connectivityStatus == ConnectivityResult.none)
    throw 'No internet connection';
}