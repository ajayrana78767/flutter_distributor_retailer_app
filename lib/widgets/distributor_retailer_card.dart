import 'package:flutter/material.dart';
import 'package:flutter_distributor_retailer_app/core/utils/app_spacing_utils.dart';

class DistributorRetailerCard extends StatelessWidget {
  final String title;
  final String location;
  final String status;

  const DistributorRetailerCard({
    super.key,
    required this.title,
    required this.location,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.25),
            offset: Offset(0, 0),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          AppSpacingUtils.h8,

          // Location
          Row(
            children: [
              Icon(Icons.location_on, size: 24),
              AppSpacingUtils.w4,
              Text(
                overflow: TextOverflow.ellipsis,
                location,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),

          AppSpacingUtils.h8,

          // Status
          Row(
            children: [
              Text('Status:', style: TextStyle(fontWeight: FontWeight.w500)),
              AppSpacingUtils.w8,
              Text(
                'Active',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(92, 195, 160, 1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
