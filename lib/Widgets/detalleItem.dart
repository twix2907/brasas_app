import 'package:flutter/material.dart';

import 'AppBarWidget.dart';
class name extends StatefulWidget {
  const name({super.key});

  @override
  State<name> createState() => _nameState();
}

class _nameState extends State<name> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 5),
        child: ListView(
          children: [
            AppBarWidget(),
            Padding(
              padding: EdgeInsets.all(16),
              child: Image.asset(
                "assets/images/platos.png",
                height: 300,
                width: double.infinity,
              ),
            ),
          ],
        ),
      );
  }
}