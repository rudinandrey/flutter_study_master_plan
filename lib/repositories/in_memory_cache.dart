import 'repository.dart';

class InMemoryCache implements Repository {
  final _storage = Map<int, Model>();
}