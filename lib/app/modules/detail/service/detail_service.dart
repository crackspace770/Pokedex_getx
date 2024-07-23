
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:pokedex_get/app/constant/const_variable.dart';

import '../model/pokemon_detail_response.dart';


class DetailService extends GetConnect{

  final client = Client();
  final String baseUrl = ConstVariable.base_url;

  Future<PokemonDetailResponse> getDetailPokemon({String? name}) async {
    try {
      final response = await client.get(Uri.parse("$baseUrl/$name"));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse); // Add this line to print the JSON response
        return PokemonDetailResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load top headlines');
      }
    } on Error catch (e) {
      print('Error: $e');
      throw Exception('Something went wrong ');
    }
  }


}