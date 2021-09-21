import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ucms/components/label_input.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          constraints: const BoxConstraints(maxWidth: 360, maxHeight: 800),
          padding: const EdgeInsets.all(20.0),
          child: Align(
            alignment: Alignment.center,
            child: ListView(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const SizedBox(height: 100),
                const Text("Register",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                const LabelInput(label: "id", hint: "id"),
                const LabelInput(label: "pw", hint: "pw"),
                const LabelInput(label: "pw check", hint: "re-enter pw"),
                const LabelInput(label: "division", hint: "division"),
                TextButton(
                  onPressed: () {},
                  child: const Text("전입 등록 신청", textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}