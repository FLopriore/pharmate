import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginSecureStorage{
  static const storage = FlutterSecureStorage();

  // Stores login data in secure storage.
  static void storeLoginSecureStorage(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  // Retrieves login data from secure storage.
  static Future<String?> getLoginSecureStorage(String key) async {
    return await storage.read(key: key);
  }

  // Deletes login data from secure storage.
  static void deleteLoginSecureStorage() async {
    await storage.deleteAll();
  }
}