// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:camera_app/camera_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_voice/camera_screen.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

// import 'package:highlight_text/highlight_text.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:speech_to_text/speech_to_text.dart' as stt;

List<Language> languages = [
  const Language('Thai', 'th_TH'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

// class MyAppmain extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Voice',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: SpeechScreen(),
//     );
//   }
// }

class SpeechScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  SpeechScreen({required this.cameras});
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  
  String key = 'กุญแจ';
  String bottle = 'ขวดน้ำ';
  String air = 'รีโมทแอร์';
  String tv = 'รีโมททีวี';
  String glass = 'แก้วน้ำ';
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onLongPress: () {
            setState(() {
              _listen();
            });
          },

          //  onTap: (){

          //     Navigator.push(context, MaterialPageRoute(
          //           builder: (context) => CameraScreen(cameras: cameras),
          //           ),);
          //    },

          child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image/microphone.png')),
              ))),
    );
  }

  late stt.SpeechToText _speech;
  bool _isListening = false;

  // get cameras => null;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    audioPlayer.open(Audio('assets/audios/Touch screen.mp3'),
        autoStart: true, showNotification: true);
  }

    
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  Language selectedLang = languages.first;

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        _speech.listen(
          localeId: selectedLang.code,
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            print('${(_text)}');

            switch (_text) {
              case "กุญแจ":
              audioPlayer.open(Audio('assets/audios/Finding Key.mp3'),
                autoStart: true, showNotification: true);
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraScreen(cameras: widget.cameras,mm: "key",),
                    ),
                  );
                }
                break;

              case "ขวดน้ำ":
               audioPlayer.open(Audio('assets/audios/Finding Bottle.mp3'),
                autoStart: true, showNotification: true);
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraScreen(cameras: widget.cameras,mm: "bottle",),
                    ),
                  );
                }
                break;

              case "รีโมทแอร์":
                audioPlayer.open(Audio('assets/audios/Finding Remote Air.mp3'),
                  autoStart: true, showNotification: true);
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraScreen(cameras: widget.cameras,mm: "remote_air",),
                    ),
                  );
                }  
                break;

              case "รีโมททีวี":
                audioPlayer.open(Audio('assets/audios/Finding Remote Tv.mp3'),
                  autoStart: true, showNotification: true);
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraScreen(cameras: widget.cameras,mm: "remote_TV",),
                    ),
                  );
                }                
                break;

              case "แก้วน้ำ":
               audioPlayer.open(Audio('assets/audios/Finding Glass.mp3'),
                autoStart: true, showNotification: true);
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraScreen(cameras: widget.cameras,mm:"glass",),
                    ),
                  );
                }
                break;
            }
          }),
        );
      }
    } else {
      // setState(() => _isListening = false);
      _speech.stop();
    }
  }
}


