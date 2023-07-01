import 'dart:ui';

import 'package:flutter/material.dart';

const MaterialColor defaultColor = Colors.blue;
const MaterialColor dangerColor = Colors.red;
const MaterialColor warningColor = Colors.yellow;
const MaterialColor successColor = Colors.green;
const MaterialColor primaryColor = Colors.blue;
final hicolor = Colors.deepPurple.shade800;



const String _shaders = 'assets/shaders';
 const String orbShader = '$_shaders/orb_shader.frag';
   const String uiShader = '$_shaders/ui_glitch.frag';

typedef FragmentPrograms = ({FragmentProgram orb, FragmentProgram ui});

Future<FragmentPrograms> loadFragmentPrograms() async => (
      orb: (await _loadFragmentProgram(orbShader)),
      ui: (await _loadFragmentProgram(uiShader)),
    );

    
Future<FragmentProgram> _loadFragmentProgram(String path) async {
  return (await FragmentProgram.fromAsset(path));
}