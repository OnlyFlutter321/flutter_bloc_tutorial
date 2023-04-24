import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc/features/home/bloc/home_bloc.dart';
import 'package:simple_bloc/features/home/models/home_product_data_model.dart';
import 'package:simple_bloc/features/notify/bloc/notify_bloc.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  const ProductTileWidget(
      {super.key, required this.productDataModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(productDataModel.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            height: 200,
            width: double.maxFinite,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            productDataModel.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(productDataModel.description),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${productDataModel.price}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  BlocBuilder<NotifyBloc, NotifyState>(
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          BlocProvider.of<NotifyBloc>(context)
                              .add(NotifyAddEvent());
                          homeBloc.add(HomeProductWishlistButtonClickedEvent(
                              clickedProduct: productDataModel));
                        },
                        icon: const Icon(Icons.favorite_border),
                      );
                    },
                  ),
                  BlocBuilder<NotifyCartBloc, NotifyStateForCart>(
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          BlocProvider.of<NotifyCartBloc>(context)
                              .add(NotificationCartAddEvent());
                          homeBloc.add(HomeProductCartButtonClickedEvent(
                              clickedProduct: productDataModel));
                        },
                        icon: const Icon(Icons.shopping_bag_outlined),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
