import 'package:dio/dio.dart';
import 'package:modular_flutter/app/shared/models/Pokemon.dart';

class PokeRepository {
  final Dio dio;

  PokeRepository(this.dio);

  Future<List<Pokemon>> getAllPokemons() async {
    var response = await dio.get('/pokemon');
    List<Pokemon> list = [];
    for (var pokemon in (response.data['results'] as List)) {
      Pokemon model = Pokemon(name: pokemon['name']);
      list.add(model);
    }
    return list;
  }
}
