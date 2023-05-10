import 'package:flutter/material.dart';
import 'csv_loader.dart';
import 'single_choice_page.dart';
import 'multi_choice_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "西柚题库",
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<dynamic>>? singleChoiceData;
  List<List<dynamic>>? multiChoiceData;
  String searchText = '';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
    searchController.addListener(() {
      setState(() {
        searchText = searchController.text;
      });
    });
  }

  Future<void> _loadData() async {
    CsvLoader loader = CsvLoader();
    singleChoiceData = await loader.loadCsv('assets/converted.csv');
    multiChoiceData = await loader.loadCsv('assets/multi_converted.csv');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("西南石油大学校规校纪题库"),
          actions: [
            IconButton(
              icon: Icon(theme.brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode),
              onPressed: () {
                ThemeMode mode = theme.brightness == Brightness.dark
                    ? ThemeMode.light
                    : ThemeMode.dark;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MaterialApp(
                      title: "西柚题库",
                      theme: ThemeData.light(),
                      darkTheme: ThemeData.dark(),
                      themeMode: mode,
                      home: const MyHomePage(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      labelColor: theme.colorScheme.secondary,
                      unselectedLabelColor: theme.brightness == Brightness.dark
                          ? Colors.white70
                          : Colors.black87,
                      tabs: const [
                        Tab(text: '单选题'),
                        Tab(text: '多选题'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          SingleChoicePage(
                              data: singleChoiceData, searchText: searchText),
                          MultiChoicePage(
                              data: multiChoiceData, searchText: searchText),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: '搜索',
                  contentPadding: const EdgeInsets.all(8.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        searchController.text = '';
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}