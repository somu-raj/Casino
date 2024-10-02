
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:roullet_app/2%20Patti%20Game/Screens/join_room_screen.dart';
import 'package:roullet_app/2%20Patti%20Game/Screens/poker.dart';
// import 'package:roullet_app/Black%20Jack/db/database_manager.dart';
import 'dart:developer' as dev;
import 'package:roullet_app/Helper_Constants/colors.dart';
import 'package:roullet_app/Helper_Constants/other_constants.dart';
import 'Dice Game/Craps.dart';
import 'Dice Game/CrapsTablePainter.dart';
// import 'Ludo/connect_to_user_socket.dart';
// import 'Ludo/dice/dice.dart';
// import 'Ludo/game.dart';
import 'Screens/Splash/splash_screen.dart';
import 'Tambola Game/TambolaGameScreen.dart';
import 'audio_controller.dart';

void main() async {
  Logger.root.level = kDebugMode ? Level.FINE : Level.INFO;

  Logger.root.onRecord.listen((record) {
    dev.log(
      record.message,
      time: record.time,
      level: record.level.value,
      name: record.loggerName,
      zone: record.zone,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  });

  WidgetsFlutterBinding.ensureInitialized();
  final audioController = AudioController();
  // await DatabaseManager.initialize();
  await audioController.initialize();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]).then((value){
    runApp(MyApp(audioController: audioController,));
  });
  runApp(MyApp(audioController: audioController,));

}

class MyApp extends StatefulWidget  {
  const MyApp({Key? key, required this.audioController}) : super(key: key);
  final AudioController audioController;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  bool appLifeCycleStateMute = false;
  @override
 /* void didChangeAppLifecycleState(AppLifecycleState state) {
    bool isMute = widget.audioController.mute;
    if(appLifeCycleStateMute){
      isMute = false;
    }
    if (!isMute && (state == AppLifecycleState.paused || state==AppLifecycleState.resumed)) {
      appLifeCycleStateMute = !appLifeCycleStateMute;
      widget.audioController.muteAudio();
    }
    else{
      debugPrint(state.toString());
    }
  }*/
  void didChangeAppLifecycleState(AppLifecycleState state) {
    bool isMute = widget.audioController.mute;

    if (state == AppLifecycleState.paused) {
      if (!isMute) {
        appLifeCycleStateMute = true;
        widget.audioController.muteAudio();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (appLifeCycleStateMute) {
        appLifeCycleStateMute = false;
        widget.audioController.unMuteAudio();
      }
    } else {
      debugPrint(state.toString());
    }
  }

  /*bool wasMutedBeforePause = false;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Save the current mute state before pausing
      wasMutedBeforePause = widget.audioController.mute;
      if (!wasMutedBeforePause) {
        widget.audioController.muteAudio();
      }
    } else if (state == AppLifecycleState.resumed) {
      // Restore the mute state when resumed
      if (!wasMutedBeforePause) {
        widget.audioController.unMuteAudio();
      }
    }
    debugPrint(state.toString());
  }*/

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
     debugPrint(
       "my app"
     );
     /*Wakelock.enable();*/
    Constants.getScreenSize(context);
    return GetMaterialApp(
        title: 'Uncle Casino',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: colors.primary_app,
        ),
        home:
         //const TambolaGameScreen(),
         //CrapsGame(audioController: widget.audioController),
        //ConnectSocket(audioController: widget.audioController ,)
        SplashScreen(
          audioController: widget.audioController,
        )
        //MainApp(audioController: audioController ,)
        //MyHomePage(audioController: audioController),
        );
  }
}

/*import 'package:flutter/material.dart';
import 'ludo_pawn.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Ludo King Pawns')),
        body: LayoutBuilder(
          builder: (context, constraints) {
            // Determine the size of the pawn based on screen width
            double pawnSize = constraints.maxWidth / 4;

            return Center(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LudoPawn(color: Colors.red, size: pawnSize),
                        SizedBox(width: pawnSize / 4),
                        LudoPawn(color: Colors.green, size: pawnSize),
                      ],
                    ),
                    SizedBox(height: pawnSize / 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LudoPawn(color: Colors.blue, size: pawnSize),
                        SizedBox(width: pawnSize / 4),
                        LudoPawn(color: Colors.yellow, size: pawnSize),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}*/

