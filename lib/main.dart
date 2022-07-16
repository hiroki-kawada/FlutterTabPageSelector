import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  static const _colors = [
    Colors.red,
    Colors.amber,
    Colors.yellow,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.purple,
    Colors.pink,
  ];
  int _index = 0;
  late TabController _controller;

  void _nextDot() {
    // if circulate dots
    //(_index != _colors.length - 1) ? _index++ : _index = 0;
    if (_index != _colors.length - 1) {
      _index++;
    }
    _controller.animateTo(_index);
    setState(() {});
  }

  void _nextDotReverse() {
    if (_index > 0) {
      _index--;
    }
    _controller.animateTo(_index);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 7,
      initialIndex: _index,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(color: _colors[_controller.index]),
          Positioned(
            bottom: 20,
            child: TabPageSelector(
              controller: _controller,
              color: Colors.black38,
              selectedColor:_colors[_controller.index],
            ),
          )
        ],
      ),
      floatingActionButton: ButtonBar(
        children: [
          CustomFab(icon: Icons.navigate_before, onPressed: _nextDotReverse),
          CustomFab(icon: Icons.navigate_next, onPressed: _nextDot)
        ],
      ),
    );
  }
}

class CustomFab extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const CustomFab({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      onPressed: onPressed,
      child: Icon(icon),
      backgroundColor: Colors.black26,
      elevation: 0,
      hoverElevation: 0,
    );
  }
}
