import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constant/stat_color.dart';
import '../../../constant/type_color.dart';
import '../controllers/detail_controller.dart';

class DetailView extends StatefulWidget {
  final String name;
  const DetailView({Key? key, required this.name}) : super(key: key);

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late final DetailController detailController;

  @override
  void initState() {
    super.initState();
    detailController = Get.put(DetailController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      detailController.getDetailPokemon(name: widget.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        Color appBarColor = typeColors[detailController.dataDetailProgram.value.types?.first.type.name.toLowerCase()] ?? Colors.grey;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.name,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: appBarColor,
          ),
          body: Obx(() {
            if (detailController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (detailController.dataDetailProgram.value.name == null) {
              return const Center(child: Text("Data not found"));
            } else {
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: typeColors[detailController.dataDetailProgram.value.types?.first.type.name.toLowerCase()] ?? Colors.grey, // Use the color of the first type
                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                        ),
                        child: Image.network(
                          "${detailController.dataDetailProgram.value.sprites?.other?.officialArtwork.frontDefault}",
                          height: 300,
                          width: 300,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Display your Pokemon details here
                      Text(
                        detailController.dataDetailProgram.value.name ?? "",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text("Types: "),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          detailController.dataDetailProgram.value.types!.length,
                              (index) {
                            Color typeColor = typeColors[detailController.dataDetailProgram.value.types?[index].type.name.toLowerCase()] ?? Colors.grey;

                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0), // Add some spacing between items
                              child: Container(
                                decoration: BoxDecoration(
                                  color: typeColor, // Use the mapped color for the container background
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    detailController.dataDetailProgram.value.types![index].type.name,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Height",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text("${(detailController.dataDetailProgram.value.height! / 10).toString()} M"),
                            ],
                          ),
                          const SizedBox(width: 50),
                          Column(
                            children: [
                              const Text(
                                "Weight",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text("${(detailController.dataDetailProgram.value.weight! / 10).toString()} Kg"),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Stats",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Wrap(
                            children: List.generate(
                              detailController.dataDetailProgram.value.stats!.length,
                                  (index) {
                                // Map each stat name to its corresponding color
                                Color barColor = statColors[detailController.dataDetailProgram.value.stats![index].stat.name.toLowerCase()] ?? Colors.grey;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15), // Add some spacing between items
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(detailController.dataDetailProgram.value.stats![index].stat.name),
                                          const SizedBox(width: 10),
                                          Text("${detailController.dataDetailProgram.value.stats![index].baseStat.toString()}/300"),
                                        ],
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: LinearProgressIndicator(
                                          value: detailController.dataDetailProgram.value.stats![index].baseStat / 300, // Assuming the max stat value is 100
                                          backgroundColor: Colors.grey,
                                          minHeight: 10,
                                          valueColor: AlwaysStoppedAnimation<Color>(barColor), // Use the mapped color for the bar
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            }
          }),
        );
      }),
    );
  }
}

