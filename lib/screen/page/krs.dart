import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:siakat/model/model_krs.dart';
import 'package:siakat/ultis/helper.dart';

import 'package:rounded_background_text/rounded_background_text.dart';

class KRSPage extends StatefulWidget {
  const KRSPage({super.key});

  @override
  State<KRSPage> createState() => _KRSPageState();
}

class _KRSPageState extends State<KRSPage> {
  List<ModelKRS> fecthKrs = [];
  final List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  final dio = Dio();
  void setupBasicAuth() {
    String username = 'bitkom-api';
    String password = '#bitkom2023';

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    dio.options.headers['authorization'] = basicAuth;
  }

  Future<List<ModelKRS>> fetchKrs() async {
    final sToken = await Helper.getUserData();
    print(sToken);
    try {
      setupBasicAuth();
      final response = await dio
          .get('https://api-siakad.itp.ac.id/mahasiswa/krs?token=$sToken');

      print(response.data['items']['krs']);

      if (response.statusCode == 200) {
        final data = response.data['items']['krs'];
        for (Map<String, dynamic> index in data) {
          fecthKrs.add(ModelKRS.fromJson(index));
        }
        return fecthKrs;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e, pesan) {
      print(pesan);
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // setState(() {
    //   fetchKrs();
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = list.first;
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Column(children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              child: DropdownMenu<String>(
                width: 400,
                initialSelection: list.first,
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                    list.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            )
          ]),
          FutureBuilder(
              future: fetchKrs(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print('data snapshot ${snapshot.data!.length}');
                  if (snapshot.data!.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: fecthKrs.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            print('object');
                            return Container(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                padding: EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 211, 210, 210),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${fecthKrs[index].mKKode} | ${fecthKrs[index].namaMK}",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                        "Dosen : ${fecthKrs[index].namaDosen}"),
                                    SizedBox(height: 5),
                                    Wrap(
                                      spacing: 20,
                                      runSpacing: 10,
                                      children: [
                                        RoundedBackgroundText(
                                          "Hari ${fecthKrs[index].hari}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          backgroundColor: Colors.white,
                                        ),
                                        RoundedBackgroundText(
                                          "Pukul ${fecthKrs[index].jamKuliah}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          backgroundColor: Colors.white,
                                        ),
                                        RoundedBackgroundText(
                                          "${fecthKrs[index].sKS} SKS",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          backgroundColor: Colors.white,
                                        ),
                                        RoundedBackgroundText(
                                          fecthKrs[index].jenisPerkuliahan ==
                                                  'L'
                                              ? 'Luring'
                                              : 'Daring',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          backgroundColor: Colors.white,
                                        ),
                                        RoundedBackgroundText(
                                          'Ruangan ${fecthKrs[index].ruangID}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          backgroundColor: Colors.white,
                                        ),
                                        RoundedBackgroundText(
                                          '${fecthKrs[index].namaKelas}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          backgroundColor: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  } else {
                    print('object a');
                    return Center(
                      child: Container(
                        child: RoundedBackgroundText(
                          'KRS Belum Diisi',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          backgroundColor: Colors.amber,
                        ),
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      )),
    );
  }
}
