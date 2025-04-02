import 'package:app_pedidos/Widgets/AppBarWidget.dart';
import 'package:flutter/material.dart';

class ItemPage extends StatefulWidget {
  final String imagen;

  const ItemPage({Key? key, required this.imagen}) : super(key: key);

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 5),
        child: ListView(
          children: [
            AppBarWidget(),
            Padding(
              padding: EdgeInsets.all(16),
              child: Image.network(
                widget.imagen,
                height: 300,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
