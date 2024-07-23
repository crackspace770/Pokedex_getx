import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:pokedex_get/app/constant/const_variable.dart';
import '../model/pokemon_response.dart';

class HomeService {
  final client = Client();
  final String baseUrl = ConstVariable.base_url;

  Future<PokemonResponse> getPokemonList() async {
    try {
      final response = await client.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        print("Response: ${response.body}");  // Debug print
        return PokemonResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Pokémon: ${response.body}');
      }
    } catch (e) {
      print('Error fetching Pokémon list: $e');
      throw Exception('Failed to load Pokémon list: $e');
    }
  }
}
