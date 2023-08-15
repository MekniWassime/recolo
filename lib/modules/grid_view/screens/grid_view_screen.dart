import 'package:flutter/material.dart';
import 'package:recolo/modules/grid_view/widgets/year_view.dart';

class GridViewScreen extends StatefulWidget {
  const GridViewScreen({Key? key}) : super(key: key);

  @override
  State<GridViewScreen> createState() => _GridViewScreenState();
}

class _GridViewScreenState extends State<GridViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const YearView(year: 2023));
  }
}
