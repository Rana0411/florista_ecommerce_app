part of 'product_card.dart';

class ProductImage extends StatelessWidget {
  final String? imageUrl;

  const ProductImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;

    if (url != null && url.startsWith('http')) {
      return Image.network(
        url,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, object, stackTrace) =>
            Image.asset(AppConstants.imagePlaceholder, fit: BoxFit.cover),
      );
    }

    return Image.asset(url ?? AppConstants.imagePlaceholder, fit: BoxFit.cover);
  }
}
