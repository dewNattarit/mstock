import 'package:flutter/cupertino.dart';
import 'package:mstock/repository/stock_repository.dart';

import '../model/stock.dart';
import '../usecase/get_stock_usecase.dart';

class StockProvider with ChangeNotifier {
  final StockRepository stockRepository;
  final GetStockUseCase getStockUseCase;
  StockProvider(this.stockRepository, this.getStockUseCase);
  Stock _stock = Stock([], [], null, null);

  Stock get stock {
    return _stock;
  }

  Future<void> checkFiles() async {
    final stockPath = await stockRepository.getStockBalancPath();
    final orderPath = await stockRepository.getOrdersPath();
    debugPrint(stockPath);

    _stock = Stock([], [], stockPath, orderPath);
    notifyListeners();

    if (stockPath != null && orderPath != null) {
      getStocks(stockPath, orderPath);
    }
  }

  Future<void> getStocks(String stockPath, String orderPath) async {
    _stock = await getStockUseCase.execute(stockPath, orderPath);
    notifyListeners();
  }

  Future<void> saveStockPath(String path) async {
    await stockRepository.saveStockPath(path);
  }

  Future<void> saveOrderPath(String path) async {
    await stockRepository.saveOrdersPath(path);
  }
}
