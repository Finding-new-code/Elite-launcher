// import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;
// import 'package:google_fonts/google_fonts.dart';

// // class Notepad extends StatelessWidget {
//    Notepad({Key? key}) : super(key: key);
//   final _controller = quill.QuillController.basic();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(backgroundColor: Colors.indigo.shade100,
//             title: Text(
//           'Notepad',
//           style: GoogleFonts.robotoFlex(fontSize: 20),
//         )),
//         body: Column(
//           children: [
//             quill.QuillToolbar.basic(controller: _controller),
//             Expanded(child: Container(color: Colors.indigo.shade50,
//               padding:const EdgeInsets.all(7),
//               child: quill.QuillEditor.basic(controller: _controller, readOnly:false),
//             ))
//           ],
//         ));
//   }
// }
