import 'package:flutter/material.dart';
import 'package:flutter_distributor_retailer_app/core/utils/app_spacing_utils.dart';

class AppTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const AppTextFormField({
    super.key,
    required this.label,
    required this.controller,
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
        TextFormField(controller: controller),
      ],
    );
  }
}
