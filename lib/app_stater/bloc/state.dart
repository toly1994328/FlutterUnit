sealed class AppStatus {
  const AppStatus();
}

class AppStarting extends AppStatus {
  const AppStarting();
}

class AppLoadDone extends AppStatus {
  final int cost;
  const AppLoadDone(this.cost);
}

class AppStartSuccess extends AppStatus {
  const AppStartSuccess();
}

class AppStartFailed extends AppStatus {
  final String error;

  const AppStartFailed(this.error);
}
