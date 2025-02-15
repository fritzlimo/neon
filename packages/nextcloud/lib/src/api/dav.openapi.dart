// ignore_for_file: camel_case_types
// ignore_for_file: discarded_futures
// ignore_for_file: public_member_api_docs
// ignore_for_file: unreachable_switch_case
import 'dart:typed_data';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:collection/collection.dart';
import 'package:dynamite_runtime/content_string.dart';
import 'package:dynamite_runtime/http_client.dart';
import 'package:meta/meta.dart';
import 'package:universal_io/io.dart';

export 'package:dynamite_runtime/http_client.dart';

part 'dav.openapi.g.dart';

class DavClient extends DynamiteClient {
  DavClient(
    super.baseURL, {
    super.baseHeaders,
    super.userAgent,
    super.httpClient,
    super.cookieJar,
    super.authentications,
  });

  DavClient.fromClient(final DynamiteClient client)
      : super(
          client.baseURL,
          baseHeaders: client.baseHeaders,
          httpClient: client.httpClient,
          cookieJar: client.cookieJar,
          authentications: client.authentications,
        );

  DavDirectClient get direct => DavDirectClient(this);
}

class DavDirectClient {
  DavDirectClient(this._rootClient);

  final DavClient _rootClient;

  /// Get a direct link to a file.
  ///
  /// Returns a [Future] containing a [DynamiteResponse] with the status code, deserialized body and headers.
  /// Throws a [DynamiteApiException] if the API call does not return an expected status code.
  ///
  /// Parameters:
  ///   * [fileId] ID of the file
  ///   * [expirationTime] Duration until the link expires
  ///   * [oCSAPIRequest] Required to be true for the API request to pass
  ///
  /// Status codes:
  ///   * 200: Direct link returned
  ///   * 404: File not found
  ///   * 400: Getting direct link is not possible
  ///   * 403: Missing permissions to get direct link
  ///
  /// See:
  ///  * [getUrlRaw] for an experimental operation that returns a [DynamiteRawResponse] that can be serialized.
  Future<DynamiteResponse<DavDirectGetUrlResponseApplicationJson, void>> getUrl({
    required final int fileId,
    final int? expirationTime,
    final bool oCSAPIRequest = true,
  }) async {
    final rawResponse = getUrlRaw(
      fileId: fileId,
      expirationTime: expirationTime,
      oCSAPIRequest: oCSAPIRequest,
    );

    return rawResponse.future;
  }

  /// Get a direct link to a file.
  ///
  /// This method and the response it returns is experimental. The API might change without a major version bump.
  ///
  /// Returns a [Future] containing a [DynamiteRawResponse] with the raw [HttpClientResponse] and serialization helpers.
  /// Throws a [DynamiteApiException] if the API call does not return an expected status code.
  ///
  /// Parameters:
  ///   * [fileId] ID of the file
  ///   * [expirationTime] Duration until the link expires
  ///   * [oCSAPIRequest] Required to be true for the API request to pass
  ///
  /// Status codes:
  ///   * 200: Direct link returned
  ///   * 404: File not found
  ///   * 400: Getting direct link is not possible
  ///   * 403: Missing permissions to get direct link
  ///
  /// See:
  ///  * [getUrl] for an operation that returns a [DynamiteResponse] with a stable API.
  @experimental
  DynamiteRawResponse<DavDirectGetUrlResponseApplicationJson, void> getUrlRaw({
    required final int fileId,
    final int? expirationTime,
    final bool oCSAPIRequest = true,
  }) {
    const path = '/ocs/v2.php/apps/dav/api/v1/direct';
    final queryParameters = <String, dynamic>{};
    final headers = <String, String>{
      'Accept': 'application/json',
    };
    Uint8List? body;

// coverage:ignore-start
    final authentication = _rootClient.authentications.firstWhereOrNull(
      (final auth) => switch (auth) {
        DynamiteHttpBearerAuthentication() || DynamiteHttpBasicAuthentication() => true,
        _ => false,
      },
    );

    if (authentication != null) {
      headers.addAll(
        authentication.headers,
      );
    } else {
      throw Exception('Missing authentication for bearer_auth or basic_auth');
    }

// coverage:ignore-end
    queryParameters['fileId'] = fileId.toString();
    if (expirationTime != null) {
      queryParameters['expirationTime'] = expirationTime.toString();
    }
    headers['OCS-APIRequest'] = oCSAPIRequest.toString();
    final uri = Uri(path: path, queryParameters: queryParameters.isNotEmpty ? queryParameters : null);
    return DynamiteRawResponse<DavDirectGetUrlResponseApplicationJson, void>(
      response: _rootClient.doRequest(
        'post',
        uri,
        headers,
        body,
        const {200},
      ),
      bodyType: const FullType(DavDirectGetUrlResponseApplicationJson),
      headersType: null,
      serializers: _jsonSerializers,
    );
  }
}

