package com.example.r_upgrade.common;

import android.util.Log;

public class RUpgradeLogger {
    private static RUpgradeLogger _logger;

    public static RUpgradeLogger get() {
        if (_logger == null) {
            _logger = new RUpgradeLogger();
        }
        return _logger;
    }

    private boolean isDebug = true;


    public void setDebug(boolean isDebug) {
        this.isDebug = isDebug;
    }

    public void d(String tag, String content) {
        if (isDebug) {
            Log.d(tag, content);
        }
    }
}
