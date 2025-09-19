//Here we donot need to call the state list like the provider
//If we provide the Provider Scope in main we can access the state list for the app globally 
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final localizationState = ref.watch(localizationProvider);

    return MaterialApp.router(
      theme: themeState.currentTheme,
      locale: localizationState.currentLocale,
      routerConfig: appRouter,
    );
  }
}
