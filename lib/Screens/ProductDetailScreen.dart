import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/ProductBloc.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productId;
  //final ProductBloc productBloc;

  ProductDetailsPage({
    required this.productId,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
  static Route<dynamic> route(RouteSettings routeSettings) {
    return CupertinoPageRoute(
        builder: (_) => BlocProvider<ProductBloc>(
              create: (_) => ProductBloc(),
              child: ProductDetailsPage(
                productId: routeSettings.arguments as String,
              ),
            ));
  }
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int currentIndex = 0;
  @override
  void initState() {
    context.read<ProductBloc>().add(FetchProductDetailsEvent(widget.productId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductDetailsLoadedState) {
          final product = state.product;
          return Scaffold(
            appBar: AppBar(
              title: Text(product.title!),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                      aspectRatio: 2.0,
                      onPageChanged: (i, CarouselPageChangedReason) {
                        setState(() {
                          currentIndex = i;
                        });
                      },
                      initialPage: 0),
                  items: product.images!.map((imageUrl) {
                    return Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    );
                  }).toList(),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: product.images!.map(
                      (image) {
                        int index = product.images!.indexOf(image);
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == index
                                  ? Colors.black
                                  : Colors.grey),
                        );
                      },
                    ).toList()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.title!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(product.description!),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text(
                        'Rating: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      StarRating(
                        starCount: 5,
                        rating: product.rating!,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;

  StarRating({
    required this.starCount,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) {
        final filledStars = rating.floor();
        final hasHalfStar = rating - filledStars >= 0.5;
        IconData starIcon;
        Color starColor;

        if (index < filledStars) {
          starIcon = Icons.star;
          starColor = Colors.yellow;
        } else if (index == filledStars && hasHalfStar) {
          starIcon = Icons.star_half;
          starColor = Colors.yellow;
        } else {
          starIcon = Icons.star_border;
          starColor = Colors.grey;
        }

        return Icon(
          starIcon,
          color: starColor,
        );
      }),
    );
  }
}
