import 'package:flutter/material.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Page Jadwal',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
