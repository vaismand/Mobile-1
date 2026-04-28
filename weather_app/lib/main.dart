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
      debugShowCheckedModeBanner: false,
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
  late final TextEditingController _searchController;
  String _searchQuery = '';
  bool _useGeolocation = false;
  void _onPageChanged(int index) {
    _tabController.animateTo(index);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _searchController = TextEditingController();
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
    _searchController.dispose();
    super.dispose();
  }

  String _tabText(int index) {
    const tabNames = ['Currently', 'Today', 'Weekly'];
    final title = tabNames[index];
    if (_useGeolocation) return '$title \nGeolocation';
    if (_searchQuery.isNotEmpty) return '$title \n$_searchQuery';
    return title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search for a city',
            contentPadding: EdgeInsets.only(top: 12),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.white),
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value.trim();
              _useGeolocation = false;
            });
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {
              setState(() {
                _useGeolocation = true;
                _searchQuery = '';
                _searchController.clear();
              });
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Text(
              _tabText(0),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          Center(
            child: Text(
              _tabText(1),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          Center(
            child: Text(
              _tabText(2),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey[900],
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        child: TabBar(
          controller: _tabController,
          onTap: _onPageChanged,
          labelColor: Colors.cyanAccent,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.transparent,
          tabs: const [
            Tab(icon: Icon(Icons.sunny), text: 'Currently'),
            Tab(icon: Icon(Icons.today), text: 'Today'),
            Tab(icon: Icon(Icons.calendar_view_week), text: 'Weekly'),
          ],
        ),
      ),
    );
  }
}
