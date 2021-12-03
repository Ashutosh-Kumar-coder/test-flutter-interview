import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ImageRepository {
  Future<List<dynamic>> getImage(BuildContext context, int count) async {
    List<dynamic> imageList = [];
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              'http://shibe.online/api/shibes?count=$count&urls=true&httpsUrls=true'));
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        String data = await response.stream.bytesToString();
        List list = jsonDecode(data);
        imageList = list;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print("Exception in image $e");
    }
    return imageList;
  }
}
