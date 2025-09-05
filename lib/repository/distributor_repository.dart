import 'package:flutter_distributor_retailer_app/core/network/api_client.dart';
import 'package:flutter_distributor_retailer_app/core/network/api_endpoints.dart';
import 'package:flutter_distributor_retailer_app/models/user_model.dart';

class DistributorRepository {
  final ApiClient _client;

  DistributorRepository(this._client);

  /// Add new user distributor/retailer
  Future<UserModel?> addUser(UserModel user) async {
    try {
      final response = await _client.dio.post(
        ApiEndpoints.users,
        data: user.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  /// Fetch all user distributors/retailers
  Future<List<UserModel>> getUsers({String? type}) async {
    try {
      final response = await _client.dio.get(
        ApiEndpoints.users,
        queryParameters: type != null ? {'type': type} : null,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((e) => UserModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  // Update user
  Future<UserModel?> updateUser(UserModel user) async {
    try {
      final response = await _client.dio.put(
        "${ApiEndpoints.users}/${user.id}",
        data: user.toJson(),
      );
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // Delete user
  Future<bool> deleteUser(String userId) async {
    try {
      final response = await _client.dio.delete(
        "${ApiEndpoints.users}/$userId",
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      rethrow;
    }
  }
}
