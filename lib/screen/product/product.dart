import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yama_shopping/constants.dart';
import 'package:yama_shopping/modal/cart.dart';
import 'package:yama_shopping/modal/character.dart';
import 'package:yama_shopping/modal/product.dart';
import 'package:yama_shopping/screen/product/components/character_card.dart';
import 'package:yama_shopping/screen/product/components/episode_card.dart';
import 'package:yama_shopping/screen/product/components/product_appbar.dart';
import 'package:yama_shopping/screen/product/components/product_title.dart';
import 'package:yama_shopping/services/character_service.dart';
import 'package:yama_shopping/services/episode_service.dart';

class MyProductPage extends StatelessWidget {
  const MyProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color theme = Theme.of(context).backgroundColor;
    var argument = ModalRoute.of(context)!.settings.arguments as Map;
    Product product = Product(argument['categoryID'], argument['name'],
        argument['image'], argument['productID'], argument['overview']);
    final card = Provider.of<Cart>(context);
    EpisodeService episodeService = EpisodeService();
    CharacterService characterService = CharacterService();
    return Scaffold(
        body: MultiProvider(
      providers: [
        FutureProvider<List<dynamic>>(
          create: (context) =>
              episodeService.findEpisodesByProductID(product.productID),
          initialData: const [],
        ),
        FutureProvider<Character>(
            create: (context) =>
                characterService.findCharactersByProductID(product.productID),
            initialData: Character(product.productID, []))
      ],
      child: Consumer<List<dynamic>>(
        builder: (context, episodes, child) => CustomScrollView(
          slivers: [
            ProductAppBar(product: product),
            if (episodes.isNotEmpty) const ProductTitle(title: "全巻リスト"),
            episodes.isEmpty
                ? SliverToBoxAdapter(
                    child: SizedBox(
                        height: 500,
                        child: Center(child: SpinKitCubeGrid(color: theme))))
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => EpisodeCard(
                              index: index,
                              episodes: episodes,
                              press: () {
                                card.add(episodes[index]);
                                showDialog(
                                    context: context,
                                    builder: (contex) => AlertDialog(
                                          title: const Text("成功"),
                                          content: const Text("カートに追加しました。"),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () => Navigator.pop(
                                                    context, "OK"),
                                                child: const Text("OK"))
                                          ],
                                        ));
                              },
                            ),
                        childCount: episodes.length)),
            if (episodes.isNotEmpty) const ProductTitle(title: "ストーリー＆キャラクター"),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      product.overview,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  Consumer<Character>(
                      builder: (context, character, child) => Container(
                            color: const Color.fromARGB(255, 179, 201, 238),
                            margin: const EdgeInsets.all(defaultPadding),
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding / 4),
                            width: MediaQuery.of(context).size.width,
                            height: 141,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: character.items.length,
                              itemBuilder: (context, index) {
                                return CharacterCard(
                                  image: character.items[index]['image'],
                                  name: character.items[index]['name'],
                                );
                              },
                            ),
                          ))
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
