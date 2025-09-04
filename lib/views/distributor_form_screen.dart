import 'package:flutter/material.dart';
import 'package:flutter_distributor_retailer_app/core/utils/app_spacing_utils.dart';
import 'package:flutter_distributor_retailer_app/viewmodels/distributor_list_viewmodel.dart';
import 'package:flutter_distributor_retailer_app/widgets/app_text_form_field.dart';
import 'package:flutter_distributor_retailer_app/widgets/common_tab.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DistributorFormScreen extends StatefulWidget {
  const DistributorFormScreen({super.key});

  @override
  State<DistributorFormScreen> createState() => _DistributorFormScreenState();
}

class _DistributorFormScreenState extends State<DistributorFormScreen> {
  TextEditingController _distributorBusinessNameController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        title: Text('ADD NEW DISTRIBUTOR/RETAILER'),
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
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Type',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
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
                    onTap: () => context
                        .read<DistributorListViewmodel>()
                        .selectDistributor(),
                  ),
                ),
                AppSpacingUtils.w16,
                Expanded(
                  child: CommonTab(
                    tabName: 'RETAILER',
                    checkActive: (isDistributorSelected) =>
                        !isDistributorSelected,
                    onTap: () => context
                        .read<DistributorListViewmodel>()
                        .selectRetailer(),
                  ),
                ),
              ],
            ),
            AppSpacingUtils.h16,
            Material(
              color: Colors.black.withOpacity(.06),
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {},
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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 64,
                          color: Colors.grey.withOpacity(.4),
                        ),
                        AppSpacingUtils.h8,
                        Text(
                          'Take Photo',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.withOpacity(.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            AppSpacingUtils.h16,
            AppTextFormField(
              label: 'Distributor Business Name',
              controller: _distributorBusinessNameController,
            ),
            AppSpacingUtils.h16,
            AppTextFormField(
              label: 'Business Type',
              controller: _distributorBusinessNameController,
            ),
          ],
        ),
      ),
    );
  }
}
