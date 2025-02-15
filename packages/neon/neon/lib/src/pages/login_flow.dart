import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:neon/l10n/localizations.dart';
import 'package:neon/src/bloc/result_builder.dart';
import 'package:neon/src/blocs/login_flow.dart';
import 'package:neon/src/router.dart';
import 'package:neon/src/widgets/error.dart';
import 'package:neon/src/widgets/linear_progress_indicator.dart';
import 'package:url_launcher/url_launcher_string.dart';

@internal
class LoginFlowPage extends StatefulWidget {
  const LoginFlowPage({
    required this.serverURL,
    super.key,
  });

  final Uri serverURL;

  @override
  State<LoginFlowPage> createState() => _LoginFlowPageState();
}

class _LoginFlowPageState extends State<LoginFlowPage> {
  late final LoginFlowBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = LoginFlowBloc(widget.serverURL);

    bloc.init.listen((final result) async {
      if (result.hasData) {
        await launchUrlString(
          result.requireData.login,
          mode: LaunchMode.externalApplication,
        );
      }
    });

    bloc.result.listen((final result) {
      LoginCheckAccountRoute(
        serverUrl: Uri.parse(result.server),
        loginName: result.loginName,
        password: result.appPassword,
      ).pushReplacement(context);
    });
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ResultBuilder.behaviorSubject(
              stream: bloc.init,
              builder: (final context, final init) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NeonLinearProgressIndicator(
                    visible: init.isLoading,
                  ),
                  NeonError(
                    init.error,
                    onRetry: bloc.refresh,
                  ),
                  if (init.hasData) ...[
                    Text(AppLocalizations.of(context).loginSwitchToBrowserWindow),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: bloc.refresh,
                      child: Text(AppLocalizations.of(context).loginOpenAgain),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
}
