// ignore_for_file: camel_case_types
// ignore_for_file: discarded_futures
// ignore_for_file: public_member_api_docs
// ignore_for_file: unreachable_switch_case
import 'dart:typed_data';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:collection/collection.dart';
import 'package:dynamite_runtime/content_string.dart';
import 'package:dynamite_runtime/http_client.dart';
import 'package:meta/meta.dart';
import 'package:universal_io/io.dart';

export 'package:dynamite_runtime/http_client.dart';

part 'dashboard.openapi.g.dart';

class DashboardClient extends DynamiteClient {
  DashboardClient(
    super.baseURL, {
    super.baseHeaders,
    super.userAgent,
    super.httpClient,
    super.cookieJar,
    super.authentications,
  });

  DashboardClient.fromClient(final DynamiteClient client)
      : super(
          client.baseURL,
          baseHeaders: client.baseHeaders,
          httpClient: client.httpClient,
          cookieJar: client.cookieJar,
          authentications: client.authentications,
        );

  DashboardDashboardApiClient get dashboardApi => DashboardDashboardApiClient(this);
}

class DashboardDashboardApiClient {
  DashboardDashboardApiClient(this._rootClient);

  final DashboardClient _rootClient;

  /// Get the widgets.
  ///
  /// Returns a [Future] containing a [DynamiteResponse] with the status code, deserialized body and headers.
  /// Throws a [DynamiteApiException] if the API call does not return an expected status code.
  ///
  /// Parameters:
  ///   * [oCSAPIRequest] Required to be true for the API request to pass
  ///
  /// Status codes:
  ///   * 200: Widgets returned
  ///
  /// See:
  ///  * [getWidgetsRaw] for an experimental operation that returns a [DynamiteRawResponse] that can be serialized.
  Future<DynamiteResponse<DashboardDashboardApiGetWidgetsResponseApplicationJson, void>> getWidgets({
    final bool oCSAPIRequest = true,
  }) async {
    final rawResponse = getWidgetsRaw(
      oCSAPIRequest: oCSAPIRequest,
    );

    return rawResponse.future;
  }

  /// Get the widgets.
  ///
  /// This method and the response it returns is experimental. The API might change without a major version bump.
  ///
  /// Returns a [Future] containing a [DynamiteRawResponse] with the raw [HttpClientResponse] and serialization helpers.
  /// Throws a [DynamiteApiException] if the API call does not return an expected status code.
  ///
  /// Parameters:
  ///   * [oCSAPIRequest] Required to be true for the API request to pass
  ///
  /// Status codes:
  ///   * 200: Widgets returned
  ///
  /// See:
  ///  * [getWidgets] for an operation that returns a [DynamiteResponse] with a stable API.
  @experimental
  DynamiteRawResponse<DashboardDashboardApiGetWidgetsResponseApplicationJson, void> getWidgetsRaw({
    final bool oCSAPIRequest = true,
  }) {
    const path = '/ocs/v2.php/apps/dashboard/api/v1/widgets';
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
    headers['OCS-APIRequest'] = oCSAPIRequest.toString();
    final uri = Uri(path: path, queryParameters: queryParameters.isNotEmpty ? queryParameters : null);
    return DynamiteRawResponse<DashboardDashboardApiGetWidgetsResponseApplicationJson, void>(
      response: _rootClient.doRequest(
        'get',
        uri,
        headers,
        body,
        const {200},
      ),
      bodyType: const FullType(DashboardDashboardApiGetWidgetsResponseApplicationJson),
      headersType: null,
      serializers: _jsonSerializers,
    );
  }

