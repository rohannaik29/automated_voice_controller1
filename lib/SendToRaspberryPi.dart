import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class SendToRaspberryPi{
  void sendToRaspberryPi(String dir) {
    var client = http.Client();
    try {
      var url = 'http://169.254.74.142:3000/$dir';
      client.post(url, body: json.encode({'status': dir}), headers: {
        'Content-type': 'application/json'
      }).then((response) => print('status: $dir'));
    } on Exception catch (_) {
      print('never reached');
    }
  }
}