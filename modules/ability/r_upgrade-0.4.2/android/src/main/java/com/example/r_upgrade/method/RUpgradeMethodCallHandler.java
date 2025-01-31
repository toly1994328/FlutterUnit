package com.example.r_upgrade.method;

import androidx.annotation.NonNull;

import com.example.r_upgrade.common.manager.UpgradeManager;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class RUpgradeMethodCallHandler implements MethodChannel.MethodCallHandler {
    private final UpgradeManager upgradeManager;

    public RUpgradeMethodCallHandler(UpgradeManager upgradeManager) {
        this.upgradeManager = upgradeManager;
    }

    @Override
    public void onMethodCall(MethodCall call, @NonNull MethodChannel.Result result) {
        RUpgradeMethodEnum methodEnum = RUpgradeMethodEnum.valueOf(call.method);
        methodEnum.handler(upgradeManager,call, result);
    }
}
