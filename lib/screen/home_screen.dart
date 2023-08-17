import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mstock/provider/stock_provider.dart';
import 'package:provider/provider.dart';

import '../color/color.dart';
import '../widget/add_file_widget.dart';
import '../widget/table_widget.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';
  static const screenName = "Home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _pickStockFile(BuildContext context, StockProvider provider) async {
    print('_pickStockFile==> test');
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );
    if (result != null) {
      print('result==> ${result.files.single.path!}');
      provider.saveStockPath(result.files.single.path!);
    }
  }

  void _pickOrderFile(BuildContext context, StockProvider provider) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );
    if (result != null) {
      provider.saveOrderPath(result.files.single.path!);
    }
  }

  @override
  void initState() {
    super.initState();
    // final provider = Provider.of<StockProvider>(context, listen: false);
    // provider.checkFiles();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StockProvider>(context);

    final topicStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          color: ThemeColor.black,
          fontWeight: FontWeight.bold,
        );
    final titleLarge = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: ThemeColor.black,
          fontWeight: FontWeight.bold,
        );

    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
      backgroundColor: ThemeColor.white,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product Management', style: topicStyle),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.purple],
            ),
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const SizedBox(height: 4),
              SelectableText('Add File', style: titleLarge),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      _pickStockFile(context, provider);
                    },
                    child: AddFileWidget(
                      title: "คลังสินค้า",
                      path: provider.stock.stockPath,
                    ),
                  ),
                  const VerticalDivider(
                    color: ThemeColor.gray,
                    thickness: 1,
                  ),
                  InkWell(
                    onTap: () {
                      _pickOrderFile(context, provider);
                    },
                    child: AddFileWidget(
                      title: "คำสั่งซื้อ",
                      path: provider.stock.fileOrderPath,
                    ),
                  ),
                  const SizedBox(width: 2),
                  ElevatedButton(
                    style: style,
                    onPressed: () {
                      provider.checkFiles();
                    },
                    child: const Text('Check Files'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TableWidget(stock: provider.stock)
            ],
          )),
    );
  }
}
