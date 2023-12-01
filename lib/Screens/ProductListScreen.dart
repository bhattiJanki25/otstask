import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/ProductBloc.dart';
import '../routes/Routes.dart';
import 'ProductDetailScreen.dart';

class ProductListingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(FetchProductsEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Listing'),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        bloc: context.read<ProductBloc>(),
        builder: (context, state) {
          if (state is ProductsLoadedState) {
            final productBloc = BlocProvider.of<ProductBloc>(context);
            print("length is.....${state.products.length}");
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return Card(
                  child: ListTile(
                    title: Text(product.title!),
                    subtitle: Text(product.description!),
                    onTap: () {
                      Future.delayed(Duration.zero, () {
                        Navigator.of(context).pushNamed(Routes.detail,
                            arguments: product.id.toString());
                        /* Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                  value: productBloc,
                                  child: ProductDetailsPage(
                                      productId: product.id.toString())),
                            ));*/
                      });
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
