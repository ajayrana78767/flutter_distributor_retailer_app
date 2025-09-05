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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = Provider.of<DistributorListViewmodel>(context, listen: false);
      vm.fetchUsers();
    });
  }

  void _onTabChanged(bool isDistributorSelected) {
    final vm = Provider.of<DistributorListViewmodel>(context, listen: false);
    vm.toggleTab(isDistributorSelected); // <--- new method
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(
        title: const Text('DISTRIBUTOR/RETAILER LIST'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Material(
              color: Colors.black.withOpacity(.06),
              borderRadius: BorderRadius.circular(4),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  final vm = Provider.of<DistributorListViewmodel>(
                    context,
                    listen: false,
                  );
                  vm.fetchUsers();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('List refreshed!'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },

                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                onTap: () async {
                  final vm = Provider.of<DistributorListViewmodel>(
                    context,
                    listen: false,
                  );

                  final selectedType = await showDialog<String>(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      title: const Text('Filter Users'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioListTile<String>(
                            title: const Text('Distributor'),
                            value: 'distributor',
                            groupValue: vm.isDistributorSelected
                                ? 'distributor'
                                : 'retailer',
                            onChanged: (value) => Navigator.pop(context, value),
                          ),
                          RadioListTile<String>(
                            title: const Text('Retailer'),
                            value: 'retailer',
                            groupValue: vm.isDistributorSelected
                                ? 'distributor'
                                : 'retailer',
                            onChanged: (value) => Navigator.pop(context, value),
                          ),
                        ],
                      ),
                    ),
                  );

                  if (selectedType != null) {
                    vm.toggleTab(selectedType == 'distributor');
                  }
                },

                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.filter_alt),
                ),
              ),
            ),
          ),
        ],
      ),

      // body
      body: Consumer<DistributorListViewmodel>(
        builder: (context, vm, _) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '(Beta Test)',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      AppSpacingUtils.h16,
                      AppSearchBar(
                        controller: _searchController,
                        onChanged: (value) {
                          vm.updateSearch(_searchController.text);
                        },
                      ),
                      AppSpacingUtils.h16,
                      Row(
                        children: [
                          Expanded(
                            child: CommonTab(
                              tabName: 'DISTRIBUTOR',
                              checkActive: (_) => vm.isDistributorSelected,
                              onTap: () => _onTabChanged(true),
                            ),
                          ),
                          AppSpacingUtils.w16,
                          Expanded(
                            child: CommonTab(
                              tabName: 'RETAILER',
                              checkActive: (_) => !vm.isDistributorSelected,
                              onTap: () => _onTabChanged(false),
                            ),
                          ),
                        ],
                      ),
                      AppSpacingUtils.h24,
                      if (!vm.isLoading && vm.filteredUsers.isEmpty)
                        Center(
                          child: Text(
                            'No ${vm.isDistributorSelected ? "distributor" : "retailer"} found',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (_, __) => AppSpacingUtils.h16,
                          itemCount: vm.filteredUsers.length,
                          itemBuilder: (_, index) {
                            final user = vm.filteredUsers[index];
                            return DistributorRetailerCard(
                              title: user.businessName,
                              location: '${user.city}, ${user.state}',
                              status: 'Active',
                              onEdit: () async {
                                // pass the user detauil to add user screen shows fill and upadte
                                context.push(AppRoutes.add, extra: user);
                              },
                              onDelete: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: const Text("Confirm Delete"),
                                    content: Text(
                                      "Are you sure you want to delete ${user.businessName}?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: const Text("Delete"),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirm == true) {
                                  await vm.deleteUserById(user.id);
                                  final typeCapitalized =
                                      user.type[0].toUpperCase() +
                                      user.type.substring(1);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "$typeCapitalized deleted successfully!",
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
              if (vm.isLoading)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(
          AppRoutes.add,
          extra: null,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
