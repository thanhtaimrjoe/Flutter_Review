import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yama_shopping/constants.dart';
import 'package:yama_shopping/modal/cart.dart';
import 'package:yama_shopping/modal/product.dart';
import 'package:yama_shopping/screen/product/components/character_card.dart';
import 'package:yama_shopping/screen/product/components/episode_card.dart';
import 'package:yama_shopping/screen/product/components/product_appbar.dart';
import 'package:yama_shopping/screen/product/components/product_title.dart';
import 'package:yama_shopping/services/category_service.dart';
import 'package:yama_shopping/services/character_service.dart';
import 'package:yama_shopping/services/episode_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyProductPage extends StatelessWidget {
  const MyProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color theme = Theme.of(context).backgroundColor;
    var argument = ModalRoute.of(context)!.settings.arguments as Map;
    Product product = Product(argument['categoryID'], argument['name'],
        argument['image'], argument['productID'], argument['overview']);
    final card = Provider.of<Cart>(context);
    CategoryService categoryService = CategoryService();
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
        FutureProvider<String>(
            create: (context) => categoryService
                .findCategoryNameByCategoryID(product.categoryID),
            initialData: '')
      ],
      child: Consumer<List<dynamic>>(
        builder: (context, episodes, child) => CustomScrollView(
          slivers: [
            Consumer<String>(
                builder: (context, categoryName, child) => ProductAppBar(
                    product: product, categoryName: categoryName)),
            if (episodes.isNotEmpty)
              ProductTitle(title: AppLocalizations.of(context)!.chapterList),
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
                                          title: Text(
                                              AppLocalizations.of(context)!
                                                  .nofityAddToCartTitle),
                                          content: Text(
                                              AppLocalizations.of(context)!
                                                  .nofityAddToCartContent),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () => Navigator.pop(
                                                    context, "OK"),
                                                child: Text(AppLocalizations.of(
                                                        context)!
                                                    .nofityAddToCartBtn))
                                          ],
                                        ));
                              },
                            ),
                        childCount: episodes.length)),
            if (episodes.isNotEmpty)
              ProductTitle(title: AppLocalizations.of(context)!.story),
            if (episodes.isNotEmpty)
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    product.overview,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
            if (episodes.isNotEmpty)
              ProductTitle(title: AppLocalizations.of(context)!.character),
            if (episodes.isNotEmpty)
              FutureProvider<List<dynamic>>(
                  create: (context) => characterService
                      .findCharactersByProductID(product.productID),
                  initialData: const [],
                  child: Consumer<List<dynamic>>(
                      builder: (context, characters, child) => SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) => CharacterCard(
                                    characters: characters,
                                    index: index,
                                  ),
                              childCount: characters.length))))
          ],
        ),
      ),
    ));
  }
}
