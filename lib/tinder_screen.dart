import 'package:chuck_norris_tinder/api/models/chuck_norris.dart';
import 'package:chuck_norris_tinder/favorite_jokes.dart';
import 'package:chuck_norris_tinder/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization/localization.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:flutter/material.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  late MatchEngine _matchEngine;

  _MyHomePageState() {
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  @override
  void initState() {
    super.initState();
    createTinderCard();
    createTinderCard();
  }

  void createTinderCard() {
    var joke = ref.read(apiProvider).getData();
    _swipeItems.add(
      SwipeItem(
        content: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ref.read(imageProvider).getImage(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: FutureBuilder(
                    future: joke,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data!.value);
                      }
                      return Text("loading".i18n());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        likeAction: () => likeAction(joke),
        nopeAction: createTinderCard,
      ),
    );
  }

  void likeAction(Future<ChuckNorris> joke) {
    createTinderCard();
    ref.read(fireStoreProvider).save(joke);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text("main-title".i18n()),
              const SizedBox(width: 40),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return const FavoritesScreen();
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.favorite, color: Colors.white),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height - 300,
                  child: SwipeCards(
                      matchEngine: _matchEngine,
                      onStackFinished: createTinderCard,
                      itemBuilder: (BuildContext context, int index) {
                        return _swipeItems[index].content;
                      }),
                ),
                SizedBox(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        backgroundColor: Colors.red,
                        onPressed: () {
                          _matchEngine.currentItem!.nope();
                        },
                        heroTag: "a",
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                      FloatingActionButton(
                        backgroundColor: Colors.green,
                        onPressed: () {
                          _matchEngine.currentItem!.like();
                        },
                        heroTag: "b",
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
