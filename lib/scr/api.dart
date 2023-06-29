import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:elite_launcher/scr/animate.dart';
import 'package:elite_launcher/widgets/hi.dart';



class Wallpaper extends StatefulWidget {
  const Wallpaper({Key? key}) : super(key: key);

  @override
  State<Wallpaper> createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  List images = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    fetchapi();
  }

  fetchapi() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=90'),
        headers: {
          'Authorization':
              '563492ad6f917000010000013734efa60b0d4a2faef4a9f3370811fb'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
      // ignore: avoid_print
      print(images[0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade100,
        title: const Text("Choose Your Wallpaper"),
      ),
      backgroundColor: Colors.brown.shade200,
        body: Column(
      children: [
        Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 7,
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 7,
              ),
              itemCount: images.length,
              itemBuilder: ((context, index) {
                return AnimatedScrollViewItem(
                    child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FullScreen(
                                  imageurl: images[index]['src']['large2x'],
                                )));
                  },
                  child: Hero(
                    tag: images[index]['src']['tiny'],
                    child: ClipRRect(borderRadius: BorderRadius.circular(16),
                    child: Image.network(images[index]['src']['portrait'],
                    fit: BoxFit.cover,),),
                  ),
                ));
              }),
            )),
      ],
    ));
  }
}
