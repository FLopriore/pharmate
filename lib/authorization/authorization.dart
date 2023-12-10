import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pharmate/authorization/login_secure_storage.dart';

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
      LoginSecureStorage.storeLoginSecureStorage('loginToken', responseJson['token']);
      // TODO: store FCM token
      return true;
    }
    return false;
  }

  // Login
  Future<bool> login(String cf, String password) async {
    String fullUrl = '${_url}auth/login';

    var data = {
      "cf": cf,
      "password": password,
    };

    HttpClient client = HttpClient();
    // Bypass SSL certification
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    HttpClientRequest request = await client.postUrl(Uri.parse(fullUrl));
    request.headers.set('Content-Type', 'application/json');
    request.headers.set('accept', '*/*');
    request.add(utf8.encode(jsonEncode(data)));
    HttpClientResponse result = await request.close();
    if (result.statusCode == 200) {
      var responseJson = jsonDecode(await result.transform(utf8.decoder).join());
      LoginSecureStorage.storeLoginSecureStorage('loginToken', responseJson['token']);
      // TODO: store FCM token
      return true;
    }
    return false;
  }
}
