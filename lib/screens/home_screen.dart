import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexus_focus/utils/colors.dart';
import 'package:nexus_focus/widgets/custom_buttom.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FractionallySizedBox(
        widthFactor: 1.0,
        child: Container(
          width: 260,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 25.0),
                child: Image.asset('assets/img/logo.png', height: 120),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Nexus',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: primaryColor,
                      ),
                    ),
                    TextSpan(
                      text: 'Focus',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 30.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 160),
              CustomButton(
                  text: "Fazer Login",
                  background: primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  }),
              CustomButton(
                  text: "Cadastrar",
                  background: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  })
            ],
          ),
        ),
      ),
    );
  }
}
