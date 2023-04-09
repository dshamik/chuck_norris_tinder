import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              Text(
                "no-connection".i18n(),
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade,
                style: const TextStyle(fontSize: 20),
              ),
              const Spacer(),
              const CircularProgressIndicator(),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}