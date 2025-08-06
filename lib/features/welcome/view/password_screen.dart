import 'package:edu_tara/core/widgets/glassmorphism.dart';
import 'package:edu_tara/core/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinPasswordScreen extends StatelessWidget {
  final defaultPinTheme = PinTheme(
    width: 60,
    height: 60,
    textStyle: const TextStyle(fontSize: 20, color: Colors.white),
    decoration: BoxDecoration(
      color: Colors.white24,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.white30),
    ),
  );

  @override
  Widget build(BuildContext context) {
    String pinCode = '1234';

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ChildGlasmorphism(
            borderRadius: 0,
            borderColor: Colors.transparent,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Enter 4-digit PIN",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  const SizedBox(height: 20),
                  Pinput(
                    length: 4,
                    obscureText: true,
                    obscuringCharacter: '●',
                    defaultPinTheme: defaultPinTheme,
                    onCompleted: (value) {
                      pinCode = value;
                      print("Entered PIN: $pinCode");
                    },
                  ),
                  const SizedBox(height: 20),
                  ChildGlasmorphism(
                    borderRadius: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (pinCode == "5678") {
                            
                          } else {
                            showTopRightToast(
                              context: context,
                              message: "Enter all 4 digits",
                              color: Colors.red,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .transparent, // Don't override container color
                          shadowColor: Colors.transparent, // Remove shadow
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
