import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:siakat/service/resProfil.dart';
import 'package:siakat/ultis/helper.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPagePageState();
}

class _DashboardPagePageState extends State<DashboardPage> {
  late Future<ResProfil> resProfil;
  var sToken;

  final dio = Dio();
  void setupBasicAuth() {
    String username = 'bitkom-api';
    String password = '#bitkom2023';

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    dio.options.headers['authorization'] = basicAuth;
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      getDataProfil();
    });
    super.initState();
    resProfil = getDataProfil();
  }

  Future<ResProfil> getDataProfil() async {
    sToken = await Helper.getUserData();
    setupBasicAuth();
    final response = await dio
        .get('https://api-siakad.itp.ac.id/mahasiswa/profil?token=$sToken');
    print(response.data);
    if (response.statusCode == 200) {
      print(response.data['items']);

      return ResProfil.fromJson(response.data['items']);
      // _vNama = response.data['items']['Nama'];
    } else {
      throw Exception('Failed to load album asdasasd');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(sToken);
    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MaterialButton(
          padding: EdgeInsets.all(5),
          onPressed: () {},
          child: _buildButtonColumn(color, Icons.call, 'CALL'),
        ),
        MaterialButton(
          padding: EdgeInsets.all(5),
          onPressed: () {},
          child: _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
        ),
        MaterialButton(
          padding: EdgeInsets.all(5),
          onPressed: () {},
          child: _buildButtonColumn(color, Icons.share, 'SHARE'),
        ),
      ],
    );

    return Scaffold(
        body: Center(
      child: FutureBuilder(
        future: resProfil,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: const EdgeInsets.all(32),
              child: Row(
                children: [
                  Expanded(
                    /*1*/
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /*2*/
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              '${snapshot.data!.nama}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '${snapshot.data!.mhswID}',
                            style: TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          buttonSection
                        ],
                      ),
                    ),
                  ),
                  /*3*/
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    ));
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
