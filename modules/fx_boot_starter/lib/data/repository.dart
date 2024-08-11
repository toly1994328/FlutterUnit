
abstract class AppStartRepository<S> {
  const AppStartRepository();

  Future<S> initApp();

  Future<void> fixError(Object error, {Object? extra});
}


