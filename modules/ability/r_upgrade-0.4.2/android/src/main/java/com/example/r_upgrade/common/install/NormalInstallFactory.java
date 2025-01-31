package com.example.r_upgrade.common.install;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;

import com.example.r_upgrade.common.RUpgradeLogger;

public class NormalInstallFactory extends BaseInstallFactory {

    private static final String TAG = "NormalInstall";

    public NormalInstallFactory(Context base) {
        super(base);
    }

    @Override
    public boolean install(Uri uri) {
        Intent install = new Intent(Intent.ACTION_VIEW);
        RUpgradeLogger.get().d(TAG, uri.toString());
        install.setDataAndType(uri, "application/vnd.android.package-archive");
        install.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            install.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        } else {
            install.addCategory(Intent.CATEGORY_DEFAULT);
        }
        startActivity(install);
        return true;
    }
}
