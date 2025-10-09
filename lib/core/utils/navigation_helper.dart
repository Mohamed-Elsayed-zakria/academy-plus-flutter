import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationHelper {
  // Navigate to a new page (push)
  static void to({
    required String path,
    required BuildContext context,
    Object? data,
  }) {
    GoRouter.of(context).push(path, extra: data);
  }

  // Navigate to a new page and replace current (go)
  static void off({
    required String path,
    required BuildContext context,
    Object? data,
  }) {
    GoRouter.of(context).go(path, extra: data);
  }

  // Navigate to a new page and clear all previous routes (go with reset)
  static void offAll({
    required String path,
    required BuildContext context,
    Object? data,
  }) {
    GoRouter.of(context).go(
      path,
      extra: {'reset': true, 'data': data},
    );
  }

  // Go back to previous page
  static void back(BuildContext context) {
    GoRouter.of(context).pop();
  }

  // Go back with result
  static void backWithResult(BuildContext context, Object? result) {
    GoRouter.of(context).pop(result);
  }
}
