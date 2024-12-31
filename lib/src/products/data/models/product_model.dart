import 'dart:convert';

import 'package:tdd_app/src/products/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.images,
    required super.percentageFunded,
    required super.title,
    required super.location,
    required super.status,
    required super.totalFundingGoal,
    required super.amountRaised,
    required super.investmentPeriod,
    required super.termRemaining,
    required super.projectedRent,
    required super.updated,
    required super.created,
  });

  factory ProductModel.fromJson(String source) {
    return ProductModel.fromMap(jsonDecode(source));
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      images: (map['images'] as List<dynamic>)
          .map((image) =>
              ProductImageModel.fromMap(image as Map<String, dynamic>))
          .toList(),
      percentageFunded: (map['percentage_funded'] as num).toDouble(),
      title: map['title'] as String,
      location: map['location'] as String,
      status: map['status'] as String,
      totalFundingGoal: double.parse(map['total_funding_goal'] as String),
      amountRaised: double.parse(map['amount_raised'] as String),
      investmentPeriod: map['investment_period'] as int,
      termRemaining: map['term_remaining'] as int,
      projectedRent: double.parse(map['projected_rent'] as String),
      updated: DateTime.parse(map['updated'] as String),
      created: DateTime.parse(map['created'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'images': images
            .map((image) => (image as ProductImageModel).toMap())
            .toList(),
        'percentage_funded': percentageFunded,
        'title': title,
        'location': location,
        'status': status,
        'total_funding_goal': totalFundingGoal.toStringAsFixed(2),
        'amount_raised': amountRaised.toStringAsFixed(2),
        'investment_period': investmentPeriod,
        'term_remaining': termRemaining,
        'projected_rent': projectedRent.toStringAsFixed(2),
        'updated': updated.toIso8601String(),
        'created': created.toIso8601String(),
      };

  String toJson() => jsonEncode(toMap());
}

class ProductImageModel extends ProductImage {
  const ProductImageModel({
    required super.id,
    required super.image,
  });

  factory ProductImageModel.fromJson(String source) {
    return ProductImageModel.fromMap(jsonDecode(source));
  }

  factory ProductImageModel.fromMap(Map<String, dynamic> map) {
    return ProductImageModel(
      id: map['id'] as int,
      image: map['image'] as String,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'image': image,
      };

  String toJson() => jsonEncode(toMap());
}
