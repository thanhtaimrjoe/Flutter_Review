import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yama_shopping/modal/product.dart';
import 'package:yama_shopping/screen/product/components/product_appbar.dart';
import 'package:yama_shopping/services/episode_service.dart';

class MyProductPage extends StatelessWidget {
  const MyProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var argument = ModalRoute.of(context)!.settings.arguments as Map;
    Product product = Product(argument['categoryID'], argument['name'],
        argument['image'], argument['productID']);
    EpisodeService episodeService = EpisodeService();
    return Scaffold(
        body: FutureProvider<List<dynamic>>(
      create: (context) =>
          episodeService.findEpisodesByProductID(product.productID),
      initialData: const [],
      child: Consumer<List<dynamic>>(
        builder: (context, episodes, child) => CustomScrollView(
          slivers: [
            const ProductAppBar(),
            if (episodes.isNotEmpty)
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(top: 8, left: 8),
                  child: const Text(
                    "全巻リスト",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              ),
            episodes.isEmpty
                ? SliverToBoxAdapter(
                    child: Container(
                        height: 500,
                        child:
                            Center(child: SpinKitCubeGrid(color: Colors.teal))))
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => Container(
                            margin: const EdgeInsets.only(
                                top: 16, right: 16, left: 16),
                            child: Row(
                              children: [
                                Image.network(
                                  episodes[index].image,
                                  width: 80,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    episodes[index].name,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ),
                                IconButton(
                                    iconSize: 35,
                                    onPressed: () {},
                                    icon: const Icon(Icons.add_shopping_cart))
                              ],
                            )),
                        childCount: episodes.length)),
          ],
        ),
      ),
    ));
  }
}