/*class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.audioController});

  final AudioController audioController;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _gap = SizedBox(height: 16);
  bool filterApplied = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter SoLoud Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
              onPressed: () {
                widget.audioController
                    .playSound('assets/Sounds/pew1.mp3', 'pew1_sound');
              },
              child: const Text('Play Sound'),
            ),
            _gap,
            OutlinedButton(
              onPressed: () {
                widget.audioController.startMusic();
              },
              child: const Text('Start Music'),
            ),
            _gap,
            OutlinedButton(
              onPressed: () {
                widget.audioController.fadeOutMusic();
              },
              child: const Text('Fade Out Music'),
            ),
            _gap,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Apply Filter'),
                Checkbox(
                  value: filterApplied,
                  onChanged: (value) {
                    setState(() {
                      filterApplied = value!;
                    });
                    if (filterApplied) {
                      widget.audioController.applyFilter();
                    } else {
                      widget.audioController.removeFilter();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}*/

/*class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.audioController});
  final AudioController audioController;

  Stream<int> countdownTimer({
    VoidCallback? onStart,
    VoidCallback? onEnd,
    Function(int)? onChange,
  }) {
    const int maxCountdown = 60;
    const interval = Duration(seconds: 1);

    return Stream.periodic(interval, (_) {
      final int currentCount = maxCountdown - DateTime.now().second;

      onChange?.call(currentCount);

      if (currentCount == 0) {
        onEnd?.call();
      } else if (currentCount == maxCountdown) {
        onStart?.call();
      }
      return currentCount;
    });
  }

  playAudio(String sourcePath) {
    AudioPlayer().play(AssetSource(sourcePath));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: StreamBuilder<int>(
            stream: countdownTimer(
              onEnd: () {},
              onStart: () {},
              onChange: (int count) {
                debugPrint('$count');
                // audioController.playSound('assets/Sounds/pew1.mp3');
                audioController.playSound(
                    'assets/Sounds/clock_ticking_natural_sound.mp3',
                    'count_down');
                // playAudio(SoundSource.countDownSoundPath);
              },
            ),
            builder: (_, snapshot) => Text('${snapshot.data ?? 0}'),
          ),
        ),
      ),
    );
  }
}*/

//
// class Page extends StatefulWidget {
//   const Page({super.key});
//
//   @override
//   State<StatefulWidget> createState() => _PageState();
// }
//
// class _PageState extends State<Page> with SingleTickerProviderStateMixin {
//   // Set the initial position to something that will be offscreen for sure
//   Tween<Offset> tween = Tween<Offset>(
//     begin: Offset(0.0, 10000.0),
//     end: Offset(0.0, 0.0),
//   );
//  late Animation<Offset> animation;
//  late  AnimationController animationController;
//
//   GlobalKey _widgetKey = GlobalKey();
//
//   @override
//   void initState() {
//     super.initState();
//
//     // initialize animation controller and the animation itself
//     animationController = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     );
//     animation = tween.animate(animationController);
//
//     Future<void>.delayed(Duration(seconds: 1), () {
//       // Get the screen size
//       final Size screenSize = MediaQuery.of(context).size;
//       // Get widget's size
//       final Size widgetSize = _widgetKey.currentContext!.size!;
//
//       // Calculate the dy offset.
//       // We divide the screen height by 2 because the initial position of the widget is centered.
//       // Ceil the value, so we get a position that is a bit lower the bottom edge of the screen.
//       final double offset = (screenSize.height / 2 / widgetSize.height).ceilToDouble();
//
//       // Re-set the tween and animation
//       tween = Tween<Offset>(
//         begin: Offset(0.0, offset),
//         end: Offset(0.0, 0.0),
//       );
//       animation = tween.animate(animationController);
//
//       // Call set state to re-render the widget with the new position.
//       this.setState((){
//         // Animate it.
//         animationController.forward();
//         if(animationController.isCompleted){
//           animationController.reset();
//           animationController.repeat();
//         }
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     // Don't forget to dispose the animation controller on class destruction
//     animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       fit: StackFit.loose,
//       children: <Widget>[
//         SlideTransition(
//           position: animation,
//           child: CircleAvatar(
//             key: _widgetKey,
//             backgroundImage: NetworkImage(
//               'https://pbs.twimg.com/media/DpeOMc3XgAIMyx_.jpg',
//             ),
//             radius: 50.0,
//           ),
//         ),
//       ],
//     );
//   }
// }
//

