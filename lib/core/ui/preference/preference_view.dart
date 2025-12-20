import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dashboard/dashboard_view.dart';

class PreferenceView extends StatefulWidget {
  @override
  State<PreferenceView> createState() => _PreferenceViewState();
}

class _PreferenceViewState extends State<PreferenceView> {
  final foods = {
    "South Indian": false,
    "Punjabi": false,
    "Chinese": false,
    "Continental": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Preferences")),
      body: Column(
        children: [
          ...foods.keys.map((food) => CheckboxListTile(
            title: Text(food),
            value: foods[food],
            onChanged: (val) {
              setState(() => foods[food] = val!);
            },
          )),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => DashboardView()),
              );
            },
            child: Text("Continue"),
          )
        ],
      ),
    );
  }
}