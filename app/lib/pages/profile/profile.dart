import 'dart:math';

import 'package:app/config/theme.dart';
import 'package:app/extensions/datetime.dart';
import 'package:app/extensions/number.dart';
import 'package:flutter/material.dart';

const String currentUser = "123";

class ProfilePage extends StatelessWidget {
  final String userID;

  const ProfilePage({super.key, required this.userID});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = {
      "wallet_balance": 60342.50,
      "last_month": 3840.9,
      "transactions": List.generate(
        20,
        (_) => <String, dynamic>{
          "amount": 1000,
          "bet_id": "some-random-id",
          "description": "Placed this much on that bet",
          "placed_at": DateTime.now().subtract(
            Duration(
              days: Random().nextInt(10),
              minutes: Random().nextInt(10),
              hours: Random().nextInt(10),
              seconds: Random().nextInt(10),
            ),
          ),
        },
      ),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: context.colorScheme.onSurface),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Balance",
                        style: TextStyle(
                          fontSize: 20,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        "\$${(data["wallet_balance"] as num).formatWithCommas()}",
                        style: TextStyle(
                          fontSize: 60,
                          color: context.colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: SizedBox(
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/profile.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        height: 200,
                        child: Column(
                          children: [
                            Text(
                              "Referral Code",
                              style: TextStyle(
                                fontSize: 16,
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              "XijW8N",
                              style: TextStyle(
                                color: context.colorScheme.onSurface,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Divider(height: 16),
                            Text(
                              "Total in Last Month",
                              style: TextStyle(
                                fontSize: 16,
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              "\$${(data["last_month"] as num).formatWithCommas()}",
                              style: TextStyle(
                                color: context.colorScheme.onSurface,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                "Transaction History",
                style: TextStyle(
                  fontSize: 26,
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: data["transactions"].length,
                  itemBuilder: (context, index) {
                    final Map<String, dynamic> transaction =
                        data["transactions"][index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        shape: Border(
                          bottom: BorderSide(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        title: Text(transaction["description"]),
                        subtitle: Text(
                          "\$${(transaction["amount"] as num).formatWithCommas()}",
                        ),
                        trailing: Text(
                          (transaction["placed_at"] as DateTime)
                              .toReadableFormat(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
