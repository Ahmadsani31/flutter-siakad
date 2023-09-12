import 'package:flutter/material.dart';

class MkPage extends StatefulWidget {
  const MkPage({super.key});

  @override
  State<MkPage> createState() => _MkPageState();
}

class _MkPageState extends State<MkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Page Mata Kuliah',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
