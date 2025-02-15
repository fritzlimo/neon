// ignore_for_file: camel_case_types
// ignore_for_file: discarded_futures
// ignore_for_file: public_member_api_docs
// ignore_for_file: unreachable_switch_case

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:dynamite_runtime/content_string.dart';
import 'package:dynamite_runtime/http_client.dart';

export 'package:dynamite_runtime/http_client.dart';

part 'sharebymail.openapi.g.dart';

class SharebymailClient extends DynamiteClient {
  SharebymailClient(
    super.baseURL, {
    super.baseHeaders,
    super.userAgent,
    super.httpClient,
    super.cookieJar,
    super.authentications,
  });

  SharebymailClient.fromClient(final DynamiteClient client)
      : super(
          client.baseURL,
          baseHeaders: client.baseHeaders,
          httpClient: client.httpClient,
          cookieJar: client.cookieJar,
          authentications: client.authentications,
        );
}

@BuiltValue(instantiable: false)
abstract interface class SharebymailCapabilities_FilesSharing_Sharebymail_UploadFilesDropInterface {
  bool get enabled;
  SharebymailCapabilities_FilesSharing_Sharebymail_UploadFilesDropInterface rebuild(
    final void Function(SharebymailCapabilities_FilesSharing_Sharebymail_UploadFilesDropInterfaceBuilder) updates,
  );
  SharebymailCapabilities_FilesSharing_Sharebymail_UploadFilesDropInterfaceBuilder toBuilder();
}