  /// Get the items for the widgets.
  ///
  /// Returns a [Future] containing a [DynamiteResponse] with the status code, deserialized body and headers.
  /// Throws a [DynamiteApiException] if the API call does not return an expected status code.
  ///
  /// Parameters:
  ///   * [sinceIds] Array indexed by widget Ids, contains date/id from which we want the new items
  ///   * [limit] Limit number of result items per widget
  ///   * [widgets] Limit results to specific widgets
  ///   * [oCSAPIRequest] Required to be true for the API request to pass
  ///
  /// Status codes:
  ///   * 200: Widget items returned
  ///
  /// See:
  ///  * [getWidgetItemsRaw] for an experimental operation that returns a [DynamiteRawResponse] that can be serialized.
  Future<DynamiteResponse<DashboardDashboardApiGetWidgetItemsResponseApplicationJson, void>> getWidgetItems({
    final ContentString<BuiltMap<String, String>>? sinceIds,
    final int limit = 7,
    final List<String> widgets = const <String>[],
    final bool oCSAPIRequest = true,
  }) async {
    final rawResponse = getWidgetItemsRaw(
      sinceIds: sinceIds,
      limit: limit,
      widgets: widgets,
      oCSAPIRequest: oCSAPIRequest,
    );

    return rawResponse.future;
  }

  /// Get the items for the widgets.
  ///
  /// This method and the response it returns is experimental. The API might change without a major version bump.
  ///
  /// Returns a [Future] containing a [DynamiteRawResponse] with the raw [HttpClientResponse] and serialization helpers.
  /// Throws a [DynamiteApiException] if the API call does not return an expected status code.
  ///
  /// Parameters:
  ///   * [sinceIds] Array indexed by widget Ids, contains date/id from which we want the new items
  ///   * [limit] Limit number of result items per widget
  ///   * [widgets] Limit results to specific widgets
  ///   * [oCSAPIRequest] Required to be true for the API request to pass
  ///
  /// Status codes:
  ///   * 200: Widget items returned
  ///
  /// See:
  ///  * [getWidgetItems] for an operation that returns a [DynamiteResponse] with a stable API.
  @experimental
  DynamiteRawResponse<DashboardDashboardApiGetWidgetItemsResponseApplicationJson, void> getWidgetItemsRaw({
    final ContentString<BuiltMap<String, String>>? sinceIds,
    final int limit = 7,
    final List<String> widgets = const <String>[],
    final bool oCSAPIRequest = true,
  }) {
    const path = '/ocs/v2.php/apps/dashboard/api/v1/widget-items';
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
    if (sinceIds != null) {
      queryParameters['sinceIds'] = _jsonSerializers.serialize(
        sinceIds,
        specifiedType: const FullType(ContentString, [
          FullType(BuiltMap, [FullType(String), FullType(String)]),
        ]),
      );
    }
    if (limit != 7) {
      queryParameters['limit'] = limit.toString();
    }
    if (widgets != const <String>[]) {
      queryParameters['widgets[]'] = widgets.map((final e) => e);
    }
    headers['OCS-APIRequest'] = oCSAPIRequest.toString();
    final uri = Uri(path: path, queryParameters: queryParameters.isNotEmpty ? queryParameters : null);
    return DynamiteRawResponse<DashboardDashboardApiGetWidgetItemsResponseApplicationJson, void>(
      response: _rootClient.doRequest(
        'get',
        uri,
        headers,
        body,
        const {200},
      ),
      bodyType: const FullType(DashboardDashboardApiGetWidgetItemsResponseApplicationJson),
      headersType: null,
      serializers: _jsonSerializers,
    );
  }

  /// Get the items for the widgets.
  ///
  /// Returns a [Future] containing a [DynamiteResponse] with the status code, deserialized body and headers.
  /// Throws a [DynamiteApiException] if the API call does not return an expected status code.
  ///
  /// Parameters:
  ///   * [sinceIds] Array indexed by widget Ids, contains date/id from which we want the new items
  ///   * [limit] Limit number of result items per widget
  ///   * [widgets] Limit results to specific widgets
  ///   * [oCSAPIRequest] Required to be true for the API request to pass
  ///
  /// Status codes:
  ///   * 200: Widget items returned
  ///
  /// See:
  ///  * [getWidgetItemsV2Raw] for an experimental operation that returns a [DynamiteRawResponse] that can be serialized.
  Future<DynamiteResponse<DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson, void>> getWidgetItemsV2({
    final ContentString<BuiltMap<String, String>>? sinceIds,
    final int limit = 7,
    final List<String> widgets = const <String>[],
    final bool oCSAPIRequest = true,
  }) async {
    final rawResponse = getWidgetItemsV2Raw(
      sinceIds: sinceIds,
      limit: limit,
      widgets: widgets,
      oCSAPIRequest: oCSAPIRequest,
    );

    return rawResponse.future;
  }

