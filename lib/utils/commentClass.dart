import 'package:cs310_step3/utils/productClass.dart';

class Comment {
  final String? user;
  final String? data;
  final int? rating;
  final DateTime? date;

  Comment(this.user, this.data, this.rating, this.date);
}