// class MainApp extends StatefulWidget {
//   const MainApp({super.key});
//
//   @override
//   State<MainApp> createState() => _MainAppState();
// }

// class _MainAppState extends State<MainApp> with SingleTickerProviderStateMixin{
//  late AnimationController numberAnimation ;
//  late Animation<num> balance;
//   @override
//   void initState() {

//     super.initState();
//     numberAnimation = AnimationController(vsync: this,duration: 3.seconds)
//       ..forward()
//       ..addListener(() {
//         if(numberAnimation.isCompleted) {
//           // numberAnimation.repeat();
//         }
//         });
//     balance = Tween<num>(begin: 0,end: 5000,).animate(numberAnimation);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: AnimatedBuilder(
//           animation: numberAnimation,
//           builder: (_,value){
//             return Text(balance.value.toStringAsFixed(2));
//           },
//         ),
//       ),
//     );
//   }
// }
//

// class MainApp extends StatefulWidget {
//   const MainApp({super.key});
//
//   @override
//   State<MainApp> createState() => _MainAppState();
// }
//
// class _MainAppState extends State<MainApp> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         // Box decoration takes a gradient
//         gradient: LinearGradient(
//           // Where the linear gradient begins and ends
//           begin: Alignment.centerLeft,
//           end: Alignment(-1, 0.25),
//           stops: [0.0,0.5,0.5,1.0],
//           tileMode: TileMode.repeated,
//           colors: [
//             Colors.green,
//             Colors.green,
//             Colors.greenAccent,
//             Colors.greenAccent,
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'dart:async';
//
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 10;
//
//
//   Timer? _timer;
//
//
//   void startTimer() {
//     const oneSec = const Duration(seconds: 1);
//     _timer = new Timer.periodic(
//       oneSec,
//           (Timer timer) {
//         if (_counter == 0) {
//           AudioPlayer().play(AssetSource('Sounds/large-underwater-explosion.mp3'));
//           setState(() {
//             timer.cancel();
//             _counter = 10;
//           });
//         } else {
//           setState(() {
//             _decrementCounter();
//           });
//           AudioPlayer().play(AssetSource('Sounds/clock-close-1-tick.mp3'));
//         }
//       },
//     );
//   }
//   void _decrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter--;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//           startTimer();
//           //AudioPlayer().play(AssetSource('Sounds/large-underwater-explosion-190270.mp3'));
//            //AudioPlayer().play(AssetSource('Sounds/ui-click-97915.mp3'));
//         },
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }






