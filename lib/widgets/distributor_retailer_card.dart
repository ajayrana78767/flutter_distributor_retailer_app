import 'package:flutter/material.dart';
import 'package:flutter_distributor_retailer_app/core/utils/app_spacing_utils.dart';

class DistributorRetailerCard extends StatelessWidget {
  final String title;
  final String location;
  final String status;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const DistributorRetailerCard({
    super.key,
    required this.title,
    required this.location,
    required this.status,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.25),
            offset: const Offset(0, 0),
            blurRadius: 20,
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left column: details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSpacingUtils.h8,
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 20),
                    AppSpacingUtils.w4,
                    Expanded(
                      child: Text(
                        location,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                AppSpacingUtils.h8,
                Row(
                  children: [
                    const Text(
                      'Status:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    AppSpacingUtils.w8,
                    Text(
                      status,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: status.toLowerCase() == 'active'
                            ? const Color.fromRGBO(92, 195, 160, 1)
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Right: vertical three dots menu
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'edit') {
                if (onEdit != null) onEdit!();
              } else if (value == 'delete') {
                if (onDelete != null) onDelete!();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'edit', child: Text('Edit')),
              const PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        ],
      ),
    );
  }
}
