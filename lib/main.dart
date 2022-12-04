// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'Screens/Login.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      home:
          Login(), // <-- Buat Class Baru yg bernama MyScreen di dalam lib bikin folder baru screens isinya MyScreen.dart
    ));
