import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

var imageResourceEndpoint = 'uploadimgtrip-hovwuqnpzq-uc.a.run.app';

class ImageClient {
  static get tempUrls async {
    var endpoint = Uri.https(imageResourceEndpoint);
    var response = await http.get(
      endpoint,
    );

    var jsonMap = jsonDecode(response.body) as Map<String, dynamic>;

    String uploadUrl, downloadUrl;

    {
      'uploadLocation': uploadUrl as String,
      'downloadLocation': downloadUrl as String,
    } = jsonMap;

    return (uploadUrl, downloadUrl);
  }

  static Future<String> uploadImage(File imageFile) async {
    String uploadUrl, downloadUrl;
    (uploadUrl, downloadUrl) = await ImageClient.tempUrls;

    await http.put(
      Uri.parse(uploadUrl),
      headers: {'Content-Type': 'application/octet-stream'},
      body: await imageFile.readAsBytes(),
    );

    return downloadUrl;
  }

  static Future<List<String>> uploadImages(List<File> images) async {
    List<Future<String>> imagesFutures = List.generate(
      images.length,
      (idx) => uploadImage(images[idx]),
    );

    var imagesDownloadUrls = await Future.wait(imagesFutures);

    return imagesDownloadUrls;
  }
}

void main() async {
  //var imageFile = File('assets/images/la-jolla.jpeg');

  //var downloadUrl = await ImageClient.uploadImage(imageFile);

  //print('Uploaded! Check it out:\n$downloadUrl');

  var images = [
    File('assets/images/la-jolla.jpeg'),
    File('assets/images/coronado-island.jpeg'),
    File('assets/images/louvre.png'),
    File('assets/images/paris.png'),
  ];

  var downloadUrls = await ImageClient.uploadImages(images);

  print(downloadUrls);
}
