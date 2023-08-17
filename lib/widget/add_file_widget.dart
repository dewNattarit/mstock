import 'package:flutter/material.dart';

import '../color/color.dart';

class AddFileWidget extends StatelessWidget {
  final String title;
  final String? path;
  const AddFileWidget({super.key, required this.title, required this.path});

  @override
  Widget build(BuildContext context) {
    var color = (path != null) ? ThemeColor.success : ThemeColor.secondary;
    final topicStyle =
        Theme.of(context).textTheme.titleMedium?.copyWith(color: color);
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Text(
            title,
            style: topicStyle,
          ),
        ),
        Visibility(
          visible: path != null,
          child: Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(
              "[${_getFileName(path ?? "")}]",
              style: topicStyle,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Image.asset(
            'assets/graphic/ic_link.png',
            fit: BoxFit.cover,
            color: color,
          ),
        ),
      ],
    );
  }

  String _getFileName(String filePath) {
    // Split the file path into segments using the directory separator "/"
    List<String> segments = filePath.split('/');

    // Get the last segment of the path, which should be the file name
    String fileName = segments.last;

    // Return the file name
    return fileName;
  }
}
