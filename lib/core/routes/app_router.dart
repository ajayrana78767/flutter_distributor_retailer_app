import 'package:flutter/cupertino.dart';
import 'package:flutter_distributor_retailer_app/core/routes/app_routes.dart';
import 'package:flutter_distributor_retailer_app/models/user_model.dart';
import 'package:flutter_distributor_retailer_app/views/distributor_form_screen.dart';
import 'package:flutter_distributor_retailer_app/views/distributor_list_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.list,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
          child: const DistributorListScreen(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.add,
      pageBuilder: (context, state) {
        final extra = state.extra as UserModel?;
        return CustomTransitionPage(
          key: state.pageKey,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      ),
                    ),
                child: child,
              ),
          child: DistributorFormScreen(userModel: extra),
        );
      },
    ),
  ],
);
