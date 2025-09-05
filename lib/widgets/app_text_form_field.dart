import 'package:flutter/material.dart';
import 'package:flutter_distributor_retailer_app/core/utils/app_spacing_utils.dart';

class AppTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool isDropDown;
  final List<String>? dropdownItems;
  final String? selectedValue;
  final Function(String?)? onDropdownChanged;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  const AppTextFormField({
    super.key,
    required this.label,
    this.controller,
    required this.isDropDown,
    this.dropdownItems,
    this.selectedValue,
    this.onDropdownChanged,
    this.hintText,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        AppSpacingUtils.h16,
        isDropDown
            ? DropdownButtonFormField<String>(
                value: dropdownItems?.contains(selectedValue) == true
                    ? selectedValue
                    : null,
                items:
                    dropdownItems
                        ?.map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                        .toList() ??
                    [],
                onChanged: onDropdownChanged,
                validator: validator,
                dropdownColor: Colors.white,
                decoration: InputDecoration(hintText: hintText),
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: 35,
                  color: Colors.black,
                ),
              )
            : TextFormField(
                controller: controller,
                validator: validator,
                keyboardType: keyboardType,
                textCapitalization: textCapitalization,
              ),
      ],
    );
  }
}
