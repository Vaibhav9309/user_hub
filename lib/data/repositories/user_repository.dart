import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_hub/core/error/exception.dart';
import '../models/user_model.dart';

class UserRepository {
  final http.Client client;
  UserRepository(this.client);

  static const String cacheKey = 'cached_users';

  Future<List<UserModel>> fetchUsers(int page) async {
    final url = Uri.parse('https://reqres.in/api/users?per_page=10&page=$page');
    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await client
          .get(url)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        if (body['data'] == null || body['data'] is! List) {
          throw const DataParsingException('Invalid data format received');
        }

        final List data = body['data'];
        final users = data.map((e) => UserModel.fromJson(e)).toList();

        // ✅ Save response to cache
        final existingCache = prefs.getStringList(cacheKey) ?? [];
        final newData = users.map((u) => jsonEncode(u.toJson())).toList();
        prefs.setStringList(cacheKey, [...existingCache, ...newData]);

        return users;
      } else {
        throw HttpException('Unexpected status code: ${response.statusCode}');
      }
    } on SocketException {
      // 🧠 Load cached data if offline
      final cachedData = prefs.getStringList(cacheKey);
      if (cachedData != null && cachedData.isNotEmpty) {
        final cachedUsers = cachedData
            .map((e) => UserModel.fromJson(jsonDecode(e)))
            .toList();
        return cachedUsers;
      }
      throw const NetworkException('No Internet connection');
    } on TimeoutException {
      throw const TimeoutException('Connection timed out');
    } on FormatException {
      throw const DataParsingException('Invalid JSON format');
    } catch (e) {
      throw UnknownException('Unexpected error: $e');
    }
  }

  // Optional: clear cache when refreshing
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(cacheKey);
  }
}
