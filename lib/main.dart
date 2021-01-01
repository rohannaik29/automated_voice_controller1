import 'package:automatedvoicecontroller/streaming_page.dart';
import 'package:flutter/material.dart';
import 'speech_to_text_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Voice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.record_voice_over)),
                  Tab(icon: Icon(Icons.video_label)),

                ],
              ),
              title: Text('Voice Controller'),
              centerTitle: true,
            ),
            body: TabBarView(
              children: [
                SpeechScreen(),
                StreamingPage(),

              ],
            ),
          )
      ),
    );
  }
}

