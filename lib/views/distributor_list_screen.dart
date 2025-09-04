import 'package:flutter/material.dart';
import 'package:flutter_distributor_retailer_app/core/routes/app_routes.dart';
import 'package:flutter_distributor_retailer_app/core/utils/app_spacing_utils.dart';
import 'package:flutter_distributor_retailer_app/viewmodels/distributor_list_viewmodel.dart';
import 'package:flutter_distributor_retailer_app/widgets/app_search_bar.dart';
import 'package:flutter_distributor_retailer_app/widgets/common_tab.dart';
import 'package:flutter_distributor_retailer_app/widgets/distributor_retailer_card.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DistributorListScreen extends StatefulWidget {
  const DistributorListScreen({super.key});

  @override
  State<DistributorListScreen> createState() => _DistributorListScreenState();
}

class _DistributorListScreenState extends State<DistributorListScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        title: Text('DISTRIBUTOR/RETAILER LIST'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Material(
              color: Colors.black.withOpacity(.06),
              borderRadius: BorderRadius.circular(4),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Text(
                    'Async',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, right: 8),
            child: Material(
              color: Colors.black.withOpacity(.06),
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(Icons.filter_alt),
                ),
              ),
            ),
          ),
        ],
      ),

      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '(Beta Test)',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              AppSpacingUtils.h16,
              AppSearchBar(controller: _searchController),
              AppSpacingUtils.h16,
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
              AppSpacingUtils.h24,
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => AppSpacingUtils.h16,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return DistributorRetailerCard(
                    title: 'TEST',
                    location: 'Una, Himachal',
                    status: '',
                  );
                },
              ),
            ],
          ),
        ),
      ),

      // Floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRoutes.add);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
