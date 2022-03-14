import 'package:flutter/material.dart';
import 'package:master_plan/models/data_layer.dart';
import 'package:master_plan/plan_provider.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({Key? key, required this.plan}) : super(key: key);

  final Plan plan;

  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late ScrollController controller;

  Plan get plan => widget.plan;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()
      ..addListener(() {
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Master Plan'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildList(),
          ),
          SafeArea(child: Text(plan.completenessMessage))
        ],
      ),
      floatingActionButton: _buildAddTaskButton(),
    );
  }

  Widget _buildAddTaskButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        setState(() {
          plan.tasks.add(Task());
        });
      },
    );
  }

  Widget _buildList() {
    return ListView.builder(
      controller: controller,
      itemCount: plan.tasks.length,
      itemBuilder: (context, index) {
        return _buildTaskTile(plan.tasks[index]);
      },
    );
  }

  Widget _buildTaskTile(Task task) {
    return Dismissible(
      key: ValueKey(task),
      background: Container(
        color: Colors.red,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        final controller = PlanProvider.of(context);
        controller.deleteTask(plan, task);
        setState(() {});
      },
      child: ListTile(
        leading: Checkbox(
          value: task.complete,
          onChanged: (selected) {
            setState(() {
              task.complete = selected!;
            });
          },
        ),
        title: TextFormField(
          initialValue: task.description,
          onFieldSubmitted: (text) {
            setState(() {
              task.description = text;
            });
          },
          onChanged: (text) {
            setState(() {
              task.description = text;
            });
          },
        ),
      ),
    );
  }
}