//import 'package:flutter/material.dart';
/*class CrapsTablePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.transparent;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Background color
    //paint.color = Colors.black;
    paint.style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Line color golden
    paint.color = Colors.amberAccent;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;

    final double columnWidth = size.width / 10;
    const double rowHeight = 50;
    const double firstRowHeight = 70; // Increased height for the first row

    // First row: Don't Pass Bar, Don't Come Bar and Numbers 4, 5, 6, 8, 9, 10
   *//* final firstRow = [
      _Section(const Offset(0, 0), Offset(columnWidth * 2, firstRowHeight), "Don't Pass Bar",),
      _Section(Offset(columnWidth * 2, 0), Offset(columnWidth * 4, firstRowHeight), "Don't\nCome\nBar"),
      _Section(Offset(columnWidth * 4, 0), Offset(columnWidth * 5, firstRowHeight), "4"),
      _Section(Offset(columnWidth * 5, 0), Offset(columnWidth * 6, firstRowHeight), "5"),
      _Section(Offset(columnWidth * 6, 0), Offset(columnWidth * 7, firstRowHeight), "SIX"),
      _Section(Offset(columnWidth * 7, 0), Offset(columnWidth * 8, firstRowHeight), "8"),
      _Section(Offset(columnWidth * 8, 0), Offset(columnWidth * 9, firstRowHeight), "NINE"),
      _Section(Offset(columnWidth * 9, 0), Offset(columnWidth * 10, firstRowHeight), "10"),
    ];*//*

    final firstRow = [
      _Section(
        const Offset(0, 0),
        Offset(columnWidth * 2, firstRowHeight),
        "Don't Pass Bar",
        onTap: () {
          debugPrint("Don't Pass Bar tapped");
        },
      ),
      _Section(
        Offset(columnWidth * 2, 0),
        Offset(columnWidth * 4, firstRowHeight),
        "Don't\nCome\nBar",
        onTap: () {
          print("Don't Come Bar tapped");
        },
      ),
      _Section(
        Offset(columnWidth * 4, 0),
        Offset(columnWidth * 5, firstRowHeight),
        "4",
        onTap: () {
          print("Number 4 tapped");
        },
      ),
      _Section(
        Offset(columnWidth * 5, 0),
        Offset(columnWidth * 6, firstRowHeight),
        "5",
        onTap: () {
          print("Number 5 tapped");
        },
      ),
      _Section(
        Offset(columnWidth * 6, 0),
        Offset(columnWidth * 7, firstRowHeight),
        "SIX",
        onTap: () {
          print("Number 6 tapped");
        },
      ),
      _Section(
        Offset(columnWidth * 7, 0),
        Offset(columnWidth * 8, firstRowHeight),
        "8",
        onTap: () {
          print("Number 8 tapped");
        },
      ),
      _Section(
        Offset(columnWidth * 8, 0),
        Offset(columnWidth * 9, firstRowHeight),
        "NINE",
        onTap: () {
          print("Number 9 tapped");
        },
      ),
      _Section(
        Offset(columnWidth * 9, 0),
        Offset(columnWidth * 10, firstRowHeight),
        "10",
        onTap: () {
          print("Number 10 tapped");
        },
      ),
    ];

    // Second row: Come
    final secondRow = [
      _Section(const Offset(0, firstRowHeight), Offset(columnWidth * 7, firstRowHeight + rowHeight), "Come", textColor: Colors.red,),
    ];

    // Third row: Numbers 2 and 12 in a card, other numbers with space and "Field" text
    final double cardWidth = columnWidth / 3;
    final thirdRow = [
      _Section(
          Offset(columnWidth * 0.25, firstRowHeight + rowHeight + 10),
          Offset(columnWidth * 0.25 + cardWidth, firstRowHeight + rowHeight + cardWidth + 10),
          "2",
          textColor: Colors.white,
          //backgroundColor: Colors.blueGrey,
          borderColor: Colors.amberAccent,
          borderRadius: 100),
      _Section(
          Offset(columnWidth * 1, firstRowHeight + rowHeight),
          Offset(columnWidth * 6, firstRowHeight + rowHeight * 2),
          "3           4            9           10          11\n                           FIELD",
          textColor: Colors.white),
      _Section(
          Offset(columnWidth * 6.75 - cardWidth, firstRowHeight + rowHeight + 10),
          Offset(columnWidth * 6.75, firstRowHeight + rowHeight + cardWidth + 10),
          "12",

          textColor: Colors.white,
          //backgroundColor: Colors.blueGrey,
          borderColor: Colors.amberAccent,
          borderRadius: 50),



    ];

    // Fourth row: Don't Pass Bar
    final fourthRow = [
      _Section(const Offset(0, firstRowHeight + rowHeight * 2), Offset(columnWidth * 7, firstRowHeight + rowHeight * 3), "Don't Pass Bar"),
    ];

    // Fifth row: Pass Line
    final fifthRow = [
      _Section(const Offset(0, firstRowHeight + rowHeight * 3), Offset(columnWidth * 7, firstRowHeight + rowHeight * 4), "Pass Line"),
    ];

    final allSections = [
      ...firstRow,
      ...secondRow,
      ...thirdRow,
      ...fourthRow,
      ...fifthRow,
    ];

    for (var section in allSections) {
      drawSection(canvas, section.rect, section.label, section.textColor, section.backgroundColor, section.borderColor, section.borderRadius,);
    }
  }

  void drawSection(Canvas canvas, Rect rect, String text, [Color textColor = Colors.white, Color? backgroundColor, Color? borderColor, double? borderRadius]) {
    final paint = Paint()
      ..color = Colors.amberAccent // Line color golden
      ..style = PaintingStyle.stroke;
    final textPainter = TextPainter(

      text: TextSpan(
        text: text,
        style: TextStyle(
          color: textColor,
          fontSize: 16, // Increase the font size
          fontWeight: FontWeight.bold, // Make the text bold
        ),
      ),

      textDirection: TextDirection.ltr,
    )..layout(maxWidth: rect.width);

    // Draw background if specified
    if (backgroundColor != null) {
      final backgroundPaint = Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.fill;
      canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(borderRadius ?? 20)), backgroundPaint);
    }

    // Draw border if specified
    if (borderColor != null) {
      final borderPaint = Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(borderRadius ?? 20)), borderPaint);
    }

    // Draw border
    if (borderRadius != null) {
      canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(borderRadius)), paint);
    } else {
      canvas.drawRect(rect, paint);
    }

    // Draw text
    textPainter.paint(
      canvas,
      Offset(rect.left + (rect.width - textPainter.width) / 2,
          rect.top + (rect.height - textPainter.height) / 2),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _Section {
  final Offset topLeft;
  final Offset bottomRight;
  final String label;
  final Color textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final Function()? onTap;

  _Section(this.topLeft, this.bottomRight, this.label, {this.textColor = Colors.white, this.backgroundColor, this.borderColor, this.borderRadius,this.onTap});

  Rect get rect => Rect.fromPoints(topLeft, bottomRight);
}*/




