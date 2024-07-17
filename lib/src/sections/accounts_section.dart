import 'package:custom_widgets/widgets/accounts_card_widget.dart';
import 'package:custom_widgets/widgets/currency_pair.dart';
import 'package:flutter/material.dart';

class AccountsSection extends StatefulWidget {
  const AccountsSection({super.key});

  @override
  State<StatefulWidget> createState() => _AccountsSection();
}

class _AccountsSection extends State<AccountsSection> {
  CardProfleData depositsProfile = CardProfleData(
    count: 1,
    currency: Currency.sgd,
    amount: 2880000,
  );
  CardProfleData cardsProfile = CardProfleData(
    count: 2,
    currency: Currency.sgd,
    amount: 3200,
  );
  CardProfleData cashlineProfile = CardProfleData(
    count: 5,
    currency: Currency.sgd,
    amount: 40000,
  );

  bool mark = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AppBar(
        iconTheme: const IconThemeData(color: Colors.grey),
        title: const Row(
          children: [
            Text(
              'Top 3 accounts',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
        primary: false,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        actions: [
          GestureDetector(
            child: Icon(mark ? Icons.link_off : Icons.remove_red_eye_outlined),
            onTap: () => setState(() {
              mark = !mark;
            }),
          ),
          const Icon(Icons.more_vert)
        ],
      ),
      AccountsCardWidget(
        leadingColor: Colors.amber,
        title: "Deposits",
        count: depositsProfile.count,
        label: "Total available balance",
        currency: depositsProfile.currency,
        amount: mark ? "***" : depositsProfile.amount.toStringAsFixed(2),
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          Expanded(
            child: AccountsCardWidget(
              leadingColor: Colors.redAccent,
              title: "Cards",
              count: cardsProfile.count,
              label: "Bills due on 17 Jan",
              currency: cardsProfile.currency,
              amount: mark ? "***" : cardsProfile.amount.toStringAsFixed(2),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: AccountsCardWidget(
              leadingColor: Colors.purple,
              title: "Cashline",
              count: cashlineProfile.count,
              label: "Total outstanding",
              currency: cashlineProfile.currency,
              amount: mark ? "***" : cashlineProfile.amount.toStringAsFixed(2),
            ),
          )
        ],
      ),
      Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: const Text("All accounts >",
              style: TextStyle(color: Colors.black54)))
    ]);
  }
}

class CardProfleData {
  final int count;
  final Currency currency;
  final double amount;

  CardProfleData({
    required this.count,
    required this.currency,
    required this.amount,
  });
}
