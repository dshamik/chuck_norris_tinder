import 'package:chuck_norris_tinder/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization/localization.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("favorites-title".i18n()),
        ),
        body: StreamBuilder(
          stream: ref.read(fireStoreProvider).get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("error-occurred".i18n());
            } else if (snapshot.hasData) {
              final jokes = snapshot.data!;
              return SizedBox(
                height: double.infinity,
                child: ListView.separated(
                  padding: const EdgeInsets.only(top: 12),
                  shrinkWrap: true,
                  itemCount: jokes.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: kElevationToShadow[4],
                          ),
                          width: MediaQuery.of(context).size.width - 32,
                          child: Text(
                            jokes[index].value,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 12,
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
