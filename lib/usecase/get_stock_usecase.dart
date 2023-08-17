import 'package:mstock/constance/constance.dart';
import 'package:mstock/model/sale.dart';
import 'package:mstock/model/stock.dart';
import 'package:mstock/repository/stock_repository.dart';

import '../model/stockItem.dart';

mixin IGetStockUseCase {
  Future<Stock> execute(String stockPath, String orderPath);
}

class GetStockUseCase implements IGetStockUseCase {
  final StockRepository stockRepository;
  final List<String> _platforms = [];
  GetStockUseCase(this.stockRepository);

  @override
  Future<Stock> execute(String stockPath, String orderPath) async {
    print('stockPath ==> $stockPath');
    final itemList = await _mapDesciptionStockItems(stockPath);
    final items = await _mapStockItems(itemList, orderPath);
    print('items ==> ${items.length}');
    return Stock(items, _platforms, stockPath, orderPath);
  }

  Future<List<StockItem>> _mapStockItems(
      Map<String, StockItem> stocks, String orderPath) async {
    final orderTable =
        await stockRepository.getOrders(orderPath).then((value) => value);
    final orderRows = orderTable.rows;
    var orginalPlatform = "";

    for (var i = 1; i < orderRows.length; i++) {
      if (orderRows[i][StockConstance.orderSku] != null) {
        final sku = "${orderRows[i][StockConstance.orderSku]}";
        final platform = "${orderRows[i][StockConstance.platform]}";
        final quantityString =
            ("${orderRows[i][StockConstance.orderQuantity]}");
        final originalQty = stocks[sku]?.sales[platform]?.quantity ?? 0;
        final quantity = _quantityOrder(originalQty, quantityString);
        if (!platform.contains("null") && !platform.contains(" ")) {
          orginalPlatform = platform;
        }

        stocks[sku]?.sales[orginalPlatform] = Sale(orginalPlatform, quantity);
        print(
            '$sku  $orginalPlatform = ${stocks[sku]?.sales[orginalPlatform]?.quantity}');
      }

      if (!_platforms.contains(orginalPlatform)) {
        _platforms.add(orginalPlatform);
      }
    }
    return stocks.values.toList();
  }

  double _quantityOrder(double originalQty, String? qty) {
    final quantity = double.tryParse(qty?.replaceAll("null", "") ?? "") ?? 0.0;
    print('$quantity');
    final quantityOrder = quantity + originalQty;
    return quantityOrder;
  }

  Future<Map<String, StockItem>> _mapDesciptionStockItems(
      String stockPath) async {
    final stockTable =
        await stockRepository.getStockBalance(stockPath).then((value) => value);
    final stockRows = stockTable.rows;
    final Map<String, StockItem> stockItems = {};
    for (var i = 3; i < stockRows.length; i++) {
      if (stockRows[i][StockConstance.stockSku] != null) {
        final productId =
            ("${stockRows[i][StockConstance.productId]}").replaceAll(".0", "");
        final name = "${stockRows[i][StockConstance.name]}";
        final quantity = "${stockRows[i][StockConstance.stockQuantity]}";
        final sku = "${stockRows[i][StockConstance.stockSku]}";
        final item = StockItem(productId, name, sku, {}, null, quantity);
        stockItems[sku] = item;
      }
    }
    return stockItems;
  }
}
