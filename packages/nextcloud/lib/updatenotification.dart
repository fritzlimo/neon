// coverage:ignore-file
import 'package:nextcloud/src/api/updatenotification.openapi.dart';
import 'package:nextcloud/src/client.dart';

export 'src/api/updatenotification.openapi.dart';

// ignore: public_member_api_docs
extension UpdatenotificationExtension on NextcloudClient {
  static final _updatenotification = Expando<UpdatenotificationClient>();

  /// Client for the updatenotification APIs
  UpdatenotificationClient get updatenotification =>
      _updatenotification[this] ??= UpdatenotificationClient.fromClient(this);
}