abstract class SharebymailCapabilities_FilesSharing_Sharebymail_UploadFilesDrop
    implements
        SharebymailCapabilities_FilesSharing_Sharebymail_UploadFilesDropInterface,
        Built<SharebymailCapabilities_FilesSharing_Sharebymail_UploadFilesDrop,
            SharebymailCapabilities_FilesSharing_Sharebymail_UploadFilesDropBuilder> {
  factory SharebymailCapabilities_FilesSharing_Sharebymail_UploadFilesDrop([
    final void Function(SharebymailCapabilities_FilesSharing_Sharebymail_UploadFilesDropBuilder)? b,
  ]) = _$SharebymailCapabilities_FilesSharing_Sharebymail_UploadFilesDrop;

  // coverage:ignore-start
  const SharebymailCapabilities_FilesSharing_Sharebymail_UploadFilesDrop._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory SharebymailCapabilities_FilesSharing_Sharebymail_UploadFilesDrop.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<SharebymailCapabilities_FilesSharing_Sharebymail_UploadFilesDrop> get serializer =>
      _$sharebymailCapabilitiesFilesSharingSharebymailUploadFilesDropSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class SharebymailCapabilities_FilesSharing_Sharebymail_PasswordInterface {
  bool get enabled;
  bool get enforced;
  SharebymailCapabilities_FilesSharing_Sharebymail_PasswordInterface rebuild(
    final void Function(SharebymailCapabilities_FilesSharing_Sharebymail_PasswordInterfaceBuilder) updates,
  );
  SharebymailCapabilities_FilesSharing_Sharebymail_PasswordInterfaceBuilder toBuilder();
}

abstract class SharebymailCapabilities_FilesSharing_Sharebymail_Password
    implements
        SharebymailCapabilities_FilesSharing_Sharebymail_PasswordInterface,
        Built<SharebymailCapabilities_FilesSharing_Sharebymail_Password,
            SharebymailCapabilities_FilesSharing_Sharebymail_PasswordBuilder> {
  factory SharebymailCapabilities_FilesSharing_Sharebymail_Password([
    final void Function(SharebymailCapabilities_FilesSharing_Sharebymail_PasswordBuilder)? b,
  ]) = _$SharebymailCapabilities_FilesSharing_Sharebymail_Password;

  // coverage:ignore-start
  const SharebymailCapabilities_FilesSharing_Sharebymail_Password._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory SharebymailCapabilities_FilesSharing_Sharebymail_Password.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<SharebymailCapabilities_FilesSharing_Sharebymail_Password> get serializer =>
      _$sharebymailCapabilitiesFilesSharingSharebymailPasswordSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class SharebymailCapabilities_FilesSharing_Sharebymail_ExpireDateInterface {
  bool get enabled;
  bool get enforced;
  SharebymailCapabilities_FilesSharing_Sharebymail_ExpireDateInterface rebuild(
    final void Function(SharebymailCapabilities_FilesSharing_Sharebymail_ExpireDateInterfaceBuilder) updates,
  );
  SharebymailCapabilities_FilesSharing_Sharebymail_ExpireDateInterfaceBuilder toBuilder();
}

abstract class SharebymailCapabilities_FilesSharing_Sharebymail_ExpireDate
    implements
        SharebymailCapabilities_FilesSharing_Sharebymail_ExpireDateInterface,
        Built<SharebymailCapabilities_FilesSharing_Sharebymail_ExpireDate,
            SharebymailCapabilities_FilesSharing_Sharebymail_ExpireDateBuilder> {
  factory SharebymailCapabilities_FilesSharing_Sharebymail_ExpireDate([
    final void Function(SharebymailCapabilities_FilesSharing_Sharebymail_ExpireDateBuilder)? b,
  ]) = _$SharebymailCapabilities_FilesSharing_Sharebymail_ExpireDate;

  // coverage:ignore-start
  const SharebymailCapabilities_FilesSharing_Sharebymail_ExpireDate._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory SharebymailCapabilities_FilesSharing_Sharebymail_ExpireDate.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<SharebymailCapabilities_FilesSharing_Sharebymail_ExpireDate> get serializer =>
      _$sharebymailCapabilitiesFilesSharingSharebymailExpireDateSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class SharebymailCapabilities_FilesSharing_SharebymailInterface {
  bool get enabled;
  @BuiltValueField(wireName: 'send_password_by_mail')
  bool get sendPasswordByMail;
  @BuiltValueField(wireName: 'upload_files_drop')
  SharebymailCapabilities_FilesSharing_Sharebymail_UploadFilesDrop get uploadFilesDrop;
  SharebymailCapabilities_FilesSharing_Sharebymail_Password get password;
  @BuiltValueField(wireName: 'expire_date')
  SharebymailCapabilities_FilesSharing_Sharebymail_ExpireDate get expireDate;
  SharebymailCapabilities_FilesSharing_SharebymailInterface rebuild(
    final void Function(SharebymailCapabilities_FilesSharing_SharebymailInterfaceBuilder) updates,
  );
  SharebymailCapabilities_FilesSharing_SharebymailInterfaceBuilder toBuilder();
}

abstract class SharebymailCapabilities_FilesSharing_Sharebymail
    implements
        SharebymailCapabilities_FilesSharing_SharebymailInterface,
        Built<SharebymailCapabilities_FilesSharing_Sharebymail,
            SharebymailCapabilities_FilesSharing_SharebymailBuilder> {
  factory SharebymailCapabilities_FilesSharing_Sharebymail([
    final void Function(SharebymailCapabilities_FilesSharing_SharebymailBuilder)? b,
  ]) = _$SharebymailCapabilities_FilesSharing_Sharebymail;

  // coverage:ignore-start
  const SharebymailCapabilities_FilesSharing_Sharebymail._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory SharebymailCapabilities_FilesSharing_Sharebymail.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<SharebymailCapabilities_FilesSharing_Sharebymail> get serializer =>
      _$sharebymailCapabilitiesFilesSharingSharebymailSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class SharebymailCapabilities_FilesSharingInterface {
  SharebymailCapabilities_FilesSharing_Sharebymail get sharebymail;
  SharebymailCapabilities_FilesSharingInterface rebuild(
    final void Function(SharebymailCapabilities_FilesSharingInterfaceBuilder) updates,
  );
  SharebymailCapabilities_FilesSharingInterfaceBuilder toBuilder();
}

abstract class SharebymailCapabilities_FilesSharing
    implements
        SharebymailCapabilities_FilesSharingInterface,
        Built<SharebymailCapabilities_FilesSharing, SharebymailCapabilities_FilesSharingBuilder> {
  factory SharebymailCapabilities_FilesSharing([final void Function(SharebymailCapabilities_FilesSharingBuilder)? b]) =
      _$SharebymailCapabilities_FilesSharing;

  // coverage:ignore-start
  const SharebymailCapabilities_FilesSharing._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory SharebymailCapabilities_FilesSharing.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<SharebymailCapabilities_FilesSharing> get serializer =>
      _$sharebymailCapabilitiesFilesSharingSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class SharebymailCapabilitiesInterface {
  @BuiltValueField(wireName: 'files_sharing')
  SharebymailCapabilities_FilesSharing get filesSharing;
  SharebymailCapabilitiesInterface rebuild(final void Function(SharebymailCapabilitiesInterfaceBuilder) updates);
  SharebymailCapabilitiesInterfaceBuilder toBuilder();
}

abstract class SharebymailCapabilities
    implements SharebymailCapabilitiesInterface, Built<SharebymailCapabilities, SharebymailCapabilitiesBuilder> {
  factory SharebymailCapabilities([final void Function(SharebymailCapabilitiesBuilder)? b]) = _$SharebymailCapabilities;

  // coverage:ignore-start
  const SharebymailCapabilities._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory SharebymailCapabilities.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<SharebymailCapabilities> get serializer => _$sharebymailCapabilitiesSerializer;
}

// coverage:ignore-start
final Serializers _serializers = (Serializers().toBuilder()
      ..addBuilderFactory(const FullType(SharebymailCapabilities), SharebymailCapabilities.new)
      ..add(SharebymailCapabilities.serializer)
      ..addBuilderFactory(
        const FullType(SharebymailCapabilities_FilesSharing),
        SharebymailCapabilities_FilesSharing.new,
      )
      ..add(SharebymailCapabilities_FilesSharing.serializer)
      ..addBuilderFactory(
        const FullType(SharebymailCapabilities_FilesSharing_Sharebymail),
        SharebymailCapabilities_FilesSharing_Sharebymail.new,
      )
      ..add(SharebymailCapabilities_FilesSharing_Sharebymail.serializer)
      ..addBuilderFactory(
        const FullType(SharebymailCapabilities_FilesSharing_Sharebymail_UploadFilesDrop),
        SharebymailCapabilities_FilesSharing_Sharebymail_UploadFilesDrop.new,
      )
      ..add(SharebymailCapabilities_FilesSharing_Sharebymail_UploadFilesDrop.serializer)
      ..addBuilderFactory(
        const FullType(SharebymailCapabilities_FilesSharing_Sharebymail_Password),
        SharebymailCapabilities_FilesSharing_Sharebymail_Password.new,
      )
      ..add(SharebymailCapabilities_FilesSharing_Sharebymail_Password.serializer)
      ..addBuilderFactory(
        const FullType(SharebymailCapabilities_FilesSharing_Sharebymail_ExpireDate),
        SharebymailCapabilities_FilesSharing_Sharebymail_ExpireDate.new,
      )
      ..add(SharebymailCapabilities_FilesSharing_Sharebymail_ExpireDate.serializer))
    .build();

final Serializers _jsonSerializers = (_serializers.toBuilder()
      ..addPlugin(StandardJsonPlugin())
      ..addPlugin(const ContentStringPlugin()))
    .build();
// coverage:ignore-end
