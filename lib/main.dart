import 'dart:async';
import 'package:elite_launcher/widgets/clock.dart';
import 'package:elite_launcher/scr/api.dart';
import 'package:elite_launcher/widgets/lannding.dart';
import 'package:elite_launcher/widgets/notepad.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';


// final String imageurl;
int? isviewed;

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefes = await SharedPreferences.getInstance();
  // ignore: await_only_futures
  isviewed = await prefes.getInt('isviewed');
  await prefes.setInt('isviewed', 1);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: HomePage(),
      initialRoute: isviewed == 0 || isviewed == null ? '/a' : '/',
      routes: {
        '/a': (context) => const Onboard(),
        '/b': (context) => const Wallpaper(),
        '/c':(context) =>  Notepad(),
      },
    );
  }
}

String? name;

class HomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  HomePage({Key? key, final imageurl, final name}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BouncingScrollPhysics _bouncingScrollPhysics =
      const BouncingScrollPhysics();
  final videoPlayerController =
      VideoPlayerController.asset('assets/images/waves.mp4');
  String? _timeString;
 
  // ChewieController? chewieController;
  final hello = "assets/images/paper.jpg";
  final hi = name;
  final book = "assets/images/books.png";
  @override
  void initState() {
    // chewieController = ChewieController(
    //   videoPlayerController: videoPlayerController,
    //   autoPlay: true,
    //   looping: true,
    //   autoInitialize: true,
    //   showControls: false,
    //   aspectRatio: 10 / 20,
    //   allowMuting: true,
    // );
    _timeString =
       "${DateTime.now().hour} : ${DateTime.now().minute} ";

     Timer.periodic(const Duration(seconds:1), (Timer t) => getCurrentDate());
    name = name;
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    //chewieController!.dispose();
   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue.shade50,
        child: PageView(
          
          children: [
          
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(hello), fit: BoxFit.cover)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50, left: 50),
                      child: Row(
                        children: [
                          Text(
                            greetingMessage(),
                            style: GoogleFonts.robotoFlex(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70),
                          ),
                          Text(hi.toString())
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 50, top: 10, right: 20),
                      child: Text(
                        getCurrentDate(),
                        style: GoogleFonts.robotoFlex(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                     SizedBox(height: 100,width:150,
                       child: 
                   IconButton(onPressed:(() {
                       Navigator.pushNamed(context,'/c');
                   }), icon:Image.asset("assets/images/books.png"),iconSize: 1,),
                     )
                  ],
                )),
            // Chewie(
            //   controller: chewieController!,
            // ),
            FutureBuilder(
              future: DeviceApps.getInstalledApplications(
                includeSystemApps: true,
                includeAppIcons: true,
                onlyAppsWithLaunchIntent: true,
              ),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  List<Application> allapps = snapshot.data;
                  return GridView.count(
                      crossAxisCount: 3,
                      padding: const EdgeInsets.all(16.0),
                      physics: _bouncingScrollPhysics,
                      children: List.generate(allapps.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            DeviceApps.openApp(allapps[index].packageName);
                          },
                          child: Column(
                            children: [
                              Image.memory(
                                (allapps[index] as ApplicationWithIcon).icon,
                                width: 40.0,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                allapps[index].appName,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 12, 12, 12),
                                ),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        );
                      }));
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
   
String getCurrentDate() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('kk:mm\nEEE d MMM').format(now);
  
  return formattedDate;
}
}
