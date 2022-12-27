
import 'package:flutter/material.dart';


class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(13),
      itemBuilder: (BuildContext ctx, int index) {
          return const Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 50,
                child: Text(
                  "01\nDec",
                  textAlign: TextAlign.center,
                ),
              ),
              title: Text('₹200000'),
              subtitle: Text('Travel'),
            ),
          );
      },
      separatorBuilder: (BuildContext ctx, int intex) {
        return const SizedBox(
          height: 10,
        );
      },
      itemCount: 20,
    );
  }
}