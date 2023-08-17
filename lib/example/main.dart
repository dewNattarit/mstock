import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mstock/constance/constance.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'mStock',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _filePath = "";
  String _cellValue = "";

  Future<void> _selectFile() async {
    final prefs = await SharedPreferences.getInstance();
    debugPrint('_selectFile:${prefs.getString(Preferences.stockBalance)}');
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );
    if (prefs.getString(Preferences.stockBalance) != null) {
      setState(() {
        _filePath = prefs.getString(Preferences.stockBalance)!;
      });
    }

    if (result != null) {
      prefs.setString(Preferences.stockBalance, result.files.single.path!);
      setState(() {
        _filePath = result.files.single.path!;
      });
    }
  }

  Future<void> _readExcelCell() async {
    debugPrint('test');

    var bytes = File(_filePath).readAsBytesSync();
    var decoder = SpreadsheetDecoder.decodeBytes(bytes, update: true);
    var table = decoder.tables.values.first;
    var values = table.rows[3];

    debugPrint('rows length ==> ${table.rows.length}');
    debugPrint('cell value ==> ${table.rows[3][0]}');
    setState(() {
      _cellValue = '${values[0]}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('mStock'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              onPressed: _selectFile,
              child: const Text('Select File'),
            ),
            const SizedBox(height: 16.0),
            if (_filePath != null)
              Text(
                'File Name: ${basename(_filePath)}',
                style: const TextStyle(fontSize: 16.0),
              ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _readExcelCell,
              child: const Text('Read Excel'),
            ),
            const SizedBox(height: 16.0),
            if (_cellValue != null)
              Text(
                'Cell Value: $_cellValue',
                style: const TextStyle(fontSize: 16.0),
              ),
            ElevatedButton(
              child: const Text('Predric Stock'),
              onPressed: () => _copyToNewFile(context),
            )
          ],
        ),
      ),
    );
  }

  void _copyToNewFile(BuildContext context) async {
    // Create a new Excel file and add a worksheet
    Excel excel = Excel.createExcel();
    Sheet sheet = excel['Sheet1'];

    // Set the value of cell A4 to the selected value
    sheet.cell(CellIndex.indexByString('A4')).value = _cellValue;

    String fileName = 'new_file.xlsx';
    final savePath = await FilePicker.platform.getDirectoryPath();

    var filePath = '$savePath/$fileName';

    //stopwatch.reset();
    List<int>? fileBytes = excel.save();
    // Save the Excel file to the local storage
    if (fileBytes != null) {
      File(join(filePath))
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes);
    }

    // Show a dialog with the file path
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('File Saved'),
          content: Text('The new file has been saved to:\n\n$savePath'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
