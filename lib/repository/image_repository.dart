import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_assignment/model/model_data.dart';
import 'package:http/http.dart' as http;

class ImageRepository {
  Future<List<InfoModel>> getImage(BuildContext context) async {
    List<InfoModel> imageList = [];
    try {
      var request = http.Request('GET', Uri.parse('http://e-doctors.co.in/Apicontrollers/category'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var code=await response.stream.bytesToString();
         Map<String,dynamic> data=jsonDecode(code);
        if(data["status"]=="success"){
          print("Ashu ${data["data"]}");
          List<dynamic> dataList=data["data"];
          dataList.forEach(( element) {
            InfoModel info=InfoModel.fromJson(element);
            imageList.add(info);
          });
        }
      }
      else {
        print(response.reasonPhrase);
      }

    } catch (e) {
      print("Exception in image $e");
    }
    return imageList;
  }
}
