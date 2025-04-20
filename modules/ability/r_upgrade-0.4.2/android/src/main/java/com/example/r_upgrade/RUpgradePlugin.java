package com.example.r_upgrade;

import android.app.Activity;
import android.content.Intent;

import androidx.annotation.NonNull;

import com.example.r_upgrade.common.DownloadPermissions;
import com.example.r_upgrade.common.manager.UpgradeManager;
import com.example.r_upgrade.common.UpgradeService;
import com.example.r_upgrade.method.RUpgradeMethodCallHandler;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
//import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * RUpgradePlugin
 */
public class RUpgradePlugin implements FlutterPlugin, ActivityAware {
    private static final String PLUGIN_METHOD_NAME = "com.rhyme/r_upgrade_method";

    private MethodChannel _channel;
    private UpgradeManager upgradeManager;
    private FlutterPluginBinding flutterPluginBinding;

    public RUpgradePlugin() {

    }

    private RUpgradePlugin(Activity activity, BinaryMessenger messenger, DownloadPermissions.PermissionsRegistry permissionsRegistry) {
        initPlugin(activity, messenger, permissionsRegistry);
    }

    private void initPlugin(Activity activity, BinaryMessenger messenger, DownloadPermissions.PermissionsRegistry permissionsRegistry) {
        _channel = new MethodChannel(messenger, PLUGIN_METHOD_NAME);
        upgradeManager = new UpgradeManager(activity, _channel, new DownloadPermissions(), permissionsRegistry);
        _channel.setMethodCallHandler(new RUpgradeMethodCallHandler(upgradeManager));
    }

//    /**
//     * Plugin registration.
//     */
//    public static void registerWith(final Registrar registrar) {
//
//        new RUpgradePlugin(registrar.activity(), registrar.messenger(), new DownloadPermissions.PermissionsRegistry() {
//            @Override
//            public void addListener(PluginRegistry.RequestPermissionsResultListener handler) {
//                registrar.addRequestPermissionsResultListener(handler);
//            }
//        });
//    }


    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        this.flutterPluginBinding = binding;

    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        onDetachedFromActivity();
        flutterPluginBinding = null;
    }


    @Override
    public void onAttachedToActivity(@NonNull final ActivityPluginBinding binding) {
        initPlugin(binding.getActivity(), flutterPluginBinding.getBinaryMessenger(), new DownloadPermissions.PermissionsRegistry() {
            @Override
            public void addListener(PluginRegistry.RequestPermissionsResultListener handler) {
                binding.addRequestPermissionsResultListener(handler);
            }
        });
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivity() {
        Intent intent = new Intent(flutterPluginBinding.getApplicationContext(), UpgradeService.class);
        flutterPluginBinding.getApplicationContext().stopService(intent);
        if (upgradeManager != null) {
            upgradeManager.dispose();
            upgradeManager = null;
        }
        if (_channel != null) {
            _channel.setMethodCallHandler(null);
            _channel = null;
        }
    }
}
