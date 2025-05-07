import 'package:devoida_front/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              leading: Icon(Icons.favorite),
              title: 'Workspaces',
              actions: [],
            ),
          ],
        ),
      ),
    );
  }
}
