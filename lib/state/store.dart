import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:timertinio/state/reducers.dart';
import 'package:timertinio/state/state.dart';
import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';

Future getStore() async {
  // Get app tem directory
  Directory persistDirectory = await getTemporaryDirectory();

  // Define file persistor
  final persistor = Persistor<AppState>(
    storage: FileStorage(File("${persistDirectory.path}/state.json")),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
  );

  // Try to load initial state or use empty state as a fallback
  var initialState;
  try {
    initialState = await persistor.load();
  } catch (exception) {
    initialState = AppState.emptyState();
  }

  // Init store with persistor and loader
  final Store store = Store<AppState>(
    appStateReducer,
    initialState: initialState ?? AppState.emptyState(),
    middleware: [persistor.createMiddleware()],
  );

  return store;
}
