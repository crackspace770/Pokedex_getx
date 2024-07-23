
import 'dart:convert';

PokemonResponse pokemonResponseFromJson(String str) =>
    PokemonResponse.fromJson(json.decode(str));

String pokemonResponseToJson(PokemonResponse data) =>
    json.encode(data.toJson());

class PokemonResponse {
  final int? count;
  final String? next;
  final dynamic previous;
  final List<Pokemon> pokemon;

  PokemonResponse({
    this.count,
    this.next,
    this.previous,
    required this.pokemon,
  });

  PokemonResponse copyWith({
    int? count,
    String? next,
    dynamic previous,
    List<Pokemon>? results,
  }) =>
      PokemonResponse(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        pokemon: results ?? pokemon,
      );

  factory PokemonResponse.fromJson(Map<String, dynamic> json) => PokemonResponse(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    pokemon: json["results"] == null
        ? []
        : List<Pokemon>.from(
        json["results"]!.map((x) => Pokemon.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": pokemon == null
        ? []
        : List<dynamic>.from(pokemon!.map((x) => x.toJson())),
  };
}

class Pokemon {
  final String? name;
  final String? url;

  Pokemon({
    this.name,
    this.url,
  });

  Pokemon copyWith({
    String? name,
    String? url,
  }) =>
      Pokemon(
        name: name ?? this.name,
        url: url ?? this.url,
      );

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}
