import 'package:chuck_norris_tinder/api/client/client.dart';
import 'package:chuck_norris_tinder/image_generator/image_generator.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chuck Norris Tinder Jokes',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(Icons.whatshot_rounded),
              SizedBox(width: 5),
              Text('Chuck Norris Tinder Jokes'),
              SizedBox(width: 5),
              Icon(Icons.whatshot_rounded),
            ],
          ),
        ),
        body: const MyHomePage(title: ''),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _imageGenerator = ImageGenerator();
  final _client = API(Uri.https('api.chucknorris.io', 'jokes/random'));
  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  late MatchEngine _matchEngine;

  _MyHomePageState() {
    createTinderCard();
    createTinderCard();
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  void createTinderCard() {
    _swipeItems.add(
      SwipeItem(
        content: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _imageGenerator.getImage(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: FutureBuilder(
                    future: _client.getData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data!.value);
                      }
                      return const Text("Loading...");
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        likeAction: createTinderCard,
        nopeAction: createTinderCard,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: const Icon(
                      Icons.check,
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
