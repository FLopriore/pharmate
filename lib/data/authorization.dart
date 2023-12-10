import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Authorization {
  final String _url = "https://feddynventor.ddns.net/pharm8/";

  Future _getFCMToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
  } //TODO: Send FCM Token to server

  // Sign up
  // Returns true if signup was successful.
  // The token is stored in secure storage and is used to login later.
  Future<bool> signUp(data) async {
    // TODO: add Firebase token
    String fullUrl = '${_url}auth/signup';

    HttpClient client = HttpClient();
    // Bypass SSL certification
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    HttpClientRequest request = await client.postUrl(Uri.parse(fullUrl));
    request.headers.set('Content-Type', 'application/json');
    request.headers.set('accept', '*/*');
    request.add(utf8.encode(jsonEncode(data)));
    HttpClientResponse response = await request.close();

    if (response.statusCode == 200) {
      var responseJson = jsonDecode(await response.transform(utf8.decoder).join());

      // Store login data in secure storage
      const storage = FlutterSecureStorage();
      await storage.write(key: 'loginToken', value: responseJson['token']);
      return true;
    }
    return false;
  }
}
