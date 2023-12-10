import 'dart:convert';
import 'dart:io';

class Authorization {
  final String _url = "https://feddynventor.ddns.net/pharm8/";

  // Sign up.
  // Returns a token which identifies the user.
  // The token is stored in local data and is used to login later.
  Future<HttpClientResponse> signUp(data) async {
    String fullUrl = '${_url}auth/signup';

    HttpClient client = HttpClient();
    // Bypass SSL certification
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    HttpClientRequest request = await client.postUrl(Uri.parse(fullUrl));
    request.headers.set('Content-Type', 'application/json');
    request.headers.set('accept', '*/*');
    request.add(utf8.encode(jsonEncode(data)));
    HttpClientResponse result = await request.close();

    return result;
  }
}
