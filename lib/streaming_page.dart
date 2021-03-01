import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'SendToRaspberryPi.dart';

class StreamingPage extends StatefulWidget {
  @override
  _StreamingPageState createState() => _StreamingPageState();
}

class _StreamingPageState extends State<StreamingPage> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

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

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      'http://192.168.43.1:8080/video1',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
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
                    FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          // If the VideoPlayerController has finished initialization, use
                          // the data it provides to limit the aspect ratio of the video.
                          return AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            // Use the VideoPlayer widget to display the video.
                            child: VideoPlayer(_controller),
                          );
                        } else {
                          // If the VideoPlayerController is still initializing, show a
                          // loading spinner.
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.2,
              ),
              // Column(
              //   children: [
              //     btn('Forward', size),
              //     SizedBox(
              //       height: 10.0,
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         btn('Left', size),
              //         SizedBox(
              //           width: 10.0,
              //         ),
              //         btn('Stop', size),
              //         SizedBox(
              //           width: 10.0,
              //         ),
              //         btn('Right', size),
              //       ],
              //     ),
              //     SizedBox(
              //       height: 10.0,
              //     ),
              //     btn('Backward', size),
              //   ],
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
