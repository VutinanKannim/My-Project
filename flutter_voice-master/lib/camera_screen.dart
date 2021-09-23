import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'gallery_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:async/async.dart';

class CameraScreen extends StatefulWidget {
  List<CameraDescription>? cameras;

  CameraScreen({
    this.cameras,
  });

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  void initState() {
    initializeCamera(selectedCamera); //Initially selectedCamera = 0
    super.initState();

    Timer.periodic(Duration(seconds: 1), (timer) async {
      await _initializeControllerFuture;
      var xFile = await _controller.takePicture();
      setState(() {
        capturedImages.add(File(xFile.path));
        upload(File(xFile.path));
      });
    });
  }

  upload(File imageFile) async {
    // open a bytestream
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("http://192.168.137.1:3000/image");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  late CameraController _controller; //To control the camera
  late Future<void>
      _initializeControllerFuture; //Future to wait until camera initializes
  int selectedCamera = 0;
  List<File> capturedImages = [];

  initializeCamera(int cameraIndex) async {
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.cameras![cameraIndex],
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return CameraPreview(_controller);
              } else {
                // Otherwise, display a loading indicator.
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // IconButton(
                //   onPressed: () {
                //     if (widget.cameras.length > 1) {
                //       setState(() {
                //         selectedCamera = selectedCamera == 0 ? 1 : 0;
                //         initializeCamera(selectedCamera);
                //       });
                //     } else {
                //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //         content: Text('No secondary camera found'),
                //         duration: const Duration(seconds: 2),
                //       ));
                //     }
                //   },
                //   icon: Icon(Icons.switch_camera_rounded, color: Colors.white),
                // ),

                //  GestureDetector(
                //     onTap: () async {
                //       // Timer.periodic(Duration(seconds: 1), (timer) async{await _initializeControllerFuture;
                //       // var xFile = await _controller.takePicture();
                //       // setState(() {
                //       //   capturedImages.add(File(xFile.path));
                //       // });});
                //     },
                //     child: Container(
                //       height: 60,
                //       width: 60,
                //       decoration: BoxDecoration(
                //         shape: BoxShape.circle,
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                // GestureDetector(
                //   onTap: () {
                //     if (capturedImages.isEmpty) return;
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => GalleryScreen(
                //                 images: capturedImages.reversed.toList())));
                //   },
                //   child: Container(
                //     height: 60,
                //     width: 60,
                //     decoration: BoxDecoration(
                //       border: Border.all(color: Colors.white),
                //       image: capturedImages.isNotEmpty
                //           ? DecorationImage(
                //               image: FileImage(capturedImages.last),
                //               fit: BoxFit.cover)
                //           : null,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
