import 'package:elite_launcher/widgets/lannding.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';

int? isviewed;
void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefes = await SharedPreferences.getInstance();
  isviewed = prefes.getInt('Onboard');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: HomePage(),
      initialRoute: isviewed !=0? '/a':'/',
      routes: {
        '/a': (context) => const Onboard(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BouncingScrollPhysics _bouncingScrollPhysics =
      const BouncingScrollPhysics();
  final videoPlayerController =
      VideoPlayerController.asset('assets/images/waves.mp4');

  ChewieController? chewieController;

  @override
  void initState() {
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      autoInitialize: true,
      showControls: false,
      aspectRatio: 10 / 20,
    );
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    int isviewed = 0;
    SharedPreferences prefes = await SharedPreferences.getInstance();
    await prefes.setInt('Onboard', isviewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: PageView(
          children: [
            Chewie(
              controller: chewieController!,
            ),
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
}
