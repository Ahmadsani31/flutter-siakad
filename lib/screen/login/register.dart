// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:siakat/components/button.dart';
import 'package:siakat/components/input.dart';
// import 'package:smart_alert_dialog/models/alert_dialog_text.dart';
// import 'package:smart_alert_dialog/smart_alert_dialog.dart';
import 'package:quickalert/quickalert.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final namaValue = TextEditingController();
  final emailValue = TextEditingController();
  final usernameValue = TextEditingController();
  final passwordValue = TextEditingController();
  final passworConfirmdValue = TextEditingController();

  var _isObSecure;

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
  }

  Future<void> singUserIn() async {
    setupBasicAuth();
    final formData = FormData.fromMap({
      'username': usernameValue.text,
      'password': passwordValue.text,
    });
    try {
      Response response = await dio.post(
        'https://api-presensi.itp.ac.id/APIGet',
        data: formData,
      );

      if (response.statusCode == 200) {
        // Request was successful
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/logo/logo.png', width: 300, height: 100),
                const Text(
                  'Registrasi',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 25,
                ),
                InputText(
                  valueText: namaValue,
                  hintText: 'Nama',
                  secureText: false,
                ),
                const SizedBox(
                  height: 25,
                ),
                InputText(
                  valueText: emailValue,
                  hintText: 'Email',
                  secureText: false,
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
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: passworConfirmdValue,
                    obscureText: _isObSecure,
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
                        hintText: 'Confirm Password'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide(width: 2, color: Colors.black)),
                    minWidth: double.infinity,
                    height: 60,
                    color: Colors.white,
                    textColor: Colors.black,
                    onPressed: () {},
                    child: const Text('Register'),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child: const Text(
                    'Log In',
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
