import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: _buildCompass(),
      ),
    );
  }
}

//permission sheet
/*Widget _buildPermissionSheet() {
  return Center(
      child: ElevatedButton(
          onPressed: () {
            Permission.locationWhenInUse.request().then((value) {
              _fetchPermissionStatus();
            });
          },
          child: const Text('Request Permission')));
}*/

//compass widget
Widget _buildCompass() {
  return StreamBuilder<CompassEvent>(
    stream: FlutterCompass.events,
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      double? direction = snapshot.data!.heading;
      if (direction == null) {
        return const Center(child: Text('Device does not have sensor'));
      }
      return Center(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Transform.rotate(
            angle: direction * (math.pi / 180) * -1,
            child: Image.asset('assets/images/compass.jpg'),
          ),
        ),
      );
    },
  );
}
