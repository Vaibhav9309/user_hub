import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:user_hub/core/error/exception.dart';
import '../models/user_model.dart';

class UserRepository {
  final http.Client client;
  UserRepository(this.client);

  Future<List<UserModel>> fetchUsers(int page) async {
    final url = Uri.parse('https://reqres.in/api/users?per_page=10&page=$page');

    try {
      final response = await client
          .get(url, headers: {'x-api-key': 'reqres-free-v1'})
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        if (body['data'] == null || body['data'] is! List) {
          throw const DataParsingException('Invalid data format received');
        }

        final List data = body['data'];
        return data.map((e) => UserModel.fromJson(e)).toList();
      } else if (response.statusCode == 400) {
        throw const BadRequestException('Bad request');
      } else if (response.statusCode == 401) {
        throw const UnauthorizedException('Unauthorized access');
      } else if (response.statusCode == 404) {
        throw const NotFoundException('Resource not found');
      } else if (response.statusCode >= 500) {
        throw const ServerException('Server error');
      } else {
        throw HttpException('Unexpected status code: ${response.statusCode}');
      }
    } on SocketException {
      throw const NetworkException('No Internet connection');
    } on TimeoutException {
      throw const TimeoutException('Connection timed out');
    } on FormatException {
      throw const DataParsingException('Invalid JSON format');
    } catch (e) {
      throw UnknownException('Unexpected error: $e');
    }
  }
}
