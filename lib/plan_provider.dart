import 'package:flutter/material.dart';
import 'package:master_plan/models/data_layer.dart';

class PlanProvider extends InheritedWidget {
  final _plans = <Plan>[];

  PlanProvider({Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static List<Plan> of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<PlanProvider>();
    return provider!._plans;
  }
}
