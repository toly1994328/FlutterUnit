window.addEventListener('load', function(ev) {
 // Download main.dart.js
    _flutter.loader.load({
    {{flutter_js}}
    {{flutter_build_config}}
    serviceWorker: {
        serviceWorkerVersion: {{flutter_service_worker_version}},
    },
    onEntrypointLoaded: function(engineInitializer) {
        engineInitializer.initializeEngine().then(function(appRunner) {
            document.getElementById("app_splash")?.remove();
            appRunner.runApp();
        });
    }
});
})