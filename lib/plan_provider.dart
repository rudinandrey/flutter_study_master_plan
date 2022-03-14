import 'package:flutter/material.dart';
import 'package:master_plan/plan_controller.dart';

class PlanProvider extends InheritedWidget {
  final _controller = PlanController();

  PlanProvider({Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static PlanController of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<PlanProvider>();
    return provider!._controller;
  }
}