/*import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CrapsTablePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.green[700]!;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width*0.5, size.height*0.5), paint);

    // Golden border color
    paint.color = Colors.amberAccent;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;

    // Column and row dimensions
    final double columnWidth = size.width / 7;
    final double rowHeight = 70;

    // Sections of the craps table
    final sections = [
      _Section(Offset(0, 0), Offset(columnWidth * 7, rowHeight), "Don't Pass Bar", textColor: Colors.white),
      _Section(Offset(0, rowHeight), Offset(columnWidth * 7, rowHeight * 2), "Don't Come Bar", textColor: Colors.white),
      _Section(Offset(0, rowHeight * 2), Offset(columnWidth * 7, rowHeight * 3), "Come", textColor: Colors.red),
      _Section(Offset(0, rowHeight * 3), Offset(columnWidth * 7, rowHeight * 4), "Field", textColor: Colors.white),
      _Section(Offset(0, rowHeight * 4), Offset(columnWidth * 7, rowHeight * 5), "Don't Pass Bar", textColor: Colors.white),
      _Section(Offset(0, rowHeight * 5), Offset(columnWidth * 7, rowHeight * 6), "Pass Line", textColor: Colors.white),
    ];

    // Drawing sections
    for (var section in sections) {
      drawSection(canvas, section.rect, section.label, section.textColor, size: size);
    }

    // Drawing numbers
    final numbers = [
      "4", "5", "6", "8", "9", "10"
    ];

    for (int i = 0; i < numbers.length; i++) {
      final rect = Rect.fromLTWH(columnWidth * (i + 1), 0, columnWidth, rowHeight);
      drawSection(canvas, rect, numbers[i], Colors.white);
    }

    // Drawing small numbers inside Field section
    final smallNumbers = ["2", "3", "4", "9", "10", "11", "12"];
    for (int i = 0; i < smallNumbers.length; i++) {
      final rect = Rect.fromLTWH(columnWidth * (i + 0.5), rowHeight * 3 + 10, columnWidth * 0.5, rowHeight - 20);
      drawSection(canvas, rect, smallNumbers[i], Colors.white, backgroundColor: Colors.blueGrey, borderRadius: 20);
    }
  }

  void drawSection(Canvas canvas, Rect rect, String text, Color textColor, {Color? backgroundColor, double borderRadius = 0,Size? size}) {
    final paint = Paint()
      ..color = Colors.amberAccent // Line color golden
      ..style = PaintingStyle.stroke;

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: rect.width);

    // Draw background if specified
    if (backgroundColor != null) {
      final backgroundPaint = Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.fill;
      canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(borderRadius)), backgroundPaint);
    }

    // Draw border
    if (borderRadius > 0) {
      // canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(borderRadius)), paint);
    } else {
      // canvas.drawRect(rect, paint);
      if(size != null){
        canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
      }

    }

    // Draw text
    textPainter.paint(
      canvas,
      Offset(rect.left + (rect.width - textPainter.width) / 2, rect.top + (rect.height - textPainter.height) / 2),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;


class _Section {
  final Offset topLeft;
  final Offset bottomRight;
  final String label;
  final Color textColor;

  _Section(this.topLeft, this.bottomRight, this.label, {this.textColor = Colors.white});

  Rect get rect => Rect.fromPoints(topLeft, bottomRight);
}
}
 */

