import 'package:flutter/material.dart';
import 'package:mapping_out/palette/palette_editor.dart';
import 'package:provider/provider.dart';
import 'package:mapping_out/palette/palette.dart';
import 'package:mapping_out/map/map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: '여행 지도',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          canvasColor: Colors.transparent,
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Mapping Out'),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  // var palette = [
  //   Palette(id: 1, color: Color(0xff004080), legend: "좋아하는 여행지"),
  //   Palette(id: 2, color: Color(0xff228B22), legend: "또 가고 싶은 곳"),
  //   Palette(id: 3, color: Color(0xffDAA520), legend: "가족 여행 갔던 곳"),
  //   // Palette(color: Color(0xffF4A460), legend: "친구들이랑 갔던 곳"),
  // ];
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var palette = [
    Palette(order: 1, color: Color(0xff004080), legend: "좋아하는 여행지"),
    Palette(order: 2, color: Color(0xff228B22), legend: "또 가고 싶은 곳"),
    Palette(order: 3, color: Color(0xffDAA520), legend: "가족 여행 갔던 곳"),
    // Palette(color: Color(0xffF4A460), legend: "친구들이랑 갔던 곳"),
  ];
  final locations = [
    Location(x: 11, y: 0, name: '고성'),
    Location(x: 6, y: 1, name: '연천'),
    Location(x: 7, y: 1, name: '철원'),
    Location(x: 8, y: 1, name: '화천'),
    Location(x: 9, y: 1, name: '양구'),
    Location(x: 10, y: 1, name: '인제', height: 2),
    Location(x: 11, y: 1, name: '속초'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'MappingOut',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Expanded(child: SizedBox()),
                  IconButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return PaletteEditor(
                            palette: palette,
                            notifyPaletteChanged: (p) {
                              setState(() {
                                palette = p;
                              });
                            },
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.palette_outlined),
                  ),
                ],
              ),
            ),
            Expanded(child: MapContent(locations: locations)),
          ],
        ),
      ),
    );
  }
}
