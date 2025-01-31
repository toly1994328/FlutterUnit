package com.example.r_upgrade.common.tasks;

import android.app.DownloadManager;
import android.content.Context;
import android.database.Cursor;
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
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

import static android.content.Context.DOWNLOAD_SERVICE;

public class GenerateAndInstallAsyncTask extends AsyncTask<Integer, Integer, Uri> {
    private static final String TAG = "r_upgrade.AsyncTask";
    final WeakReference<Context> contextWrapper;
    boolean isUserDownloadManager;
    MethodChannel.Result result;
    private BaseInstallFactory installFactory;

    public GenerateAndInstallAsyncTask(Context context, boolean isUserDownloadManager, MethodChannel.Result result,
                                       BaseInstallFactory installFactory) {
        this.contextWrapper = new WeakReference<Context>(context);
        this.isUserDownloadManager = isUserDownloadManager;
        this.result = result;
        this.installFactory = installFactory;
    }

    @Override
    protected Uri doInBackground(Integer... integers) {
        Uri uri = null;
        try {
            int id = integers[0];
            if (this.isUserDownloadManager) {
                DownloadManager manager = (DownloadManager) contextWrapper.get().getSystemService(DOWNLOAD_SERVICE);
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                    uri = manager.getUriForDownloadedFile(id);
                } else {
                    DownloadManager.Query query = new DownloadManager.Query();
                    Cursor cursor = manager.query(query.setFilterById(id));
                    cursor.moveToNext();
                    String address = cursor.getString(cursor.getColumnIndex(DownloadManager.COLUMN_LOCAL_URI));
                    uri = Uri.parse(address);
                    cursor.close();
                }
            } else {
                Map<String, Object> map = UpgradeSQLite.getInstance(contextWrapper.get()).queryById(id);
                if (map == null) return null;
                int upgradeFlavor = (int) map.get(UpgradeSQLite.UPGRADE_FLAVOR);
                String path = (String) map.get(UpgradeSQLite.PATH);
                File file = new File(path);
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                    uri = RUpgradeFileProvider.getUriForFile(contextWrapper.get(), contextWrapper.get().getApplicationInfo().packageName + ".fileProvider", file);
                } else {
                    uri = Uri.fromFile(file);
                }
                if (installFactory != null && installFactory instanceof SilentInstallFactory) {
                    uri = Uri.parse(file.getPath());
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
                    if (installFactory != null && installFactory instanceof SilentInstallFactory) {
                        uri = Uri.parse(file.getPath());
                    }
                } else if (upgradeFlavor == UpgradeSQLite.UPGRADE_FLAVOR_HOT_UPDATE) {
                    boolean isSuccess = new HotUpgradeManager(contextWrapper.get()).hotUpgrade(uri);
                    if (isSuccess) {
                        return Uri.parse("");
                    } else {
                        return null;
                    }
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
