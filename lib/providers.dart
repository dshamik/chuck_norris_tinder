import 'package:chuck_norris_tinder/api/client/client.dart';
import 'package:chuck_norris_tinder/image_generator/image_generator.dart';
import 'package:chuck_norris_tinder/internet_connection/provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:chuck_norris_tinder/database/database.dart';

final fireStoreProvider = Provider((ref) => FireStoreClient());
final apiProvider =
    Provider((ref) => API(Uri.https('api.chucknorris.io', 'jokes/random')));
final imageProvider = Provider((ref) => ImageGenerator());
final connectionProvider =
    NotifierProvider<ConnectivityProvider, bool>(ConnectivityProvider.new);
