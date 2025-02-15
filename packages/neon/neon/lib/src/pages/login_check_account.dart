import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:neon/l10n/localizations.dart';
import 'package:neon/src/bloc/result.dart';
import 'package:neon/src/bloc/result_builder.dart';
import 'package:neon/src/blocs/accounts.dart';
import 'package:neon/src/blocs/login_check_account.dart';
import 'package:neon/src/models/account.dart';
import 'package:neon/src/router.dart';
import 'package:neon/src/theme/dialog.dart';
import 'package:neon/src/utils/provider.dart';
import 'package:neon/src/widgets/account_tile.dart';
import 'package:neon/src/widgets/error.dart';
import 'package:neon/src/widgets/validation_tile.dart';

@internal
class LoginCheckAccountPage extends StatefulWidget {
  const LoginCheckAccountPage({
    required this.serverURL,
    required this.loginName,
    required this.password,
    super.key,
  });

  final Uri serverURL;
  final String loginName;
  final String password;

  @override
  State<LoginCheckAccountPage> createState() => _LoginCheckAccountPageState();
}

class _LoginCheckAccountPageState extends State<LoginCheckAccountPage> {
  late final LoginCheckAccountBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = LoginCheckAccountBloc(
      widget.serverURL,
      widget.loginName,
      widget.password,
    );
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
            child: ConstrainedBox(
              constraints: NeonDialogTheme.of(context).constraints,
              child: ResultBuilder.behaviorSubject(
                stream: bloc.state,
                builder: (final context, final state) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state.hasError) ...[
                      Builder(
                        builder: (final context) {
                          final details = NeonError.getDetails(state.error);
                          return NeonValidationTile(
                            title: details.isUnauthorized
                                ? AppLocalizations.of(context).errorCredentialsForAccountNoLongerMatch
                                : details.getText(context),
                            state: ValidationState.failure,
                          );
                        },
                      ),
                    ],
                    _buildAccountTile(state),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: state.hasData
                            ? () {
                                NeonProvider.of<AccountsBloc>(context)
                                  ..updateAccount(state.requireData)
                                  ..setActiveAccount(state.requireData);

                                const HomeRoute().go(context);
                              }
                            : () {
                                if (state.hasError && NeonError.getDetails(state.error).isUnauthorized) {
                                  Navigator.pop(context);
                                  return;
                                }

                                unawaited(bloc.refresh());
                              },
                        child: Text(
                          state.hasData
                              ? AppLocalizations.of(context).actionContinue
                              : AppLocalizations.of(context).actionRetry,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget _buildAccountTile(final Result<Account> result) {
    if (result.hasError) {
      return NeonValidationTile(
        title: AppLocalizations.of(context).loginCheckingAccount,
        state: ValidationState.canceled,
      );
    }

    if (result.hasData) {
      return NeonAccountTile(
        account: result.requireData,
        showStatus: false,
      );
    }

    return NeonValidationTile(
      title: AppLocalizations.of(context).loginCheckingAccount,
      state: ValidationState.loading,
    );
  }
}
