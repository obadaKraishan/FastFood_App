import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';
import 'package:fastfood_app/data/repositories/product_repository.dart';
import 'package:fastfood_app/data/models/product_model.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductInitial());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is AddProduct) {
      yield* _mapAddProductToState(event);
    }
  }

  Stream<ProductState> _mapAddProductToState(AddProduct event) async* {
    try {
      yield ProductLoading();
      await _productRepository.addProduct(event.product);
      yield ProductAdded();
    } catch (_) {
      yield ProductError();
    }
  }
}
