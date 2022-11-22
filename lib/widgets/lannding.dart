import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import 'package:elite_launcher/scr/constants.dart/colors.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
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
          Container(
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
                SizedBox(width: 350,
                  child: TextFormField(
                    onChanged: (value) {
                      name = value;
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
                FloatingActionButton(
                  enableFeedback: true,
                  splashColor: Colors.indigo.shade200,
                  backgroundColor: Colors.indigo.shade800,
                  isExtended: true,
                  child: const Icon(Icons.arrow_circle_right),
                  tooltip: "Got it",
                  onPressed: (() {
                
                      controller.nextPage(
                          duration: const Duration(seconds: 1),
                          curve: Curves.bounceInOut);
                   
                  }),
                ),
              ],
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
                  "you have such great nick name.\nI will remember for sure.",
                  style: GoogleFonts.robotoMono(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: hicolor),
                ),
                const SizedBox(
                  height: 20,
                ),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
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
                  height: 25,
                ),
                FloatingActionButton.extended(
                  onPressed: (() {
                    _controller.play();
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pushNamed(context, '/');
                    });
                  }),
                  label: const Text("Let's get started"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
