import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_distributor_retailer_app/core/utils/app_spacing_utils.dart';
import 'package:flutter_distributor_retailer_app/models/user_model.dart';
import 'package:flutter_distributor_retailer_app/viewmodels/distributor_from_viewmodel.dart';
import 'package:flutter_distributor_retailer_app/viewmodels/distributor_list_viewmodel.dart';
import 'package:flutter_distributor_retailer_app/widgets/app_button.dart';
import 'package:flutter_distributor_retailer_app/widgets/app_text_form_field.dart';
import 'package:flutter_distributor_retailer_app/widgets/common_tab.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DistributorFormScreen extends StatefulWidget {
  final UserModel? userModel;
  final bool isEditMode;
  const DistributorFormScreen({
    super.key,
    required this.userModel,
    this.isEditMode = false,
  });

  @override
  State<DistributorFormScreen> createState() => _DistributorFormScreenState();
}

class _DistributorFormScreenState extends State<DistributorFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late bool isEditMode;
  @override
  void initState() {
    super.initState();
    isEditMode = widget.userModel != null;

    if (isEditMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final vm = context.read<DistributorFormViewmodel>();
        final user = widget.userModel!;

        vm.setType(user.type);
        vm.businessNameController.text = user.businessName;
        vm.businessTypeController.text = user.businessType;
        vm.addressController.text = user.address;
        vm.gstController.text = user.gstNo;
        vm.pinCodeController.text = user.pincode;
        vm.personNameController.text = user.name;
        vm.mobileController.text = user.mobile;

        vm.setStateValue(user.state.trim());
        vm.setCity(user.city.trim());
        vm.setRegion(user.regionId.trim());
        vm.setArea(user.areaId.trim());
        vm.setBrand(user.brandIds.trim());
        vm.setBank(user.bankAccountId.trim());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<DistributorFormViewmodel>();
    return Scaffold(
      // App Bar
      appBar: AppBar(
        title: Text(
          isEditMode
              ? 'EDIT DISTRIBUTOR/RETAILER'
              : 'ADD NEW DISTRIBUTOR/RETAILER',
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Material(
            color: Colors.black.withOpacity(.06),
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                context.pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(Icons.arrow_back_ios),
              ),
            ),
          ),
        ),
      ),

      // body
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Type',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    AppSpacingUtils.h8,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CommonTab(
                            tabName: 'DISTRIBUTOR',
                            checkActive: (isDistributorSelected) =>
                                isDistributorSelected,
                            onTap: () {
                              context
                                  .read<DistributorListViewmodel>()
                                  .toggleTab(true);
                              context.read<DistributorFormViewmodel>().setType(
                                "distributor",
                              );
                            },
                          ),
                        ),
                        AppSpacingUtils.w16,
                        Expanded(
                          child: CommonTab(
                            tabName: 'RETAILER',
                            checkActive: (isDistributorSelected) =>
                                !isDistributorSelected,
                            onTap: () {
                              context
                                  .read<DistributorListViewmodel>()
                                  .toggleTab(false);
                              context.read<DistributorFormViewmodel>().setType(
                                "retailer",
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    AppSpacingUtils.h16,
                    if (!isEditMode)
                      Selector<DistributorFormViewmodel, File?>(
                        selector: (_, vm) => vm.pickedImage,
                        builder: (context, pickedImage, child) {
                          return Material(
                            color: Colors.black.withOpacity(.06),
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () async {
                                await context
                                    .read<DistributorFormViewmodel>()
                                    .pickImageFromCamera();
                              },
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.grey.withOpacity(.2),
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white,
                                ),
                                child: pickedImage == null
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.camera_alt,
                                              size: 64,
                                              color: Colors.grey.withOpacity(
                                                .4,
                                              ),
                                            ),
                                            AppSpacingUtils.h8,
                                            Text(
                                              'Take Photo',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey.withOpacity(
                                                  .4,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.file(
                                          pickedImage,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      ),
                              ),
                            ),
                          );
                        },
                      ),
                    AppSpacingUtils.h16,
                    AppTextFormField(
                      isDropDown: false,
                      label: 'Distributor Business Name',
                      controller: vm.businessNameController,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a business name";
                        }
                        return null;
                      },
                    ),
                    AppSpacingUtils.h16,
                    AppTextFormField(
                      isDropDown: false,
                      label: 'Business Type',
                      controller: vm.businessTypeController,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a business type";
                        }
                        return null;
                      },
                    ),
                    AppSpacingUtils.h16,
                    Selector<DistributorFormViewmodel, String?>(
                      selector: (_, vm) => vm.selectedBrand,
                      builder: (context, selectBrand, _) {
                        return AppTextFormField(
                          isDropDown: true,
                          dropdownItems: ["Brand 1", "Brand 2", "Brand 3"],
                          selectedValue: selectBrand,
                          label: 'Select Brand',
                          hintText: 'Select',
                          onDropdownChanged: (value) => context
                              .read<DistributorFormViewmodel>()
                              .setBrand(value),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select a brand";
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    AppSpacingUtils.h16,
                    AppTextFormField(
                      isDropDown: false,
                      label: 'Address',
                      controller: vm.addressController,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.streetAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter address";
                        }
                        return null;
                      },
                    ),
                    AppSpacingUtils.h16,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Selector<DistributorFormViewmodel, String?>(
                            selector: (_, vm) => vm.selectedState,
                            builder: (context, selectedState, child) {
                              return AppTextFormField(
                                isDropDown: true,
                                dropdownItems: ["HP", "Punjab", "Gujrat"],
                                selectedValue: selectedState,
                                label: 'State',
                                hintText: 'Select',
                                onDropdownChanged: (value) => context
                                    .read<DistributorFormViewmodel>()
                                    .setStateValue(value),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please select a state";
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                        ),
                        AppSpacingUtils.w8,
                        Expanded(
                          child: Selector<DistributorFormViewmodel, String?>(
                            selector: (_, vm) => vm.selectedCity,
                            builder: (context, selectedCity, child) {
                              return AppTextFormField(
                                isDropDown: true,
                                dropdownItems: ["City 1", "City 2", "City 3"],
                                selectedValue: selectedCity,
                                label: 'City',
                                hintText: 'Select',
                                onDropdownChanged: (value) => context
                                    .read<DistributorFormViewmodel>()
                                    .setCity(value),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please select a city";
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    AppSpacingUtils.h16,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Selector<DistributorFormViewmodel, String?>(
                            selector: (_, vm) => vm.selectedRegion,
                            builder: (context, selectedRegion, child) {
                              return AppTextFormField(
                                isDropDown: true,
                                dropdownItems: [
                                  "Region 1",
                                  "Region 2",
                                  "Region 3",
                                ],
                                selectedValue: selectedRegion,
                                label: 'Region',
                                hintText: 'Select',
                                onDropdownChanged: (value) => context
                                    .read<DistributorFormViewmodel>()
                                    .setRegion(value),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please select a region";
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                        ),
                        AppSpacingUtils.w8,
                        Expanded(
                          child: Selector<DistributorFormViewmodel, String?>(
                            selector: (_, vm) => vm.selectedArea,
                            builder: (context, selectedArea, child) {
                              return AppTextFormField(
                                isDropDown: true,
                                dropdownItems: ["Area 1", "Area 2", "Area 3"],
                                selectedValue: selectedArea,
                                label: 'Area',
                                hintText: 'Select',
                                onDropdownChanged: (value) => context
                                    .read<DistributorFormViewmodel>()
                                    .setArea(value),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please select an area";
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    AppSpacingUtils.h16,
                    Selector<DistributorFormViewmodel, String?>(
                      selector: (_, vm) => vm.selectedBank,
                      builder: (context, selectedBank, child) {
                        return AppTextFormField(
                          isDropDown: true,
                          dropdownItems: ["Bank A", "Brand B", "Brand C"],
                          selectedValue: selectedBank,
                          label: 'Bank Name',
                          hintText: 'Select',
                          onDropdownChanged: (value) => context
                              .read<DistributorFormViewmodel>()
                              .setBank(value),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select a bank";
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    AppSpacingUtils.h16,
                    AppTextFormField(
                      isDropDown: false,
                      label: 'Gst No.',
                      controller: vm.gstController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter GST No.";
                        }
                        return null;
                      },
                    ),
                    AppSpacingUtils.h16,
                    AppTextFormField(
                      isDropDown: false,
                      label: 'Pin code',
                      controller: vm.pinCodeController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter pin code";
                        }
                        return null;
                      },
                    ),
                    AppSpacingUtils.h16,
                    AppTextFormField(
                      isDropDown: false,
                      label: 'Person Name',
                      controller: vm.personNameController,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter person name";
                        }
                        return null;
                      },
                    ),
                    AppSpacingUtils.h16,
                    AppTextFormField(
                      isDropDown: false,
                      label: 'Mobile',
                      controller: vm.mobileController,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a mobile number";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Loader
          Selector<DistributorFormViewmodel, bool>(
            selector: (_, vm) => vm.isLoading,
            builder: (context, isLoading, _) {
              if (!isLoading) return SizedBox.shrink();
              return Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ],
      ),

      // Submit Button
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AppButton(
            label: isEditMode ? 'UPDATE' : 'SUBMIT',
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final formVm = context.read<DistributorFormViewmodel>();
                final listVm = context.read<DistributorListViewmodel>();

                if (isEditMode) {
                  // Create updated UserModel
                  final updatedUser = UserModel(
                    id: widget.userModel!.id,
                    businessName: vm.businessNameController.text,
                    businessType: vm.businessTypeController.text,
                    gstNo: vm.gstController.text,
                    address: vm.addressController.text,
                    pincode: vm.pinCodeController.text,
                    name: vm.personNameController.text,
                    mobile: vm.mobileController.text,
                    state: vm.selectedState ?? "",
                    city: vm.selectedCity ?? "",
                    regionId: vm.selectedRegion ?? "",
                    areaId: vm.selectedArea ?? "",
                    appPk: widget.userModel!.appPk,
                    image: vm.pickedImage?.path ?? widget.userModel!.image,
                    bankAccountId: vm.selectedBank ?? "",
                    type: vm.selectedType,
                    parentId: widget.userModel!.parentId,
                    brandIds: vm.selectedBrand ?? "",
                    userId: '',
                  );

                  await listVm.editUser(updatedUser);

                  // refresh list
                  await listVm.fetchUsers();

                  context.pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("User updated successfully!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  // Submit new user
                  final newUser = await formVm.submitForm();
                  if (newUser != null) {
                    await listVm.fetchUsers();
                    context.pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("User created successfully!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Operation failed!"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
