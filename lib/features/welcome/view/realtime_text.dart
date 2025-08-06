
import 'dart:convert';
import 'dart:ui';
import 'package:edu_tara/core/api/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RealtimeText extends StatefulWidget {
  const RealtimeText({super.key});

  @override
  State<RealtimeText> createState() => _RealtimeTextState();
}

class _RealtimeTextState extends State<RealtimeText> {
  late WebSocketChannel channel;
  String fullMessage = "";
  String displayText = "";
  bool isTyping = false;
  bool showText = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    channel = WebSocketChannel.connect(
      Uri.parse('ws://${ApiConstants.ip}:8080/ws/socket-server/'),
    );
    channel.stream.listen((data) {
      try {
        final jsonData = jsonDecode(data);
        final char = jsonData['char'];

        if (char == 1) {
          setState(() {
            fullMessage = "";
            displayText = "";
            showText = true;
          });
        }  else if (char != null && showText) {
          fullMessage += char;
          _typeCharacter();
        }
      } catch (e) {
        print("Invalid JSON: $data");
      }
    });
  }

  Future<void> _typeCharacter() async {
    if (isTyping) return;
    isTyping = true;

    await Future.delayed(const Duration(milliseconds: 30));
    setState(() {
      displayText = fullMessage;
    });

    isTyping = false;
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Blur overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF608878).withOpacity(0.2),
                  const Color(0xFF18221E).withOpacity(0.2),
                ],
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.transparent),
            ),
          ),

          // Typing text
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Text(
                showText
                    ? (displayText.isEmpty
                          ? "Waiting for characters..."
                          : displayText)
                    : "",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Back button
          Positioned(
            top: 30,
            left: 30,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
