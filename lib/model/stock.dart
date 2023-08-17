import 'package:mstock/model/stockItem.dart';

class Stock {
  final List<StockItem> items;
  final List<String> platforms;
  final String? stockPath;
  final String? fileOrderPath;
  Stock(this.items, this.platforms, this.stockPath, this.fileOrderPath);
}
