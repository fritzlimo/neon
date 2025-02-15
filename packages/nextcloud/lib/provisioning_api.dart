// coverage:ignore-file
import 'package:nextcloud/src/api/provisioning_api.openapi.dart';
import 'package:nextcloud/src/client.dart';

export 'src/api/provisioning_api.openapi.dart';

// ignore: public_member_api_docs
extension ProvisioningApiExtension on NextcloudClient {
  static final _provisioningApi = Expando<ProvisioningApiClient>();

  /// Client for the provisioning_api APIs
  ProvisioningApiClient get provisioningApi => _provisioningApi[this] ??= ProvisioningApiClient.fromClient(this);
}