  /// Get the items for the widgets.
  ///
  /// This method and the response it returns is experimental. The API might change without a major version bump.
  ///
  /// Returns a [Future] containing a [DynamiteRawResponse] with the raw [HttpClientResponse] and serialization helpers.
  /// Throws a [DynamiteApiException] if the API call does not return an expected status code.
  ///
  /// Parameters:
  ///   * [sinceIds] Array indexed by widget Ids, contains date/id from which we want the new items
  ///   * [limit] Limit number of result items per widget
  ///   * [widgets] Limit results to specific widgets
  ///   * [oCSAPIRequest] Required to be true for the API request to pass
  ///
  /// Status codes:
  ///   * 200: Widget items returned
  ///
  /// See:
  ///  * [getWidgetItemsV2] for an operation that returns a [DynamiteResponse] with a stable API.
  @experimental
  DynamiteRawResponse<DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson, void> getWidgetItemsV2Raw({
    final ContentString<BuiltMap<String, String>>? sinceIds,
    final int limit = 7,
    final List<String> widgets = const <String>[],
    final bool oCSAPIRequest = true,
  }) {
    const path = '/ocs/v2.php/apps/dashboard/api/v2/widget-items';
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
    if (sinceIds != null) {
      queryParameters['sinceIds'] = _jsonSerializers.serialize(
        sinceIds,
        specifiedType: const FullType(ContentString, [
          FullType(BuiltMap, [FullType(String), FullType(String)]),
        ]),
      );
    }
    if (limit != 7) {
      queryParameters['limit'] = limit.toString();
    }
    if (widgets != const <String>[]) {
      queryParameters['widgets[]'] = widgets.map((final e) => e);
    }
    headers['OCS-APIRequest'] = oCSAPIRequest.toString();
    final uri = Uri(path: path, queryParameters: queryParameters.isNotEmpty ? queryParameters : null);
    return DynamiteRawResponse<DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson, void>(
      response: _rootClient.doRequest(
        'get',
        uri,
        headers,
        body,
        const {200},
      ),
      bodyType: const FullType(DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson),
      headersType: null,
      serializers: _jsonSerializers,
    );
  }
}

@BuiltValue(instantiable: false)
abstract interface class DashboardOCSMetaInterface {
  String get status;
  int get statuscode;
  String? get message;
  String? get totalitems;
  String? get itemsperpage;
  DashboardOCSMetaInterface rebuild(final void Function(DashboardOCSMetaInterfaceBuilder) updates);
  DashboardOCSMetaInterfaceBuilder toBuilder();
}

abstract class DashboardOCSMeta implements DashboardOCSMetaInterface, Built<DashboardOCSMeta, DashboardOCSMetaBuilder> {
  factory DashboardOCSMeta([final void Function(DashboardOCSMetaBuilder)? b]) = _$DashboardOCSMeta;

