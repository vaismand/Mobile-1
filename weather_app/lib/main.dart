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
          primary: Color(0xFF66fcf1),
          secondary: Color(0xFF0a2b2b),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF66fcf1),
          foregroundColor: Color(0xFF0a2b2b),
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

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;
  static const List<String> _pageTitles = ['Currently', 'Today', 'Weekly'];

  void _onPageChanged(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String currentPageTitle = _pageTitles[_page];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          currentPageTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _page,
        onTap: _onPageChanged,
      ),
    );
  }
}
