import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Necessary if using fonts by google
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  // Necessary for firebase and firestore functionality
  //await Firebase.initializeApp();
}