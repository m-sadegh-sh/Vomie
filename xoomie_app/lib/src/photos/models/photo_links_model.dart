import 'package:xoomie/src/base/models/model_base.dart';

class PhotoLinksModel extends ModelBase {
  final String self;
  final String html;
  final String download;
  final String downloadLocation;

  PhotoLinksModel({
    required this.self,
    required this.html,
    required this.download,
    required this.downloadLocation,
  });

  @override
  List<Object?> get props => [
        self,
        html,
        download,
        downloadLocation,
      ];

  PhotoLinksModel.fromJson(Map<String, dynamic> json)
      : self = json['self'],
        html = json['html'],
        download = json['download'],
        downloadLocation = json['download_location'];
}
