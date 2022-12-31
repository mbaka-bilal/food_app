import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../utils/appstyles.dart';
import '../../../services/cart.dart';

class FoodInfoCard extends StatelessWidget {
  const FoodInfoCard(
      {Key? key,
      required this.imageUrl,
      required this.id,
      required this.cost,
      required this.name})
      : super(key: key);

  final String imageUrl;
  final String cost;
  final String name;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          Positioned.fill(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.fitHeight,
              placeholder: (context, count) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          )),
          // Positioned.fill(
          //   child: Center(child: const CircularProgressIndicator()
          // ),),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        name,
                        style: TextStyles.normal(15, Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.nairaSign,
                            color: Colors.white, size: 12),
                        Text(
                          cost,
                          style: TextStyles.normal(15, Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                  // padding: EdgeInsets.zero,
                  // margin: EdgeInsets.zero,
                  decoration: const BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(20))),
                  child: GestureDetector(
                    onTap: () {
                      context.read<Cart>().addToList(
                          foodID: id,
                          foodName: name,
                          amount: int.tryParse(cost)!,
                          imageUrl: imageUrl);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: CircleAvatar(
                        backgroundColor: AppColors.green,
                        radius: 12,
                        child: Icon(
                          Icons.add,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
