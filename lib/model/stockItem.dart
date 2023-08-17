import 'package:mstock/model/sale.dart';
import 'package:mstock/model/stock_date.dart';

class StockItem {
  final String productId;
  final String name;
  final String sku;
  final String quantity;
  final Map<String, Sale> sales;
  final StockDate? stockDate;

  StockItem(this.productId, this.name, this.sku, this.sales, this.stockDate,
      this.quantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockItem &&
          runtimeType == other.runtimeType &&
          sku == other.sku;

  @override
  int get hashCode => sku.hashCode;
}
