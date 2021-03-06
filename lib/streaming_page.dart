import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'SendToRaspberryPi.dart';

class StreamingPage extends StatefulWidget {
  @override
  _StreamingPageState createState() => _StreamingPageState();
}

class _StreamingPageState extends State<StreamingPage> {

  Container btn(String dir, Size size) {
    return Container(
      width: size.width * 0.29,
      height: size.height * 0.06,
      child: RaisedButton(
        onPressed: () => SendToRaspberryPi().sendToRaspberryPi(dir),
        child: Text(dir),
      ),
    );
  }

  String _streamUrl='http://192.168.0.104:8081';
  String state;
  bool isPlaying;
  VlcPlayerController _vlcViewController;
  @override
  void initState() {
    // TODO: implement initState

    _vlcViewController = new VlcPlayerController(onInit: () {
      _vlcViewController.play();
    });
    _vlcViewController.addListener(() {
      var dur=_vlcViewController.duration;
      state = _vlcViewController.playingState.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 250.0,
                      child: new VlcPlayer(
                        url: _streamUrl,
                        controller: _vlcViewController,
                        aspectRatio: 3,
                        placeholder: Container(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.2,
              ),
              Column(
                children: [
                  btn('Forward', size),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      btn('Left', size),
                      SizedBox(
                        width: 10.0,
                      ),
                      btn('Stop', size),
                      SizedBox(
                        width: 10.0,
                      ),
                      btn('Right', size),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  btn('Backward', size),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

