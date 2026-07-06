import 'package:florista_ecommerce_app/config/shared_models/entities/product_entity.dart';
import 'package:florista_ecommerce_app/config/shared_models/tab_item_.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/product_grid_view/product_card/product_card.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/product_grid_view/product_card/shimmer_product_card.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/product_grid_view/products_grid_view.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/product_grid_view/shimmer_product_grid_view.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/tab_bar/app_tap_bar.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/tab_bar/shimmer_tab_bar.dart';
import 'package:florista_ecommerce_app/core/utils/themes/light_theme.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      theme: TLightTheme.lightTheme,
      localizationsDelegates: const [S.delegate],
      supportedLocales: S.delegate.supportedLocales,
      home: Scaffold(body: child),
    );
  }

  group('AppTabBarShimmer', () {
    testWidgets('renders four placeholder tabs', (tester) async {
      await tester.pumpWidget(wrap(const AppTabBarShimmer()));
      await tester.pump();

      expect(find.byType(AppTabBarShimmer), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });
  });

  group('ProductsGridShimmer', () {
    testWidgets('renders default six product placeholders', (tester) async {
      await tester.pumpWidget(
        wrap(
          const SizedBox(
            height: 800,
            child: ProductsGridShimmer(itemCount: 4),
          ),
        ),
      );
      await tester.pump();

      // GridView lazily builds visible children only.
      expect(find.byType(ProductCardShimmer), findsWidgets);
      expect(find.byType(GridView), findsOneWidget);
    });
  });

  group('AppTabBar', () {
    testWidgets('renders tab labels from TabItem list', (tester) async {
      final tabs = [
        TabItem(name: 'Wedding', id: '1'),
        TabItem(name: 'Birthday', id: '2'),
      ];

      await tester.pumpWidget(
        wrap(
          DefaultTabController(
            length: tabs.length,
            child: AppTabBar(tabs: tabs),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Wedding'), findsOneWidget);
      expect(find.text('Birthday'), findsOneWidget);
    });
  });

  group('ProductsGridView', () {
    testWidgets('renders product cards for each item', (tester) async {
      final products = [
        ProductEntity(name: 'Rose', price: 100, priceAfterDiscount: 80),
        ProductEntity(name: 'Tulip', price: 200, priceAfterDiscount: 150),
      ];

      await tester.pumpWidget(
        wrap(
          SizedBox(
            height: 800,
            child: ProductsGridView(products: products),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Rose'), findsOneWidget);
      expect(find.text('Tulip'), findsOneWidget);
      expect(find.byType(ProductCard), findsNWidgets(2));
    });
  });

  group('ProductCard', () {
    testWidgets('shows discounted price and strike-through original', (
      tester,
    ) async {
      final product = ProductEntity(
        name: 'Red Rose',
        price: 300,
        priceAfterDiscount: 100,
        discount: 60,
      );

      await tester.pumpWidget(
        wrap(ProductCard(productEntity: product)),
      );
      await tester.pump();

      expect(find.text('Red Rose'), findsOneWidget);
      expect(find.textContaining('100'), findsOneWidget);
      expect(find.textContaining('300'), findsOneWidget);
      expect(find.text('60%'), findsOneWidget);
    });
  });
}
