



import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:async_wallpaper/async_wallpaper.dart';

class FullScreen extends StatefulWidget {
  final String imageurl;

  const FullScreen({Key? key, required this.imageurl}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  Future<void> setwallpaper() async {
    int wallpaperLocation = AsyncWallpaper.HOME_SCREEN;
Navigator.pushNamedAndRemoveUntil(context, "/",arguments:widget.imageurl, (route) => true);
    var file = await DefaultCacheManager().getSingleFile(widget.imageurl);

     await AsyncWallpaper.setWallpaperFromFile(
        filePath: file.path,
        wallpaperLocation: wallpaperLocation,
        goToHome: true);
    
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