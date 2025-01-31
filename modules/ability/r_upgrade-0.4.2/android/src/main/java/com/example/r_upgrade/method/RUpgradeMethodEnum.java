package com.example.r_upgrade.method;


import com.example.r_upgrade.common.RUpgradeLogger;
import com.example.r_upgrade.common.manager.UpgradeManager;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;


public enum RUpgradeMethodEnum implements IRUpgradeMethodHandler {
    setDebug {
        @Override
        public void handler(UpgradeManager upgradeManager, MethodCall call, MethodChannel.Result result) {
            RUpgradeLogger.get().setDebug((Boolean) call.argument("isDebug") == Boolean.TRUE);
            result.success(null);
        }
    },
    upgrade {
        @Override
        public void handler(UpgradeManager upgradeManager, MethodCall call, MethodChannel.Result result) {
            upgradeManager.upgrade((String) call.argument("url"),
                    (Map<String, String>) call.argument("header"),
                    (String) call.argument("fileName"),
                    (Integer) call.argument("notificationVisibility"),
                    (Integer) call.argument("notificationStyle"),
                    (Integer) call.argument("installType"),
                    (Boolean) call.argument("useDownloadManager"), (Integer) call.argument("upgradeFlavor"), result);
        }
    },
    upgradeFromUrl {
        @Override
        public void handler(UpgradeManager upgradeManager, MethodCall call, MethodChannel.Result result) {
            result.success(upgradeManager.upgradeFromUrl((String) call.argument("url")));
        }
    },

    cancel {
        @Override
        public void handler(UpgradeManager upgradeManager, MethodCall call, MethodChannel.Result result) {
            result.success(upgradeManager.cancel((Integer) call.argument("id")));

        }
    },
    install {
        @Override
        public void handler(UpgradeManager upgradeManager, MethodCall call, MethodChannel.Result result) {
            upgradeManager.installApkById((Integer) call.argument("id"),(Integer) call.argument("installType"), result);
        }
    },
    installByPath {
        @Override
        public void handler(UpgradeManager upgradeManager, MethodCall call, MethodChannel.Result result) {
            upgradeManager.installApkByPath((String) call.argument("path"), (Integer) call.argument("flavor"), (Integer) call.argument("installType"), result);
        }
    },
    pause {
        @Override
        public void handler(UpgradeManager upgradeManager, MethodCall call, MethodChannel.Result result) {
            result.success(upgradeManager.pause((Integer) call.argument("id")));
        }
    },
    upgradeWithId {
        @Override
        public void handler(UpgradeManager upgradeManager, MethodCall call, MethodChannel.Result result) {
            upgradeManager.upgradeWithId((Integer) call.argument("id"), (Integer) call.argument("notificationVisibility"),
                    (Integer) call.argument("installType"), result);
        }
    },
    getDownloadStatus {
        @Override
        public void handler(UpgradeManager upgradeManager, MethodCall call, MethodChannel.Result result) {
            result.success(upgradeManager.getDownloadStatus((Integer) call.argument("id")));
        }
    },
    getLastUpgradedId {
        @Override
        public void handler(UpgradeManager upgradeManager, MethodCall call, MethodChannel.Result result) {
            result.success(upgradeManager.getLastUpgradedId());
        }
    },
    upgradeFromAndroidStore {
        @Override
        public void handler(UpgradeManager upgradeManager, MethodCall call, MethodChannel.Result result) {
            result.success(upgradeManager.upgradeFromAndroidStore((String) call.argument("store")));
        }
    },
    androidStores {
        @Override
        public void handler(UpgradeManager upgradeManager, MethodCall call, MethodChannel.Result result) {
            result.success(upgradeManager.getAndroidStores());
        }
    },
    getVersionFromAndroidStore {
        @Override
        public void handler(UpgradeManager upgradeManager, MethodCall call, MethodChannel.Result result) {
            upgradeManager.getVersionFromAndroidStore((String) call.argument("store"), result);
        }
    }

}
