import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.images,
    required this.percentageFunded,
    required this.title,
    required this.location,
    required this.status,
    required this.totalFundingGoal,
    required this.amountRaised,
    required this.investmentPeriod,
    required this.termRemaining,
    required this.projectedRent,
    required this.updated,
    required this.created,
  });

  final int id;
  final List<ProductImage> images;
  final double percentageFunded;
  final String title;
  final String location;
  final String status;
  final double totalFundingGoal;
  final double amountRaised;
  final int investmentPeriod;
  final int termRemaining;
  final double projectedRent;
  final DateTime updated;
  final DateTime created;

  @override
  List<Object?> get props => [
        id,
        images,
        percentageFunded,
        title,
        location,
        status,
        totalFundingGoal,
        amountRaised,
        investmentPeriod,
        termRemaining,
        projectedRent,
        updated,
        created,
      ];
}

class ProductImage extends Equatable {
  const ProductImage({
    required this.id,
    required this.image,
  });

  final int id;
  final String image;

  @override
  List<Object?> get props => [id, image];
}
