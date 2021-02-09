import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

Container btn(String dir,IconData ic ){
  return Container(
    width: 120.0,
    child: RaisedButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(dir),
            Icon(ic),
          ],
        )),
  );
}

class StreamingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
}
