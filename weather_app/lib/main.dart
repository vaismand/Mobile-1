import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0a2b2b),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF0a2b2b),
          secondary: Color(0xFF66fcf1),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0a2b2b),
          foregroundColor: Color(0xFF66fcf1),
        ),
      ),
      home: const MyHomePage(title: 'Weather App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _page = 0;
  late final TabController _tabController;

  void _onPageChanged(int index) {
    _tabController.animateTo(index);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_page != _tabController.index) {
        setState(() {
          _page = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: Text(widget.title)),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: Text('Currently Page', style: TextStyle(fontSize: 24))),
          Center(child: Text('Today Page', style: TextStyle(fontSize: 24))),
          Center(child: Text('Weekly Page', style: TextStyle(fontSize: 24))),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        onTap: _onPageChanged,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sunny),
            label: 'Currently',
            key: Key('currently'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: 'Today',
            key: Key('today'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_view_week),
            label: 'Weekly',
            key: Key('weekly'),
          ),
        ],
      ),
    );
  }
}
