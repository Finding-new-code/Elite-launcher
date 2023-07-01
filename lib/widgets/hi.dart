import 'package:flutter/material.dart';

String? hello;

class FullScreen extends StatefulWidget {
  final String imageurl;

  const FullScreen({Key? key, required this.imageurl}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  late bool gotohome;
  @override
  void initState() {
    super.initState();
    gotohome = false;
  }

  Future<void> setwallpaper() async {
    // var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
    // int location = AsyncWallpaper.HOME_SCREEN;
    // try {
    //   var result = await AsyncWallpaper.setWallpaperFromFile(
    //     filePath: file.path,
    //     wallpaperLocation: location,
    //     goToHome: gotohome
    //   );
    // } on PlatformException {
    //  String result = "failed to get wallpaper";
    // }

    setState(() {
       hello = widget.imageurl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Expanded(
            child: Container(
              child: Image.network(
                widget.imageurl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setwallpaper();
            },
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.pink.shade100,
              child: const Center(
                child: Text('Set Wallpaper',
                    style: TextStyle(fontSize: 20, color: Colors.deepPurple)),
              ),
            ),
          )
        ],
      )),
    );
  }
}
