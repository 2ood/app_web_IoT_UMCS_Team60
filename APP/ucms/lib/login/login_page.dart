import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/texts.dart';
import 'package:ucms/form/form_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KScreen(
          child: ListView (
            // ignore: prefer_const_literals_to_create_immutables
            children : [
              const SizedBox(height:100),
                title("login"),
                FormLogin(),
                Row (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children : [
                    PostButton(onPressed : (){
                      Navigator.pushNamed(context, "/user/main");
                    },label: "용사 로그인"),
                    PostButton(onPressed: (){
                      Navigator.pushNamed(context, "/user/main");
                    },label: "간부 로그인"),
                  ],
                ),
                PageButton(onPressed: (){
                  Navigator.pushNamed(context, "/register");
                },label: "전입 신병 가입"),
            ],
          ),
      ),
    );
  }
}


