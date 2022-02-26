import 'package:flutter/material.dart';
import './animated_button.dart' as AB;

class AnimatedButtonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AB.AnimatedButton(
          onTap: () {
            print("animated button pressed");
          },
          animationDuration: const Duration(milliseconds: 2000),
          initialText: "Confirm",
          finalText: "Submitted",
          iconData: Icons.check,
          iconSize: 32.0,
          buttonStyle: AB.ButtonStyle(
            primaryColor: Colors.green.shade600,
            secondaryColor: Colors.white,
            elevation: 20.0,
            initialTextStyle: TextStyle(
              fontSize: 22.0,
              color: Colors.white,
            ),
            finalTextStyle: TextStyle(
              fontSize: 22.0,
              color: Colors.green.shade600,
            ),
            borderRadius: 10.0,
          ),
        ),
      ),
    );
  }
}
