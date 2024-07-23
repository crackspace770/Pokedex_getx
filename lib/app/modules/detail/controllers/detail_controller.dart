import 'package:get/get.dart';
import 'package:pokedex_get/app/modules/detail/model/pokemon_detail_response.dart';

import '../service/detail_service.dart';

class DetailController extends GetxController {

  Rx<PokemonDetail> dataDetailProgram = PokemonDetail().obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getDetailPokemon({String? name}) async {
    isLoading.value = true;

    final PokemonDetailResponse detailPokemon =
    await DetailService().getDetailPokemon(name: name);
    dataDetailProgram.value = detailPokemon.pokemonDetail;
    isLoading.value = false;
  }

}
