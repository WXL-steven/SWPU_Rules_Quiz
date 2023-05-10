import 'package:flutter/material.dart';

class DetailDialog extends StatelessWidget {
  final String question;
  final List<String> answers;

  const DetailDialog({Key? key, required this.question, required this.answers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 过滤掉空值
    List<String> filteredAnswers = answers.where((answer) => answer.isNotEmpty).toList();

    // 根据主题亮度设置文本和背景颜色
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final boxColor = isDarkMode ? Colors.grey.shade700 : Colors.grey.shade100;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return AlertDialog(
      title: const Text('详情'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              question,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 16),
            ...filteredAnswers.map((answer) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: detailBox(answer, boxColor, textColor),
            )).toList(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('关闭'),
        ),
      ],
    );
  }

  // 自定义函数用于创建包含答案的框
  Widget detailBox(String text, Color boxColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}