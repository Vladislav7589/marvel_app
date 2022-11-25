import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnection extends StateNotifier<bool> {
  InternetConnection() : super(false);

  Future<void> change() async {
    state =  await InternetConnectionChecker().hasConnection;
  }
}
final internetConnectionProvider = StateNotifierProvider<InternetConnection, bool>((ref) => InternetConnection());
