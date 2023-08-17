import 'package:mstock/model/stock_date.dart';

class Header {
  final String productId;
  final String name;
  final String sku;
  final List<String> platfroms;
  final StockDate stockDate;

  Header(this.productId, this.name, this.sku, this.platfroms, this.stockDate);
}
