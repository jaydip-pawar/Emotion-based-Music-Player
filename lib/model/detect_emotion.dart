import 'dart:io';

import 'package:http/http.dart' as http;

class DetectEmotion {
  Future<String> getEmotion(File image) async {
    //
    try {
      var request = http.MultipartRequest('POST', Uri.parse("https://192.168.0.105:3443/upload"));
      // var request = http.MultipartRequest('POST', Uri.parse(link.trim()));
      // print("Url: $url/upload");
      request.files.add(await http.MultipartFile.fromPath('file', image.path));
      var res = await request.send();
      final respStr = await res.stream.bytesToString();
      var tr1 = respStr.split("{");
      var tr2 = tr1[2].split(":");
      var tr3 = tr2[1].split("\"");
      final result = tr3[1].trim();
      return result;
    } catch (e) {
      print(e);
    }
  }
}