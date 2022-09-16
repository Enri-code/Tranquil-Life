import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';
import 'package:tranquil_life/features/wallet/domain/entities/transaction.dart';

class TransactionsSheet extends StatelessWidget {
  const TransactionsSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.only(left: 24),
              child: Text(
                'Transactions',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  child: MyDefaultTextStyle(
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.green[800],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        8,
                        (i) => TransactionCard(Transaction(
                          date: '01-08-2022',
                          refId: 'DX657THZ',
                          price: '\$10,000',
                        )),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard(this.data, {Key? key}) : super(key: key);
  final Transaction data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(blurRadius: 2, color: Colors.black12, offset: Offset(0, 2))
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const Text('Top-Up'), Text(data.price)],
          ),
          const Spacer(),
          MyDefaultTextStyle(
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.grey[800]!,
              fontSize: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text('Reference ID'), Text('Date')],
            ),
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(data.refId),
                  Padding(
                    padding: const EdgeInsets.only(left: 6, bottom: 2),
                    child: GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: data.refId));
                      },
                      child: const Icon(Icons.content_copy, size: 16),
                    ),
                  ),
                ],
              ),
              Text(data.date),
            ],
          ),
        ],
      ),
    );
  }
}