  // coverage:ignore-start
  const DashboardOCSMeta._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory DashboardOCSMeta.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<DashboardOCSMeta> get serializer => _$dashboardOCSMetaSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class DashboardWidget_ButtonsInterface {
  String get type;
  String get text;
  String get link;
  DashboardWidget_ButtonsInterface rebuild(final void Function(DashboardWidget_ButtonsInterfaceBuilder) updates);
  DashboardWidget_ButtonsInterfaceBuilder toBuilder();
}

abstract class DashboardWidget_Buttons
    implements DashboardWidget_ButtonsInterface, Built<DashboardWidget_Buttons, DashboardWidget_ButtonsBuilder> {
  factory DashboardWidget_Buttons([final void Function(DashboardWidget_ButtonsBuilder)? b]) = _$DashboardWidget_Buttons;

  // coverage:ignore-start
  const DashboardWidget_Buttons._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory DashboardWidget_Buttons.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<DashboardWidget_Buttons> get serializer => _$dashboardWidgetButtonsSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class DashboardWidgetInterface {
  String get id;
  String get title;
  int get order;
  @BuiltValueField(wireName: 'icon_class')
  String get iconClass;
  @BuiltValueField(wireName: 'icon_url')
  String get iconUrl;
  @BuiltValueField(wireName: 'widget_url')
  String? get widgetUrl;
  @BuiltValueField(wireName: 'item_icons_round')
  bool get itemIconsRound;
  @BuiltValueField(wireName: 'item_api_versions')
  BuiltList<int> get itemApiVersions;
  @BuiltValueField(wireName: 'reload_interval')
  int get reloadInterval;
  BuiltList<DashboardWidget_Buttons>? get buttons;
  DashboardWidgetInterface rebuild(final void Function(DashboardWidgetInterfaceBuilder) updates);
  DashboardWidgetInterfaceBuilder toBuilder();
}

abstract class DashboardWidget implements DashboardWidgetInterface, Built<DashboardWidget, DashboardWidgetBuilder> {
  factory DashboardWidget([final void Function(DashboardWidgetBuilder)? b]) = _$DashboardWidget;

  // coverage:ignore-start
  const DashboardWidget._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory DashboardWidget.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<DashboardWidget> get serializer => _$dashboardWidgetSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class DashboardDashboardApiGetWidgetsResponseApplicationJson_OcsInterface {
  DashboardOCSMeta get meta;
  BuiltMap<String, DashboardWidget> get data;
  DashboardDashboardApiGetWidgetsResponseApplicationJson_OcsInterface rebuild(
    final void Function(DashboardDashboardApiGetWidgetsResponseApplicationJson_OcsInterfaceBuilder) updates,
  );
  DashboardDashboardApiGetWidgetsResponseApplicationJson_OcsInterfaceBuilder toBuilder();
}

abstract class DashboardDashboardApiGetWidgetsResponseApplicationJson_Ocs
    implements
        DashboardDashboardApiGetWidgetsResponseApplicationJson_OcsInterface,
        Built<DashboardDashboardApiGetWidgetsResponseApplicationJson_Ocs,
            DashboardDashboardApiGetWidgetsResponseApplicationJson_OcsBuilder> {
  factory DashboardDashboardApiGetWidgetsResponseApplicationJson_Ocs([
    final void Function(DashboardDashboardApiGetWidgetsResponseApplicationJson_OcsBuilder)? b,
  ]) = _$DashboardDashboardApiGetWidgetsResponseApplicationJson_Ocs;

  // coverage:ignore-start
  const DashboardDashboardApiGetWidgetsResponseApplicationJson_Ocs._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory DashboardDashboardApiGetWidgetsResponseApplicationJson_Ocs.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<DashboardDashboardApiGetWidgetsResponseApplicationJson_Ocs> get serializer =>
      _$dashboardDashboardApiGetWidgetsResponseApplicationJsonOcsSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class DashboardDashboardApiGetWidgetsResponseApplicationJsonInterface {
  DashboardDashboardApiGetWidgetsResponseApplicationJson_Ocs get ocs;
  DashboardDashboardApiGetWidgetsResponseApplicationJsonInterface rebuild(
    final void Function(DashboardDashboardApiGetWidgetsResponseApplicationJsonInterfaceBuilder) updates,
  );
  DashboardDashboardApiGetWidgetsResponseApplicationJsonInterfaceBuilder toBuilder();
}

abstract class DashboardDashboardApiGetWidgetsResponseApplicationJson
    implements
        DashboardDashboardApiGetWidgetsResponseApplicationJsonInterface,
        Built<DashboardDashboardApiGetWidgetsResponseApplicationJson,
            DashboardDashboardApiGetWidgetsResponseApplicationJsonBuilder> {
  factory DashboardDashboardApiGetWidgetsResponseApplicationJson([
    final void Function(DashboardDashboardApiGetWidgetsResponseApplicationJsonBuilder)? b,
  ]) = _$DashboardDashboardApiGetWidgetsResponseApplicationJson;

  // coverage:ignore-start
  const DashboardDashboardApiGetWidgetsResponseApplicationJson._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory DashboardDashboardApiGetWidgetsResponseApplicationJson.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<DashboardDashboardApiGetWidgetsResponseApplicationJson> get serializer =>
      _$dashboardDashboardApiGetWidgetsResponseApplicationJsonSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class DashboardWidgetItemInterface {
  String get subtitle;
  String get title;
  String get link;
  String get iconUrl;
  String get overlayIconUrl;
  String get sinceId;
  DashboardWidgetItemInterface rebuild(final void Function(DashboardWidgetItemInterfaceBuilder) updates);
  DashboardWidgetItemInterfaceBuilder toBuilder();
}

abstract class DashboardWidgetItem
    implements DashboardWidgetItemInterface, Built<DashboardWidgetItem, DashboardWidgetItemBuilder> {
  factory DashboardWidgetItem([final void Function(DashboardWidgetItemBuilder)? b]) = _$DashboardWidgetItem;

  // coverage:ignore-start
  const DashboardWidgetItem._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory DashboardWidgetItem.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<DashboardWidgetItem> get serializer => _$dashboardWidgetItemSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class DashboardDashboardApiGetWidgetItemsResponseApplicationJson_OcsInterface {
  DashboardOCSMeta get meta;
  BuiltMap<String, BuiltList<DashboardWidgetItem>> get data;
  DashboardDashboardApiGetWidgetItemsResponseApplicationJson_OcsInterface rebuild(
    final void Function(DashboardDashboardApiGetWidgetItemsResponseApplicationJson_OcsInterfaceBuilder) updates,
  );
  DashboardDashboardApiGetWidgetItemsResponseApplicationJson_OcsInterfaceBuilder toBuilder();
}

abstract class DashboardDashboardApiGetWidgetItemsResponseApplicationJson_Ocs
    implements
        DashboardDashboardApiGetWidgetItemsResponseApplicationJson_OcsInterface,
        Built<DashboardDashboardApiGetWidgetItemsResponseApplicationJson_Ocs,
            DashboardDashboardApiGetWidgetItemsResponseApplicationJson_OcsBuilder> {
  factory DashboardDashboardApiGetWidgetItemsResponseApplicationJson_Ocs([
    final void Function(DashboardDashboardApiGetWidgetItemsResponseApplicationJson_OcsBuilder)? b,
  ]) = _$DashboardDashboardApiGetWidgetItemsResponseApplicationJson_Ocs;

  // coverage:ignore-start
  const DashboardDashboardApiGetWidgetItemsResponseApplicationJson_Ocs._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory DashboardDashboardApiGetWidgetItemsResponseApplicationJson_Ocs.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<DashboardDashboardApiGetWidgetItemsResponseApplicationJson_Ocs> get serializer =>
      _$dashboardDashboardApiGetWidgetItemsResponseApplicationJsonOcsSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class DashboardDashboardApiGetWidgetItemsResponseApplicationJsonInterface {
  DashboardDashboardApiGetWidgetItemsResponseApplicationJson_Ocs get ocs;
  DashboardDashboardApiGetWidgetItemsResponseApplicationJsonInterface rebuild(
    final void Function(DashboardDashboardApiGetWidgetItemsResponseApplicationJsonInterfaceBuilder) updates,
  );
  DashboardDashboardApiGetWidgetItemsResponseApplicationJsonInterfaceBuilder toBuilder();
}

abstract class DashboardDashboardApiGetWidgetItemsResponseApplicationJson
    implements
        DashboardDashboardApiGetWidgetItemsResponseApplicationJsonInterface,
        Built<DashboardDashboardApiGetWidgetItemsResponseApplicationJson,
            DashboardDashboardApiGetWidgetItemsResponseApplicationJsonBuilder> {
  factory DashboardDashboardApiGetWidgetItemsResponseApplicationJson([
    final void Function(DashboardDashboardApiGetWidgetItemsResponseApplicationJsonBuilder)? b,
  ]) = _$DashboardDashboardApiGetWidgetItemsResponseApplicationJson;

  // coverage:ignore-start
  const DashboardDashboardApiGetWidgetItemsResponseApplicationJson._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory DashboardDashboardApiGetWidgetItemsResponseApplicationJson.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<DashboardDashboardApiGetWidgetItemsResponseApplicationJson> get serializer =>
      _$dashboardDashboardApiGetWidgetItemsResponseApplicationJsonSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class DashboardWidgetItemsInterface {
  BuiltList<DashboardWidgetItem> get items;
  String get emptyContentMessage;
  String get halfEmptyContentMessage;
  DashboardWidgetItemsInterface rebuild(final void Function(DashboardWidgetItemsInterfaceBuilder) updates);
  DashboardWidgetItemsInterfaceBuilder toBuilder();
}

abstract class DashboardWidgetItems
    implements DashboardWidgetItemsInterface, Built<DashboardWidgetItems, DashboardWidgetItemsBuilder> {
  factory DashboardWidgetItems([final void Function(DashboardWidgetItemsBuilder)? b]) = _$DashboardWidgetItems;

  // coverage:ignore-start
  const DashboardWidgetItems._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory DashboardWidgetItems.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<DashboardWidgetItems> get serializer => _$dashboardWidgetItemsSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson_OcsInterface {
  DashboardOCSMeta get meta;
  BuiltMap<String, DashboardWidgetItems> get data;
  DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson_OcsInterface rebuild(
    final void Function(DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson_OcsInterfaceBuilder) updates,
  );
  DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson_OcsInterfaceBuilder toBuilder();
}

abstract class DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson_Ocs
    implements
        DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson_OcsInterface,
        Built<DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson_Ocs,
            DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson_OcsBuilder> {
  factory DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson_Ocs([
    final void Function(DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson_OcsBuilder)? b,
  ]) = _$DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson_Ocs;

  // coverage:ignore-start
  const DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson_Ocs._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson_Ocs.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson_Ocs> get serializer =>
      _$dashboardDashboardApiGetWidgetItemsV2ResponseApplicationJsonOcsSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJsonInterface {
  DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson_Ocs get ocs;
  DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJsonInterface rebuild(
    final void Function(DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJsonInterfaceBuilder) updates,
  );
  DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJsonInterfaceBuilder toBuilder();
}

abstract class DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson
    implements
        DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJsonInterface,
        Built<DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson,
            DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJsonBuilder> {
  factory DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson([
    final void Function(DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJsonBuilder)? b,
  ]) = _$DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson;

  // coverage:ignore-start
  const DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson._();
  // coverage:ignore-end

  // coverage:ignore-start
  factory DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  // coverage:ignore-start
  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  static Serializer<DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson> get serializer =>
      _$dashboardDashboardApiGetWidgetItemsV2ResponseApplicationJsonSerializer;
}

// coverage:ignore-start
final Serializers _serializers = (Serializers().toBuilder()
      ..addBuilderFactory(
        const FullType(DashboardDashboardApiGetWidgetsResponseApplicationJson),
        DashboardDashboardApiGetWidgetsResponseApplicationJson.new,
      )
      ..add(DashboardDashboardApiGetWidgetsResponseApplicationJson.serializer)
      ..addBuilderFactory(
        const FullType(DashboardDashboardApiGetWidgetsResponseApplicationJson_Ocs),
        DashboardDashboardApiGetWidgetsResponseApplicationJson_Ocs.new,
      )
      ..add(DashboardDashboardApiGetWidgetsResponseApplicationJson_Ocs.serializer)
      ..addBuilderFactory(const FullType(DashboardOCSMeta), DashboardOCSMeta.new)
      ..add(DashboardOCSMeta.serializer)
      ..addBuilderFactory(const FullType(DashboardWidget), DashboardWidget.new)
      ..add(DashboardWidget.serializer)
      ..addBuilderFactory(const FullType(BuiltList, [FullType(int)]), ListBuilder<int>.new)
      ..addBuilderFactory(const FullType(DashboardWidget_Buttons), DashboardWidget_Buttons.new)
      ..add(DashboardWidget_Buttons.serializer)
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(DashboardWidget_Buttons)]),
        ListBuilder<DashboardWidget_Buttons>.new,
      )
      ..addBuilderFactory(
        const FullType(BuiltMap, [FullType(String), FullType(DashboardWidget)]),
        MapBuilder<String, DashboardWidget>.new,
      )
      ..addBuilderFactory(
        const FullType(BuiltMap, [FullType(String), FullType(String)]),
        MapBuilder<String, String>.new,
      )
      ..addBuilderFactory(
        const FullType(ContentString, [
          FullType(BuiltMap, [FullType(String), FullType(String)]),
        ]),
        ContentString<BuiltMap<String, String>>.new,
      )
      ..add(ContentString.serializer)
      ..addBuilderFactory(const FullType(BuiltList, [FullType(String)]), ListBuilder<String>.new)
      ..addBuilderFactory(
        const FullType(DashboardDashboardApiGetWidgetItemsResponseApplicationJson),
        DashboardDashboardApiGetWidgetItemsResponseApplicationJson.new,
      )
      ..add(DashboardDashboardApiGetWidgetItemsResponseApplicationJson.serializer)
      ..addBuilderFactory(
        const FullType(DashboardDashboardApiGetWidgetItemsResponseApplicationJson_Ocs),
        DashboardDashboardApiGetWidgetItemsResponseApplicationJson_Ocs.new,
      )
      ..add(DashboardDashboardApiGetWidgetItemsResponseApplicationJson_Ocs.serializer)
      ..addBuilderFactory(const FullType(DashboardWidgetItem), DashboardWidgetItem.new)
      ..add(DashboardWidgetItem.serializer)
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(DashboardWidgetItem)]),
        ListBuilder<DashboardWidgetItem>.new,
      )
      ..addBuilderFactory(
        const FullType(BuiltMap, [
          FullType(String),
          FullType(BuiltList, [FullType(DashboardWidgetItem)]),
        ]),
        MapBuilder<String, BuiltList>.new,
      )
      ..addBuilderFactory(
        const FullType(DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson),
        DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson.new,
      )
      ..add(DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson.serializer)
      ..addBuilderFactory(
        const FullType(DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson_Ocs),
        DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson_Ocs.new,
      )
      ..add(DashboardDashboardApiGetWidgetItemsV2ResponseApplicationJson_Ocs.serializer)
      ..addBuilderFactory(const FullType(DashboardWidgetItems), DashboardWidgetItems.new)
      ..add(DashboardWidgetItems.serializer)
      ..addBuilderFactory(
        const FullType(BuiltMap, [FullType(String), FullType(DashboardWidgetItems)]),
        MapBuilder<String, DashboardWidgetItems>.new,
      ))
    .build();

final Serializers _jsonSerializers = (_serializers.toBuilder()
      ..addPlugin(StandardJsonPlugin())
      ..addPlugin(const ContentStringPlugin()))
    .build();
// coverage:ignore-end
