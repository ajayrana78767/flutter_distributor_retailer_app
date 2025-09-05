import 'package:flutter/material.dart';
import 'package:flutter_distributor_retailer_app/core/network/api_client.dart';
import 'package:flutter_distributor_retailer_app/models/user_model.dart';
import 'package:flutter_distributor_retailer_app/repository/distributor_repository.dart';

class DistributorListViewmodel with ChangeNotifier {
  final DistributorRepository repository = DistributorRepository(ApiClient());

  bool _isDistributorSelected = true;
  List<UserModel> allUsers = [];
  List<UserModel> filteredUsers = [];
  bool _isLoading = false;

  bool get isDistributorSelected => _isDistributorSelected;
  bool get isLoading => _isLoading;

  void toggleTab(bool isDistributor) {
    _isDistributorSelected = isDistributor;
    applyFilter(_searchQuery);
    notifyListeners();
  }

  // Loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // For search
  String _searchQuery = "";

  void updateSearch(String query) {
    _searchQuery = query;
    applyFilter(query);
    notifyListeners();
  }

  // Fetch all users once
  Future<void> fetchUsers() async {
    setLoading(true);
    try {
      allUsers = await repository.getUsers();
      applyFilter(_searchQuery);
    } catch (e) {
      filteredUsers = [];
      debugPrint("Error fetching users: $e");
    } finally {
      setLoading(false);
    }
  }

  // Search + type filter
  void applyFilter(String query) {
    final typeFilter = _isDistributorSelected ? "distributor" : "retailer";

    filteredUsers = allUsers
        .where(
          (user) =>
              user.type.toLowerCase() == typeFilter &&
              user.businessName.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  // Edit user
  Future<void> editUser(UserModel user) async {
    setLoading(true);
    try {
      final updatedUser = await repository.updateUser(user);
      if (updatedUser != null) {
        int index = allUsers.indexWhere((u) => u.id == user.id);
        if (index != -1) {
          allUsers[index] = updatedUser;
          applyFilter(_searchQuery);
        }
      }
    } catch (e) {
      debugPrint("Error editing user: $e");
    } finally {
      setLoading(false);
    }
  }

  // Delete user
  Future<void> deleteUserById(String userId) async {
    setLoading(true);
    try {
      final success = await repository.deleteUser(userId);
      if (success) {
        allUsers.removeWhere((user) => user.id == userId);
        applyFilter(_searchQuery);
      }
    } catch (e) {
      debugPrint("Error deleting user: $e");
    } finally {
      setLoading(false);
    }
  }
}