// class CrapsTable extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       behavior: HitTestBehavior.opaque,
//       onTapUp: (details) {
//         final RenderBox renderBox = context.findRenderObject() as RenderBox;
//         final Offset localPosition = renderBox.globalToLocal(details.globalPosition);
//
//         for (var section in allSections) {
//           if (section.rect.contains(localPosition) && section.onTap != null) {
//             section.onTap!();
//             break;
//           }
//         }
//       },
//       child: CustomPaint(
//         size: Size(double.infinity, 300),
//         painter: CrapsTablePainter(),
//       ),
//     );
//   }
//
//   static final double columnWidth = 100.0;
//   static const double rowHeight = 50;
//   static const double firstRowHeight = 70;
//
//   static final firstRow = [
//     _Section(
//       const Offset(0, 0),
//       Offset(columnWidth * 2, firstRowHeight),
//       "Don't Pass Bar",
//       onTap: () {
//         print("Don't Pass Bar tapped");
//       },
//     ),
//     _Section(
//       Offset(columnWidth * 2, 0),
//       Offset(columnWidth * 4, firstRowHeight),
//       "Don't\nCome\nBar",
//       onTap: () {
//         print("Don't Come Bar tapped");
//       },
//     ),
//     _Section(
//       Offset(columnWidth * 4, 0),
//       Offset(columnWidth * 5, firstRowHeight),
//       "4",
//       onTap: () {
//         print("Number 4 tapped");
//       },
//     ),
//     _Section(
//       Offset(columnWidth * 5, 0),
//       Offset(columnWidth * 6, firstRowHeight),
//       "5",
//       onTap: () {
//         print("Number 5 tapped");
//       },
//     ),
//     _Section(
//       Offset(columnWidth * 6, 0),
//       Offset(columnWidth * 7, firstRowHeight),
//       "SIX",
//       onTap: () {
//         print("Number 6 tapped");
//       },
//     ),
//     _Section(
//       Offset(columnWidth * 7, 0),
//       Offset(columnWidth * 8, firstRowHeight),
//       "8",
//       onTap: () {
//         print("Number 8 tapped");
//       },
//     ),
//     _Section(
//       Offset(columnWidth * 8, 0),
//       Offset(columnWidth * 9, firstRowHeight),
//       "NINE",
//       onTap: () {
//         print("Number 9 tapped");
//       },
//     ),
//     _Section(
//       Offset(columnWidth * 9, 0),
//       Offset(columnWidth * 10, firstRowHeight),
//       "10",
//       onTap: () {
//         print("Number 10 tapped");
//       },
//     ),
//   ];
//
//   static final secondRow = [
//     _Section(
//       const Offset(0, firstRowHeight),
//       Offset(columnWidth * 7, firstRowHeight + rowHeight),
//       "Come",
//       textColor: Colors.red,
//     ),
//   ];
//
//   static final double cardWidth = columnWidth / 3;
//   static final thirdRow = [
//     _Section(
//       Offset(columnWidth * 0.25, firstRowHeight + rowHeight + 10),
//       Offset(columnWidth * 0.25 + cardWidth, firstRowHeight + rowHeight + cardWidth + 10),
//       "2",
//       textColor: Colors.white,
//       borderColor: Colors.amberAccent,
//       borderRadius: 100,
//     ),
//     _Section(
//       Offset(columnWidth * 1, firstRowHeight + rowHeight),
//       Offset(columnWidth * 6, firstRowHeight + rowHeight * 2),
//       "3           4            9           10          11\n                           FIELD",
//       textColor: Colors.white,
//     ),
//     _Section(
//       Offset(columnWidth * 6.75 - cardWidth, firstRowHeight + rowHeight + 10),
//       Offset(columnWidth * 6.75, firstRowHeight + rowHeight + cardWidth + 10),
//       "12",
//       textColor: Colors.white,
//       borderColor: Colors.amberAccent,
//       borderRadius: 50,
//     ),
//   ];
//
//   static final fourthRow = [
//     _Section(
//       const Offset(0, firstRowHeight + rowHeight * 2),
//       Offset(columnWidth * 7, firstRowHeight + rowHeight * 3),
//       "Don't Pass Bar",
//     ),
//   ];
//
//   static final fifthRow = [
//     _Section(
//       const Offset(0, firstRowHeight + rowHeight * 3),
//       Offset(columnWidth * 7, firstRowHeight + rowHeight * 4),
//       "Pass Line",
//     ),
//   ];
//
//   static final allSections = [
//     ...firstRow,
//     ...secondRow,
//     ...thirdRow,
//     ...fourthRow,
//     ...fifthRow,
//   ];
// }
//
// class CrapsTablePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = Colors.transparent;
//     canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
//
//     paint.style = PaintingStyle.fill;
//     canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
//
//     paint.color = Colors.amberAccent;
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 2;
//
//     for (var section in CrapsTable.allSections) {
//       drawSection(
//         canvas,
//         section.rect,
//         section.label,
//         section.textColor,
//         section.backgroundColor,
//         section.borderColor,
//         section.borderRadius,
//       );
//     }
//   }
//
//   void drawSection(Canvas canvas, Rect rect, String text,
//       [Color textColor = Colors.white, Color? backgroundColor, Color? borderColor, double? borderRadius]) {
//     final paint = Paint()
//       ..color = Colors.amberAccent
//       ..style = PaintingStyle.stroke;
//     final textPainter = TextPainter(
//       text: TextSpan(
//         text: text,
//         style: TextStyle(
//           color: textColor,
//           fontSize: 16,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       textDirection: TextDirection.ltr,
//     )..layout(maxWidth: rect.width);
//
//     if (backgroundColor != null) {
//       final backgroundPaint = Paint()
//         ..color = backgroundColor
//         ..style = PaintingStyle.fill;
//       canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(borderRadius ?? 20)), backgroundPaint);
//     }
//
//     if (borderColor != null) {
//       final borderPaint = Paint()
//         ..color = borderColor
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 2;
//       canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(borderRadius ?? 20)), borderPaint);
//     }
//
//     if (borderRadius != null) {
//       canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(borderRadius)), paint);
//     } else {
//       canvas.drawRect(rect, paint);
//     }
//
//     textPainter.paint(
//       canvas,
//       Offset(rect.left + (rect.width - textPainter.width) / 2,
//           rect.top + (rect.height - textPainter.height) / 2),
//     );
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
//
// class _Section {
//   final Offset topLeft;
//   final Offset bottomRight;
//   final String label;
//   final Color textColor;
//   final Color? backgroundColor;
//   final Color? borderColor;
//   final double? borderRadius;
//   final Function()? onTap;
//
//   _Section(
//       this.topLeft,
//       this.bottomRight,
//       this.label, {
//         this.textColor = Colors.white,
//         this.backgroundColor,
//         this.borderColor,
//         this.borderRadius,
//         this.onTap,
//       });
//
//   Rect get rect => Rect.fromPoints(topLeft, bottomRight);
// }


