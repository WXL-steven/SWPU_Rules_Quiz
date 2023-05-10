import 'package:flutter/material.dart';
import 'detail_dialog.dart';

class MultiChoicePage extends StatefulWidget {
  final List<List<dynamic>>? data;
  final String? searchText;

  const MultiChoicePage({Key? key, required this.data, this.searchText}) : super(key: key);

  @override
  _MultiChoicePageState createState() => _MultiChoicePageState();
}

class _MultiChoicePageState extends State<MultiChoicePage> {
  List<List<dynamic>> _filterData(List<List<dynamic>> data, String? searchText) {
    if (searchText == null || searchText.isEmpty) {
      return data;
    }

    List<String> searchKeywords = searchText.split(' ');
    return data.where((element) {
      String questionText = element[0].toLowerCase();
      return searchKeywords
          .every((keyword) => questionText.contains(keyword.toLowerCase()));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data == null) {
      return const Center(child: CircularProgressIndicator());
    }

    List<List<dynamic>> filteredData = _filterData(widget.data!, widget.searchText);

    return filteredData.isEmpty
        ? const Center(child: Text('无结果'))
        : ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DetailDialog(
                    question: filteredData[index][0],
                    answers: List<String>.from(
                        filteredData[index].sublist(1).where((element) => element.isNotEmpty)),
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    filteredData[index][0],
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 8),
                  ...List<String>.from(filteredData[index].sublist(1).where((element) => element.isNotEmpty))
                      .asMap()
                      .entries
                      .map(
                        (entry) => Text(
                      '${entry.key + 1}. ${entry.value}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                  )
                      .toList(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}