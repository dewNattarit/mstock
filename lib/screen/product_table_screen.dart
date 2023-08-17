import 'package:flutter/material.dart';

import '../widget/add_file_widget.dart';

class ProductTable extends StatelessWidget {
  static const routeName = '/product_screen';
  static const screenName = "Home";
  const ProductTable({super.key});

  @override
  Widget build(BuildContext context) {
    List<List<String>> products = [
      [
        '1234923423023',
        'Product test for you today 672839-2340',
        '23450',
        '2023-01-01',
        '10',
        '20',
        '23',
        '56'
      ],
      [
        '0982349832432',
        'Another product for you tomorrow 239834-0294',
        '12345',
        '2023-02-15',
        '15',
        '18',
        '25',
        '42'
      ],
      [
        '8574920395845',
        'A third product for the weekend 938475-7385',
        '54321',
        '2023-03-05',
        '5',
        '10',
        '18',
        '32'
      ],
      [
        '6329847598234',
        'Product number four for the holiday 739485-3049',
        '34567',
        '2023-04-20',
        '20',
        '25',
        '28',
        '60'
      ],
      [
        '9345734820432',
        'Product five for the summer 293847-0987',
        '45678',
        '2023-05-10',
        '18',
        '22',
        '24',
        '50'
      ],
      [
        '1029384756093',
        'Sixth product for the season 485739-2938',
        '56789',
        '2023-06-01',
        '8',
        '12',
        '20',
        '45'
      ],
      [
        '8492039485023',
        'Product seven for the occasion 840293-8495',
        '67890',
        '2023-07-15',
        '25',
        '30',
        '35',
        '70'
      ],
      [
        '2834957930594',
        'Eighth product for the event 293840-3840',
        '78901',
        '2023-08-05',
        '12',
        '15',
        '22',
        '40'
      ],
      [
        '2394850934857',
        'Ninth product for the moment 583920-2384',
        '89012',
        '2023-09-01',
        '30',
        '35',
        '40',
        '80'
      ],
      [
        '5739820934850',
        'Tenth product for the celebration 384750-8395',
        '90123',
        '2023-10-10',
        '10',
        '18',
        '30',
        '65'
      ],
    ];

    const List<String> stock = [
      '2394850934857',
      'Ninth product for the moment 583920-2384',
      '89012',
      '2023-09-01',
      '30',
      '35',
      '40',
      '80',
      'Tenth product for the celebration 384750-8395Tenth product for the celebration 384750-8395Tenth product for the celebration 384750-8395Tenth product for the celebration 384750-8395Tenth product for the celebration 384750-8395',
      'Tenth product for the celebration 384750-8395',
      'Tenth product for the celebration 384750-8395',
      'Tenth product for the celebration 384750-8395',
      'Tenth product for the celebration 384750-8395',
      'Tenth product for the celebration 384750-8395',
      'Tenth product for the celebration 384750-8395',
      'Tenth product for the celebration 384750-8395',
      'Tenth product for the celebration 384750-8395',
      'Tenth product for the celebration 384750-8395',
      'Tenth product for the celebration 384750-8395',
      'Tenth product for the celebration 384750-8395',
      'Tenth product for the celebration 384750-8395',
    ];

    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Product Management'),
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
        body: ListView(
          children: [
            Row(
              children: const [
                AddFileWidget(title: "คลังสินค้า", path: null),
                AddFileWidget(title: "รายการสั่งซื้อ", path: null),
              ],
            ),
          ],
        ));
  }
}
