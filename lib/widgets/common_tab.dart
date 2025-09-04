import 'package:flutter/material.dart';
import 'package:flutter_distributor_retailer_app/viewmodels/distributor_list_viewmodel.dart';
import 'package:provider/provider.dart';

class CommonTab extends StatelessWidget {
  final String tabName;
  final bool Function(bool isDistributorSelected) checkActive;
  final VoidCallback onTap;

  const CommonTab({
    super.key,
    required this.tabName,
    required this.checkActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<DistributorListViewmodel, bool>(
      selector: (_, vm) => vm.isDistributorSelected,
      builder: (context, isDistributorSelected, _) {
        final isActive = checkActive(isDistributorSelected);
        return GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            padding: const EdgeInsets.all(24),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: isActive ? Colors.black : Colors.grey.withOpacity(.25),
              borderRadius: BorderRadius.circular(8),
            ),
            duration: const Duration(milliseconds: 200),
            child: Center(
              child: Text(
                tabName,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
