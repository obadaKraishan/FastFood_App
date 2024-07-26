// lib/logic/blocs/product/product_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';
import 'package:fastfood_app/data/repositories/product_repository.dart';
import 'package:fastfood_app/data/models/product_model.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadProduct>(_onLoadProduct);
    on<AddProduct>(_onAddProduct);
    on<LoadProductsByCategory>(_onLoadProductsByCategory);
    on<SearchProducts>(_onSearchProducts); // Add this line
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

  void _onLoadProduct(LoadProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final product = await _productRepository.getProductById(event.productId);
      emit(ProductLoaded(product: product));
    } catch (_) {
      emit(ProductError());
    }
  }

  void _onLoadProductsByCategory(LoadProductsByCategory event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final productsStream = _productRepository.getProductsByCategory(event.categoryId);
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

  void _onSearchProducts(SearchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final productsStream = _productRepository.getProducts();
      final filteredProductsStream = productsStream.map((products) =>
          products.where((product) => product.name.toLowerCase().contains(event.query.toLowerCase())).toList());
      emit(ProductLoaded(products: filteredProductsStream));
    } catch (_) {
      emit(ProductError());
    }
  }
}
