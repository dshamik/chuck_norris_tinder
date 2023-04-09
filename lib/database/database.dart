import 'package:chuck_norris_tinder/api/models/chuck_norris.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreClient {
  final FirebaseFirestore database = FirebaseFirestore.instance;
  late final CollectionReference<Map<String, dynamic>> _jokesCollection;

  FireStoreClient() {
    _jokesCollection = database.collection("jokes");
  }

  Future save(Future<ChuckNorris> chuckFuture) async {
    ChuckNorris chuckNorris = await chuckFuture;
    final jokeRef = _jokesCollection.doc();
    await jokeRef.set(chuckNorris.toJson());
  }

  Stream<List<ChuckNorris>> get() {
    return _jokesCollection.snapshots().map((snapshot) => snapshot.docs.map((doc) => ChuckNorris.fromJson(doc.data())).toList());
  }
}