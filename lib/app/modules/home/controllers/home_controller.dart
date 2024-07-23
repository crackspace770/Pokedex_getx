import 'package:get/get.dart';
import '../model/pokemon_response.dart';
import '../service/home_service.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Pokemon> dataPokemon = <Pokemon>[].obs;

  @override
  void onInit() {
    super.onInit();
    getListPokemon();
  }

  Future<void> getListPokemon() async {
    isLoading.value = true;
    try {
      final PokemonResponse pokemonResponse = await HomeService().getPokemonList();
      dataPokemon.clear();
      if (pokemonResponse.pokemon!.isNotEmpty) {
        dataPokemon.value = pokemonResponse.pokemon;
      }
    } catch (e) {
      print('Error fetching Pokémon list: $e');
    } finally {
      isLoading.value = false;
    }
  }


}
