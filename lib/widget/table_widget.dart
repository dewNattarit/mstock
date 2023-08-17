import 'package:flutter/material.dart';
import 'package:mstock/color/color.dart';
import 'package:mstock/model/stock.dart';

import '../model/stockItem.dart';

class TableWidget extends StatelessWidget {
  final Stock stock;
  const TableWidget({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final headerTextStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: ThemeColor.black,
        );
    final dataTextStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
          color: ThemeColor.black,
        );
    List<DataColumn> collums = [];
    List<DataRow> rows = [];
    collums = _columns(stock);
    for (var item in stock.items) {
      rows.add(DataRow(cells: _cells(item, stock.platforms)));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          border: const TableBorder(
              top: BorderSide(color: ThemeColor.gray, width: 2.0),
              left: BorderSide(color: ThemeColor.gray, width: 2.0),
              right: BorderSide(color: ThemeColor.gray, width: 2.0),
              bottom: BorderSide(color: ThemeColor.gray, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(50)),
              horizontalInside: BorderSide(color: ThemeColor.gray, width: 2.0)),
          // border: TableBorder.all(
          //   borderRadius: const BorderRadius.all(Radius.circular(8)),
          //   width: 2.0,
          //   color: ThemeColor.gray,
          // ),
          headingTextStyle: headerTextStyle,
          dataTextStyle: dataTextStyle,
          columnSpacing: 20,
          columns: collums,
          rows: rows,
        ),
      ),
    );
  }

  List<DataColumn> _columns(Stock stock) {
    final List<DataColumn> dataColumns = [];
    dataColumns.add(_dataColum("ProductId"));
    dataColumns.add(_dataColum("SKU"));
    dataColumns.add(_dataColum("Product Name"));
    dataColumns.add(_dataColum("Stock"));

    return dataColumns;
  }

  DataColumn _dataColum(String title) {
    return DataColumn(
      label: Expanded(child: Text(title, textAlign: TextAlign.center)),
      numeric: false,
    );
  }

  List<DataCell> _cells(StockItem item, List<String> platfroms) {
    final List<DataCell> dataCells = [];
    dataCells.add(DataCell(Text(item.productId, textAlign: TextAlign.center)));
    dataCells
        .add(DataCell(SelectableText(item.sku, textAlign: TextAlign.center)));
    dataCells.add(DataCell(Text(item.name, textAlign: TextAlign.center)));
    dataCells.add(DataCell(Center(child: Text(item.quantity))));

    return dataCells;
  }
}
