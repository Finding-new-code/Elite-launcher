import 'dart:math';
import 'package:elite_launcher/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import 'package:elite_launcher/scr/constants.dart/colors.dart';

String? username;

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  final _formkey = GlobalKey<FormState>();
  String name = "";

  final controller = PageController(initialPage: 0);
  final _controller = ConfettiController(duration: const Duration(seconds: 5));
  bool isPlaying = false;

  @override
  void dispose() {
    controller.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Form(
            key: _formkey,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/undraw_hey_email_liaa.png",
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'are you an introvert? if not go ahead..';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        name = value;
                        name = username.toString();
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                          labelText: "Your Name",
                          hintText: "Enter your Nick name",
                          fillColor: Color.fromARGB(255, 84, 38, 163),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton.icon(
                    key: _formkey,
                    label: const Text("Got it"),
                    onPressed: () {
                      // if (_formkey.currentState!.validate()) {
                      controller.nextPage(
                          duration: const Duration(seconds: 1),
                          curve: Curves.bounceInOut);
                      // }
                      // return;
                    },
                    icon: const Icon(Icons.arrow_circle_right),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 300,
                    ),
                    child: Text.rich(
                      TextSpan(text: "Made by ", children: <TextSpan>[
                        TextSpan(
                            text: "CODER LAB",
                            style: GoogleFonts.robotoFlex(
                              fontSize: 12,
                              color: Colors.indigoAccent,
                            ))
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                ConfettiWidget(
                  confettiController: _controller,
                  blastDirection: pi,
                  numberOfParticles: 25,
                  emissionFrequency: 0.07,
                ),
                Image.asset(
                  "assets/images/undraw_Well_done_re_3hpo.png",
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "well done",
                  style: GoogleFonts.robotoMono(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: hicolor,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "you have such a great nick name.\nI will remember for sure.",
                  style: GoogleFonts.robotoMono(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: hicolor),
                ),
                const SizedBox(
                  height: 20,
                ),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(colors: [
                    Color(0xff027DFD),
                    Color(0xff4100e0),
                    Color(0xff1CDAC5),
                    Color(0xffF2DD22),
                  ], stops: [
                    0.10,
                    0.20,
                    0.50,
                    0.75
                  ]).createShader(
                    bounds,
                  ),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                FloatingActionButton.extended(
                  onPressed: (() {
                    _controller.play();
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => HomePage())));
                    });
                  }),
                  label: const Text("Let's get started"),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 125,
                  ),
                  child: Text.rich(
                    TextSpan(text: "Made by ", children: <TextSpan>[
                      TextSpan(
                          text: "CODER LAB",
                          style: GoogleFonts.robotoFlex(
                            fontSize: 12,
                            color: Colors.indigoAccent,
                          ))
                    ]),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
