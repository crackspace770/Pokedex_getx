import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../detail/views/detail_view.dart';
import '../controllers/home_controller.dart';
import '../model/pokemon_response.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POKEDEX',
        style: TextStyle(
          color: Colors.white
        ),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Obx(
            () => controller.isLoading.value
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : controller.dataPokemon.isEmpty
            ? const Center(
          child: Text("No Data"),
        )
            : GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of items per row
            crossAxisSpacing: 4, // Spacing between items horizontally
            mainAxisSpacing: 4, // Spacing between items vertically
          ),
          itemCount: controller.dataPokemon.length,
          itemBuilder: (context, index) {
            return CardPokemon(
              pokemon: controller.dataPokemon[index],
              onTap: () {
                Get.to(DetailView(
                  name: controller
                      .dataPokemon[index].name ??
                      "0",
                ));
              },
            );
          },
        ),
      ),
    );
  }
}

class CardPokemon extends StatelessWidget {
  final Pokemon pokemon;
  final void Function()? onTap;

  const CardPokemon({super.key, required this.pokemon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final RegExp regex = RegExp(r'/(\d+)/$');
    final Match? match = regex.firstMatch(pokemon.url ??"");
    final String? id = match?.group(1);

    final String imageUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

    return Padding(
      padding: const EdgeInsets.only(top: 25, right: 8, left: 8, bottom: 8),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 200, // Set width and height to desired size
          height: 300,
          child: Container(
            padding: const EdgeInsets.only(top: 16, right: 8, left: 8, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Column(
              children: [
                Image.network(imageUrl, width: 100, height: 100),
                const SizedBox(height: 10),
                Text(pokemon.name ??""),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
