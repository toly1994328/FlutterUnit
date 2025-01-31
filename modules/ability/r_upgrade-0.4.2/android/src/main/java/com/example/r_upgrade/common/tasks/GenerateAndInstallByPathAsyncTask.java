package com.example.r_upgrade.common.tasks;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Build;

import com.example.r_upgrade.RUpgradeFileProvider;
import com.example.r_upgrade.common.install.BaseInstallFactory;
import com.example.r_upgrade.common.install.SilentInstallFactory;
import com.example.r_upgrade.common.manager.HotUpgradeManager;
import com.example.r_upgrade.common.manager.IncrementUpgradeManager;
import com.example.r_upgrade.common.RUpgradeLogger;
import com.example.r_upgrade.common.UpgradeSQLite;

import java.io.File;
import java.lang.ref.WeakReference;

import io.flutter.plugin.common.MethodChannel;

public class GenerateAndInstallByPathAsyncTask extends AsyncTask<String, Integer, Uri> {
    private static final String TAG = "r_upgrade.AsyncTask";
    final WeakReference<Context> contextWrapper;
    MethodChannel.Result result;
    final String path;
    final int upgradeFlavor;
    private BaseInstallFactory installFactory;

    public GenerateAndInstallByPathAsyncTask(Context context, String path, int upgradeFlavor, MethodChannel.Result result, BaseInstallFactory installFactory) {
        this.contextWrapper = new WeakReference<Context>(context);
        this.path = path;
        this.upgradeFlavor = upgradeFlavor;
        this.result = result;
        this.installFactory = installFactory;
    }

    @Override
    protected Uri doInBackground(String... integers) {
        Uri uri = null;
        try {
            File file = new File(path);
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                uri = RUpgradeFileProvider.getUriForFile(contextWrapper.get(), contextWrapper.get().getApplicationInfo().packageName + ".fileProvider", file);
            } else {
                uri = Uri.fromFile(file);
            }
            if(installFactory != null && installFactory instanceof SilentInstallFactory){
                uri= Uri.parse(file.getPath());
            }
            if (upgradeFlavor == UpgradeSQLite.UPGRADE_FLAVOR_INCREMENT) {
                String newPath = new IncrementUpgradeManager(contextWrapper.get()).mixinAndGetNewApk(path);
                RUpgradeLogger.get().d(TAG, "合成成功，新的安装包路径：" + newPath);
                if (newPath == null) return null;
                file = new File(newPath);
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                    uri = RUpgradeFileProvider.getUriForFile(contextWrapper.get(), contextWrapper.get().getApplicationInfo().packageName + ".fileProvider", file);
                } else {
                    uri = Uri.fromFile(file);
                }
                if(installFactory != null && installFactory instanceof SilentInstallFactory){
                    uri= Uri.parse(file.getPath());
                }
            } else if (upgradeFlavor == UpgradeSQLite.UPGRADE_FLAVOR_HOT_UPDATE) {
                boolean isSuccess = new HotUpgradeManager(contextWrapper.get()).hotUpgrade(uri);
                if (isSuccess) {
                    return Uri.parse("");
                } else {
                    return null;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return uri;
    }

    @Override
    protected void onPostExecute(Uri uri) {
        super.onPostExecute(uri);
        try {
            if (uri != null) {
                if (uri.toString().isEmpty()) {
                    //热更新实现
                    postResult(true);
                } else {
                    postResult(installApk(uri));
                }
            } else {
                postResult(false);
            }
        } catch (Exception e) {
            e.printStackTrace();
            postResult(false);

        }
    }

    private void postResult(boolean isSuccess) {
        if (result != null) {
            result.success(isSuccess);
        }
    }

    //安装apk
    private boolean installApk(Uri uri) {
        if (installFactory == null) return true;
        return installFactory.install(uri);
    }
}
