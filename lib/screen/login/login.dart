// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:siakat/components/button.dart';
import 'package:siakat/components/input.dart';
// import 'package:smart_alert_dialog/models/alert_dialog_text.dart';
// import 'package:smart_alert_dialog/smart_alert_dialog.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakat/ultis/helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final usernameValue = TextEditingController();
  final passwordValue = TextEditingController();

  var _isObSecure;
  String sToken = '';
  final _formKey = GlobalKey<FormState>();

  final dio = Dio();
  void setupBasicAuth() {
    String username = 'bitkom-api';
    String password = '#bitkom2023';

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    dio.options.headers['authorization'] = basicAuth;
  }

  void initState() {
    super.initState();
    _isObSecure = true;
    setState(() {
      cekToken();
    });
  }

  void cekToken() async {
    sToken = await Helper.getUserData() ?? '';
    if (sToken.isNotEmpty) {
      Navigator.pushNamed(context, '/home');
    }
  }

  Future<void> singUserIn() async {
    print(sToken);

    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Processing Data')),
      // );
      setupBasicAuth();
      final formData = FormData.fromMap({
        'username': usernameValue.text,
        'password': passwordValue.text,
      });
      try {
        Response response = await dio.post(
          'https://api-siakad.itp.ac.id/auth/login',
          data: formData,
        );

        if (response.statusCode == 200) {
          // Request was successful
          await Helper.saveUserData(response.data['items']['token']);

          Navigator.pushNamed(context, '/home');
          print('Response data: ${response.data}');
        } else {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Oops...',
            text: 'Terjadi Kesalahan',
          );
          // Handle errors
          // print('Request failed with status: ${response.statusCode}');
          // print('Response data: ${response.data}');
        }
      } catch (error) {
        // Handle exceptions
        // showErrMsg('$error');
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Warning',
          text: '$error',
        );
        // print('Error: $error');
      }
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Warning',
        text: 'input tidak boleh kosong',
      );
    }
  }

  void showErrMsg(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: Center(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset('assets/logo/logo.png', width: 300, height: 100),
                const Text(
                  'Selamat Datang',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 25,
                ),
                InputText(
                  valueText: usernameValue,
                  hintText: 'username',
                  secureText: false,
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: passwordValue,
                    obscureText: _isObSecure,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isObSecure = !_isObSecure;
                            });
                            print(_isObSecure);
                          },
                          child: Icon(_isObSecure
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'password'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forget password',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                MyButton(onTap: singUserIn),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text(
                    'Registrasi',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
