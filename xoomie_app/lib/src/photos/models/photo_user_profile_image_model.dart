import 'package:xoomie/src/base/models/model_base.dart';

class PhotoUserProfileImageModel extends ModelBase {
  final String small;
  final String medium;
  final String large;

  PhotoUserProfileImageModel({
    required this.small,
    required this.medium,
    required this.large,
  });

  @override
  List<Object?> get props => [small, medium, large];

  PhotoUserProfileImageModel.fromJson(Map<String, dynamic> json)
      : small = json['small'],
        medium = json['medium'],
        large = json['large'];
}
