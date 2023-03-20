import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/locale/app_localization.dart';
import 'package:flutter_application_1/locale/app_localization_keys.dart';
import 'package:flutter_application_1/locale/locale_cubit.dart';
import 'package:flutter_application_1/preferences/preferences_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(
          create: (context) => LocaleCubit(PreferencesManager()),
        ),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
            locale: state,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!
            .translate(LocalizationKeys.fullAppName)!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  AppLocalizations.of(context)!.locale.languageCode;

                  context.read<LocaleCubit>().changeLocale(
                        AppLocalizations.of(context)!.isRTL()
                            ? LocaleApp.en
                            : LocaleApp.ar,
                      );
                },
                child: Text(AppLocalizations.of(context)!
                    .translate(LocalizationKeys.language)!)),
            ElevatedButton(
                onPressed: () {
                  context.read<LocaleCubit>().changeLocale(LocaleApp.ar);
                },
                child: const Text("Change To Ar")),
            ElevatedButton(
                onPressed: () {
                  context.read<LocaleCubit>().changeLocale(LocaleApp.en);
                },
                child: const Text("Change To En")),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
