import 'package:camera/camera.dart';
// import 'package:camera_app/speech_to_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_voice/speech_to_text.dart';
import 'camera_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  const MyApp({Key? key, required this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera App',
      home: SpeechScreen(cameras: cameras),
    );
  }
}

class myTest extends StatefulWidget {
  @override
  _myTestState createState() => _myTestState();
}

class _myTestState extends State<myTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
    );
  }
}
