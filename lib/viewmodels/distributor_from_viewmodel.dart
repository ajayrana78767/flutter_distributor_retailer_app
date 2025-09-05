import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_distributor_retailer_app/core/network/api_client.dart';
import 'package:flutter_distributor_retailer_app/models/user_model.dart';
import 'package:flutter_distributor_retailer_app/repository/distributor_repository.dart';
import 'package:image_picker/image_picker.dart';

class DistributorFormViewmodel with ChangeNotifier {
  final DistributorRepository repository = DistributorRepository(ApiClient());

  // Text controllers
  final businessNameController = TextEditingController();
  final businessTypeController = TextEditingController();
  final addressController = TextEditingController();
  final gstController = TextEditingController();
  final pinCodeController = TextEditingController();
  final personNameController = TextEditingController();
  final mobileController = TextEditingController();

  // Dropdown selections
  String? selectedBrand;
  String? selectedState;
  String? selectedCity;
  String? selectedRegion;
  String? selectedArea;
  String? selectedBank;

  // User type (distributor or retailer)
  String _selectedType = "distributor";
  String get selectedType => _selectedType;
  void setType(String type) {
    _selectedType = type;
    notifyListeners();
  }

  // Manages the loading state for API calls
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Image
  File? pickedImage;
  final _picker = ImagePicker();

  Future<void> pickImageFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        pickedImage = File(pickedFile.path);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  // Update dropdowns
  void setBrand(String? value) {
    selectedBrand = value;
    notifyListeners();
  }

  void setStateValue(String? value) {
    selectedState = value;
    notifyListeners();
  }

  void setCity(String? value) {
    selectedCity = value;
    notifyListeners();
  }

  void setRegion(String? value) {
    selectedRegion = value;
    notifyListeners();
  }

  void setArea(String? value) {
    selectedArea = value;
    notifyListeners();
  }

  void setBank(String? value) {
    selectedBank = value;
    notifyListeners();
  }

  // Reset form
  void resetForm() {
    businessNameController.clear();
    businessTypeController.clear();
    addressController.clear();
    gstController.clear();
    pinCodeController.clear();
    personNameController.clear();
    mobileController.clear();

    selectedBrand = null;
    selectedState = null;
    selectedCity = null;
    selectedRegion = null;
    selectedArea = null;
    selectedBank = null;
    _selectedType = "distributor";
    pickedImage = null;

    notifyListeners();
  }

  @override
  void dispose() {
    businessNameController.dispose();
    businessTypeController.dispose();
    addressController.dispose();
    gstController.dispose();
    pinCodeController.dispose();
    personNameController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  Future<UserModel?> submitForm() async {
    setLoading(true);
    final user = UserModel(
      businessName: businessNameController.text,
      businessType: businessTypeController.text,
      gstNo: gstController.text,
      address: addressController.text,
      pincode: pinCodeController.text,
      name: personNameController.text,
      mobile: mobileController.text,
      state: selectedState ?? "",
      city: selectedCity ?? "",
      regionId: selectedRegion ?? "",
      areaId: selectedArea ?? "",
      appPk: "mock-app",
      image: pickedImage?.path ?? "",
      userId: DateTime.now().millisecondsSinceEpoch.toString(),
      bankAccountId: selectedBank ?? "",
      type: _selectedType,
      parentId: "",
      brandIds: selectedBrand ?? "",
      id: "",
    );

    try {
      final createdUser = await repository.addUser(user);
      resetForm();
      return createdUser;
    } catch (e) {
      debugPrint("Error submitting form: $e");
      return null;
    } finally {
      setLoading(false);
    }
  }
}