@BuiltValue(instantiable: false)
abstract interface class DavOCSMetaInterface {
  String get status;
  int get statuscode;
  String? get message;
  String? get totalitems;
  String? get itemsperpage;
  DavOCSMetaInterface rebuild(final void Function(DavOCSMetaInterfaceBuilder) updates);
  DavOCSMetaInterfaceBuilder toBuilder();
}

abstract class DavOCSMeta implements DavOCSMetaInterface, Built<DavOCSMeta, DavOCSMetaBuilder> {
  factory DavOCSMeta([final void Function(DavOCSMetaBuilder)? b]) = _$DavOCSMeta;

  // coverage:ignore-start
  const DavOCSMeta._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory DavOCSMeta.fromJson(final Map<String, dynamic> json) => _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<DavOCSMeta> get serializer => _$davOCSMetaSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class DavDirectGetUrlResponseApplicationJson_Ocs_DataInterface {
  String get url;
  DavDirectGetUrlResponseApplicationJson_Ocs_DataInterface rebuild(
    final void Function(DavDirectGetUrlResponseApplicationJson_Ocs_DataInterfaceBuilder) updates,
  );
  DavDirectGetUrlResponseApplicationJson_Ocs_DataInterfaceBuilder toBuilder();
}

abstract class DavDirectGetUrlResponseApplicationJson_Ocs_Data
    implements
        DavDirectGetUrlResponseApplicationJson_Ocs_DataInterface,
        Built<DavDirectGetUrlResponseApplicationJson_Ocs_Data, DavDirectGetUrlResponseApplicationJson_Ocs_DataBuilder> {
  factory DavDirectGetUrlResponseApplicationJson_Ocs_Data([
    final void Function(DavDirectGetUrlResponseApplicationJson_Ocs_DataBuilder)? b,
  ]) = _$DavDirectGetUrlResponseApplicationJson_Ocs_Data;

  // coverage:ignore-start
  const DavDirectGetUrlResponseApplicationJson_Ocs_Data._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory DavDirectGetUrlResponseApplicationJson_Ocs_Data.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<DavDirectGetUrlResponseApplicationJson_Ocs_Data> get serializer =>
      _$davDirectGetUrlResponseApplicationJsonOcsDataSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class DavDirectGetUrlResponseApplicationJson_OcsInterface {
  DavOCSMeta get meta;
  DavDirectGetUrlResponseApplicationJson_Ocs_Data get data;
  DavDirectGetUrlResponseApplicationJson_OcsInterface rebuild(
    final void Function(DavDirectGetUrlResponseApplicationJson_OcsInterfaceBuilder) updates,
  );
  DavDirectGetUrlResponseApplicationJson_OcsInterfaceBuilder toBuilder();
}

abstract class DavDirectGetUrlResponseApplicationJson_Ocs
    implements
        DavDirectGetUrlResponseApplicationJson_OcsInterface,
        Built<DavDirectGetUrlResponseApplicationJson_Ocs, DavDirectGetUrlResponseApplicationJson_OcsBuilder> {
  factory DavDirectGetUrlResponseApplicationJson_Ocs([
    final void Function(DavDirectGetUrlResponseApplicationJson_OcsBuilder)? b,
  ]) = _$DavDirectGetUrlResponseApplicationJson_Ocs;

  // coverage:ignore-start
  const DavDirectGetUrlResponseApplicationJson_Ocs._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory DavDirectGetUrlResponseApplicationJson_Ocs.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<DavDirectGetUrlResponseApplicationJson_Ocs> get serializer =>
      _$davDirectGetUrlResponseApplicationJsonOcsSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class DavDirectGetUrlResponseApplicationJsonInterface {
  DavDirectGetUrlResponseApplicationJson_Ocs get ocs;
  DavDirectGetUrlResponseApplicationJsonInterface rebuild(
    final void Function(DavDirectGetUrlResponseApplicationJsonInterfaceBuilder) updates,
  );
  DavDirectGetUrlResponseApplicationJsonInterfaceBuilder toBuilder();
}

abstract class DavDirectGetUrlResponseApplicationJson
    implements
        DavDirectGetUrlResponseApplicationJsonInterface,
        Built<DavDirectGetUrlResponseApplicationJson, DavDirectGetUrlResponseApplicationJsonBuilder> {
  factory DavDirectGetUrlResponseApplicationJson([
    final void Function(DavDirectGetUrlResponseApplicationJsonBuilder)? b,
  ]) = _$DavDirectGetUrlResponseApplicationJson;

  // coverage:ignore-start
  const DavDirectGetUrlResponseApplicationJson._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory DavDirectGetUrlResponseApplicationJson.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<DavDirectGetUrlResponseApplicationJson> get serializer =>
      _$davDirectGetUrlResponseApplicationJsonSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class DavCapabilities_DavInterface {
  String get chunking;
  String? get bulkupload;
  DavCapabilities_DavInterface rebuild(final void Function(DavCapabilities_DavInterfaceBuilder) updates);
  DavCapabilities_DavInterfaceBuilder toBuilder();
}

abstract class DavCapabilities_Dav
    implements DavCapabilities_DavInterface, Built<DavCapabilities_Dav, DavCapabilities_DavBuilder> {
  factory DavCapabilities_Dav([final void Function(DavCapabilities_DavBuilder)? b]) = _$DavCapabilities_Dav;

  // coverage:ignore-start
  const DavCapabilities_Dav._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory DavCapabilities_Dav.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<DavCapabilities_Dav> get serializer => _$davCapabilitiesDavSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class DavCapabilitiesInterface {
  DavCapabilities_Dav get dav;
  DavCapabilitiesInterface rebuild(final void Function(DavCapabilitiesInterfaceBuilder) updates);
  DavCapabilitiesInterfaceBuilder toBuilder();
}

abstract class DavCapabilities implements DavCapabilitiesInterface, Built<DavCapabilities, DavCapabilitiesBuilder> {
  factory DavCapabilities([final void Function(DavCapabilitiesBuilder)? b]) = _$DavCapabilities;

  // coverage:ignore-start
  const DavCapabilities._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory DavCapabilities.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<DavCapabilities> get serializer => _$davCapabilitiesSerializer;
}

// coverage:ignore-start
final Serializers _serializers = (Serializers().toBuilder()
      ..addBuilderFactory(
        const FullType(DavDirectGetUrlResponseApplicationJson),
        DavDirectGetUrlResponseApplicationJson.new,
      )
      ..add(DavDirectGetUrlResponseApplicationJson.serializer)
      ..addBuilderFactory(
        const FullType(DavDirectGetUrlResponseApplicationJson_Ocs),
        DavDirectGetUrlResponseApplicationJson_Ocs.new,
      )
      ..add(DavDirectGetUrlResponseApplicationJson_Ocs.serializer)
      ..addBuilderFactory(const FullType(DavOCSMeta), DavOCSMeta.new)
      ..add(DavOCSMeta.serializer)
      ..addBuilderFactory(
        const FullType(DavDirectGetUrlResponseApplicationJson_Ocs_Data),
        DavDirectGetUrlResponseApplicationJson_Ocs_Data.new,
      )
      ..add(DavDirectGetUrlResponseApplicationJson_Ocs_Data.serializer)
      ..addBuilderFactory(const FullType(DavCapabilities), DavCapabilities.new)
      ..add(DavCapabilities.serializer)
      ..addBuilderFactory(const FullType(DavCapabilities_Dav), DavCapabilities_Dav.new)
      ..add(DavCapabilities_Dav.serializer))
    .build();

final Serializers _jsonSerializers = (_serializers.toBuilder()
      ..addPlugin(StandardJsonPlugin())
      ..addPlugin(const ContentStringPlugin()))
    .build();
// coverage:ignore-end
