import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';
import 'package:fastfood_app/data/repositories/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<AddProduct>(_onAddProduct);
  }

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final productsStream = _productRepository.getProducts();
      emit(ProductLoaded(products: productsStream));
    } catch (_) {
      emit(ProductError());
    }
  }

  void _onAddProduct(AddProduct event, Emitter<ProductState> emit) async {
    try {
      emit(ProductLoading());
      await _productRepository.addProduct(event.product);
      emit(ProductAdded());
    } catch (_) {
      emit(ProductError());
    }
  }
}
