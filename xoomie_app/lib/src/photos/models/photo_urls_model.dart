import 'package:xoomie/src/base/models/model_base.dart';

class PhotoUrlsModel extends ModelBase {
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;

  PhotoUrlsModel({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
  });

  @override
  List<Object?> get props => [
        raw,
        full,
        regular,
        small,
        thumb,
      ];

  PhotoUrlsModel.fromJson(Map<String, dynamic> json)
      : raw = json['raw'],
        full = json['full'],
        regular = json['regular'],
        small = json['small'],
        thumb = json['thumb'];
}
