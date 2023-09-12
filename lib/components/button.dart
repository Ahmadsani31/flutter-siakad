import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  const MyButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(width: 2, color: Colors.black)),
        minWidth: double.infinity,
        height: 60,
        color: Colors.white,
        textColor: Colors.black,
        onPressed: onTap,
        child: const Text('Log In'),
      ),
    );

    // return GestureDetector(
    //   onTap: onTap,
    //   child: Container(
    //     padding: const EdgeInsets.all(25),
    //     margin: const EdgeInsets.symmetric(horizontal: 25),
    //     decoration: BoxDecoration(
    //         color: Colors.black, borderRadius: BorderRadius.circular(8)),
    //     child: const Center(
    //       child: Text(
    //         'Sing In',
    //         style: TextStyle(
    //           color: Colors.white,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
