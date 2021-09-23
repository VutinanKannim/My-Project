import 'dart:io';

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:async/async.dart';


String result = "";
class GalleryScreen extends StatefulWidget {
  final List<File> images;
  const GalleryScreen({Key? key, required this.images}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
 String ddd = "";
 String image = "";

  String get filePath => ""; 
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        children: this.widget.images
            .map((image) => Image.file(image, fit: BoxFit.cover))
            .toList(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     uploadImage();
      //   },
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // )
    );
  }

  // Future<void> TestApi() async {
  //   print("send api");
  //   var client = http.Client();
  //   Map<String, String> Header = {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   };

  //   var url = Uri.parse("http://192.168.137.1:3000/");
  //   var uriResponse = await client.get(
  //     url,
  //     // body: jsonEncode({"data": "hello"}),
  //     headers: Header,
  //   );

  //   var res = uriResponse.body;
    
  //   // print(res);
  // }

  

// Future<void> sendImageToAPI() async {
//     print("send api image");
//     var client = http.Client();
//     Map<String, String> Header = {
//       'Content-Type': 'application/json; charset=UTF-8',
//     };

//     var url = Uri.parse("http://192.168.137.1:3000/image");
//     var uriResponse = await client.post(
//       url,
//       body: jsonEncode({"image": this.widget.images,"name" : "${ddd}"}),
//       headers: Header,
//     );

//     var res = uriResponse.body;
//     print(res);
//     setState(() {
//       result = res;
//     });

//   }

//    Future<void> uploadImage() async {
//     ImagePicker picker = ImagePicker();
//     var pickedFile = await  picker.getImage(source: ImageSource.gallery); //picker.getImage(source: ImageSource.camera);//
//     // var dd = await pickedFile.toString();
//     Uint8List bytes = File(pickedFile.path).readAsBytesSync();
//     String base64 = base64Encode(bytes);
//     // Uint8List _binary = base64Decode(base64);
//     setState(() {
//       image = base64;
//     });
//    }


// }
// upload(File imageFile) async {    
//       // open a bytestream
//       var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
//       // get file length
//       var length = await imageFile.length();

//       // string to uri
//       var uri = Uri.parse("http://192.168.137.1:3000/image");

//       // create multipart request
//       var request = new http.MultipartRequest("POST", uri);

//       // multipart that takes file
//       var multipartFile = new http.MultipartFile('file', stream, length,
//           filename: basename(imageFile.path));

//       // add file to multipart
//       request.files.add(multipartFile);

//       // send
//       var response = await request.send();
//       print(response.statusCode);

//       // listen for response
//       response.stream.transform(utf8.decoder).listen((value) {
//         print(value);
//       });
//     }

//   void uploadImage() {
//     upload(File(filePath));
//   }
}