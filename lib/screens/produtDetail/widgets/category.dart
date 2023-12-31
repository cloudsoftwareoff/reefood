import 'package:flutter/material.dart';



import 'package:reefood/colors.dart';
import 'package:reefood/components/helper.dart';
import 'package:reefood/model/food.dart';
import 'package:reefood/screens/produtDetail/widgets/ficon_button.dart';

class CategorySection extends StatelessWidget {
 
  final String sellerUid;
  final String sellerName;
  final SaveFood shop;

  const CategorySection({
    Key? key,
   
    required this.sellerUid,
    required this.sellerName,
    required this.shop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: const EdgeInsets.only(bottom: 16),
      color: scheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTileHeader(context),
          _buildFoodTileList(context),
        ],
      ),
    );
  }

  Widget _buildFoodTileList(BuildContext context) {
    return Column(
      // children: List.generate(
      //   menu.foods.length,
      //   (index) {
      //     final food = menu.foods[index];
      //     bool isLastIndex = index == menu.foods.length - 1;
      //     return _buildFoodTile(
      //       food: food,
      //       context: context,
      //       isLastIndex: isLastIndex,
      //     );
      //   },
      // ),
    );
  }

  Widget _buildSectionTileHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _sectionTitle(context),
        const SizedBox(height: 8.0),
        // menu.category.subtitle != null
        //     ? _sectionSubtitle(context)
        //     : const SizedBox(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _sectionTitle(BuildContext context) {
    return Row(
      children: [
        // if (menu.category.isHotSale) _buildSectionHoteSaleIcon(),
        if (true) _buildSectionHoteSaleIcon(),
        Text("e"
          // menu.category.title,
          // style: _textTheme(context).headline6,
          // strutStyle: Helper.buildStrutStyle(_textTheme(context).headline6),
        )
      ],
    );
  }

  Widget _sectionSubtitle(BuildContext context) {
    return Text("r");
    //   menu.category.subtitle,
    //   style: _textTheme(context).subtitle2,
    //   strutStyle: Helper.buildStrutStyle(_textTheme(context).subtitle2),
    // );
  }

  Widget _buildFoodTile({
    required BuildContext context,
    required bool isLastIndex,
    required SaveFood food,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(
        //   context,
        //   CustomizeScreen.routeName,
        //   arguments: CustomizeScreen(
        //     sellerName: sellerName,
        //     sellerUid: sellerUid,
        //     categoryId: menu.category.id,
        //     food: food,
        //     shop: shop,
        //   ),
        // );
      },
      child: _buildFoodDetail(food, isLastIndex),
    );
  }

  Stack _buildFoodDetail(SaveFood food, bool isLastIndex) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          food.desc,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600]!,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Text(
                              'from \$ ${food.price}',
                            ),
                            const SizedBox(width: 8.0),
                            food.price != 0.0
                                ? Text(
                                    '\$ ${food.price}',
                                    style: TextStyle(
                                      color: Colors.grey[600]!,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  )
                                : const SizedBox(),
                            const SizedBox(width: 8.0),
                            true ? _buildFoodHotSaleIcon() : const SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Hero(
                    tag: food.photo,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        image: DecorationImage(
                          image: NetworkImage(
                            food.photo,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              !isLastIndex
                  ? const Divider(height: 16.0)
                  : const SizedBox(height: 8.0)
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: -4,
          child: FIconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: scheme.primary,
            onPressed: () {},
          ),
        )
      ],
    );
  }

  Widget _buildSectionHoteSaleIcon() {
    return Container(
      margin: const EdgeInsets.only(right: 4.0),
      child: Icon(
        Icons.whatshot,
        color: scheme.primary,
        size: 20.0,
      ),
    );
  }

  Widget _buildFoodHotSaleIcon() {
    return Container(
      child: Icon(Icons.whatshot, color: scheme.primary, size: 16.0),
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: scheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }

  TextTheme _textTheme(context) => Theme.of(context).textTheme;
}