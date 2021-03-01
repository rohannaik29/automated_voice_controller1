import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';



Flexible btn(String dir, IconData ic) {
  return Flexible(
    child: Container(
      width: 120.0,
      child: RaisedButton(
          onPressed: () {},
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.deepPurple[100],
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(10),

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(dir),
              Icon(ic),
            ],
          )),
    ),
  );
}

class StreamingPage extends StatefulWidget {
  @override
  _StreamingPageState createState() => _StreamingPageState();
}

class _StreamingPageState extends State<StreamingPage> {
  String _streamUrl='http://192.168.1.101:8080/video';
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

  void _incrementCounter() {

    setState(() {

      // if (_streamUrl != null) {
      //   _streamUrl = null;
      // } else {
      //   _streamUrl = 'assets/testvideo.mp4';
        //http://samples.mplayerhq.hu/MPEG-4/embedded_subs/1Video_2Audio_2SUBs_timed_text_streams_.mp4';

        // 'http://192.168.1.4:8081'
      //_streamUrl='http://samples.mplayerhq.hu/MPEG-4/embedded_subs/1Video_2Audio_2SUBs_timed_text_streams_.mp4';

    // }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _streamUrl == null
                  ? Expanded(
                    child: Container(
                      color: Colors.deepPurple,
                        child: Center(
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Stream Closed',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    background: Paint()..color = Colors.red
                                ),
                              )
                            ]),
                          ),
                        ),
                      ),
                  )
                  : new VlcPlayer(
                      url: _streamUrl,
                      controller: _vlcViewController,
                      aspectRatio: 3,
                      placeholder: Container(),
                    ),

              FloatingActionButton(
                onPressed: playOrPauseVideo,
                tooltip: 'Increment',
                child:
                    Icon(state == 'PlayingState.PLAYING' ? Icons.play_arrow : Icons.pause),
              ),
              SizedBox(
                height: 20,
              ),


              btn('Forward', Icons.arrow_upward),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  btn('Left', Icons.arrow_back),
                  SizedBox(
                    width: 10.0,
                  ),
                  btn('Stop', Icons.stop_circle_outlined),
                  SizedBox(
                    width: 10.0,
                  ),
                  btn('Right', Icons.arrow_forward),
                ],
              ),
              btn('Backward', Icons.arrow_downward),
            ],
          ),
        ),
      ),
    );
  }
  void playOrPauseVideo() {
    String state = _vlcViewController.playingState.toString();


    if (state == "PlayingState.PLAYING") {
      _vlcViewController.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      _vlcViewController.play();
      setState(() {
        isPlaying = true;
      });
    }
  }
}

