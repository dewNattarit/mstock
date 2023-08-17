import 'package:get_it/get_it.dart';
import 'package:mstock/provider/stock_provider.dart';
import 'package:mstock/repository/stock_repository.dart';
import 'package:mstock/usecase/get_stock_usecase.dart';

final sl = GetIt.instance;
Future initLocator() async {
  //repository
  sl.registerLazySingleton<StockRepository>(() => StockRepository());
  sl.registerLazySingleton<GetStockUseCase>(() => GetStockUseCase(sl.get()));
  sl.registerLazySingleton<StockProvider>(
      () => StockProvider(sl.get(), sl.get()));
}
