import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/productModel.dart';
import '../repository/productRepository.dart';

class ProductState {}

class ProductsLoadedState extends ProductState {
  final List<Products> products;

  ProductsLoadedState(this.products);
}

class ProductDetailsLoadedState extends ProductState {
  final Products product;

  ProductDetailsLoadedState(this.product);
}

class ProductEvent {}

class FetchProductsEvent extends ProductEvent {}

class FetchProductDetailsEvent extends ProductEvent {
  final String productId;

  FetchProductDetailsEvent(this.productId);
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository = ProductRepository();

  ProductBloc() : super(ProductsLoadedState([]));

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is FetchProductsEvent) {
      final products = await repository.fetchProducts();
      print("in block FetchProductsEvent ....${products.length}");
      yield ProductsLoadedState(products);
    } else if (event is FetchProductDetailsEvent) {
      final product = await repository.fetchProductDetails(event.productId);
      print("in block FetchProductDetailsEvent ....${product.title}");
      yield ProductDetailsLoadedState(product);
    }
  }
}
