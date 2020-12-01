import 'dart:async';

import 'package:modular_flutter/app/shared/models/Pokemon.dart';
import 'package:modular_flutter/app/shared/repositories/poke_repository.dart';
import 'package:modular_flutter/app/shared/utils/base_response.dart';

class HomeController {
  final PokeRepository repository;
  StreamController<BaseResponse<List<Pokemon>>> pokemonStreamController;

  HomeController(this.repository) {
    pokemonStreamController = StreamController();
  }
  dispose() {
    pokemonStreamController.close();
  }

  fetchPokemon() async {
    pokemonStreamController.add(BaseResponse.loading());
    try {
      var response = await repository.getAllPokemons();
      pokemonStreamController.add(BaseResponse.completed(data: response));
    } catch (e) {
      pokemonStreamController.add(BaseResponse.error(e.toString()));
    }
  }
}
