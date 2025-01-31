package com.example.r_upgrade.common.manager;

import android.app.Activity;
import android.app.DownloadManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.text.TextUtils;

import androidx.annotation.Nullable;

import com.example.r_upgrade.common.DownloadStatus;
import com.example.r_upgrade.common.RUpgradeLogger;
import com.example.r_upgrade.common.ResultMap;
import com.example.r_upgrade.common.DownloadPermissions;
import com.example.r_upgrade.common.UpgradeNotification;
import com.example.r_upgrade.common.UpgradeNotificationStyle;
import com.example.r_upgrade.common.UpgradeSQLite;
import com.example.r_upgrade.common.UpgradeService;
import com.example.r_upgrade.common.install.BaseInstallFactory;
import com.example.r_upgrade.common.install.NormalInstallFactory;
import com.example.r_upgrade.common.install.SilentInstallFactory;
import com.example.r_upgrade.common.tasks.CheckGooglePlayVersionTask;
import com.example.r_upgrade.common.tasks.CheckTencentStoreVersionTask;
import com.example.r_upgrade.common.tasks.CheckXiaoMiStoreVersionTask;
import com.example.r_upgrade.common.tasks.GenerateAndInstallAsyncTask;
import com.example.r_upgrade.common.tasks.GenerateAndInstallByPathAsyncTask;
import com.example.r_upgrade.common.tasks.VersionCallBack;

import org.json.JSONObject;

import java.io.File;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import io.flutter.plugin.common.MethodChannel;


public class UpgradeManager extends ContextWrapper {
    private static final String TAG = "r_upgrade.Manager";
    //广播的action
    public static final String DOWNLOAD_STATUS = "com.example.r_upgrade.DOWNLOAD_STATUS";
    public static final String DOWNLOAD_INSTALL = "com.example.r_upgrade.DOWNLOAD_INSTALL";

    public static final String PARAMS_ID = "id";
    public static final String PARAMS_STATUS = "status";
    public static final String PARAMS_CURRENT_LENGTH = "current_length";
    public static final String PARAMS_MAX_LENGTH = "max_length";
    public static final String PARAMS_PLAN_TIME = "plan_time";
    public static final String PARAMS_SPEED = "speed";
    public static final String PARAMS_PERCENT = "percent";
    public static final String PARAMS_PATH = "path";
    public static final String PARAMS_APK_NAME = "apk_name";
    public static final String PARAMS_PACKAGE = "packages";
    //速度
    private double lastProgress = 0;
    //最后更新的时间
    private long lastTime = 0;

    private Timer timer;

    private BaseInstallFactory installFactory;

    private boolean isUseDownloadManager = false;

    private Integer notificationVisibility = 0;
    private UpgradeNotificationStyle notificationStyle = UpgradeNotificationStyle.none;


    private BroadcastReceiver downloadReceiver;

    private MethodChannel channel;

    private DownloadPermissions.PermissionsRegistry permissionsRegistry;
    private DownloadPermissions downloadPermissions;
    private Activity activity;


    public void dispose() {
        unregisterReceiver(downloadReceiver);
    }

    public UpgradeManager(Activity base, MethodChannel channel, DownloadPermissions storagePermissions, DownloadPermissions.PermissionsRegistry permissionsRegistry) {
        super(base);
        this.activity = base;
        this.downloadPermissions = storagePermissions;
        this.permissionsRegistry = permissionsRegistry;
        this.channel = channel;
        UpgradeSQLite.getInstance(this).pauseDownloading();
        IntentFilter filter = new IntentFilter();
        filter.addAction(DownloadManager.ACTION_DOWNLOAD_COMPLETE);
        filter.addAction(UpgradeManager.DOWNLOAD_STATUS);
        filter.addAction(UpgradeManager.DOWNLOAD_INSTALL);
        downloadReceiver = createBroadcastReceiver();
        registerReceiver(downloadReceiver, filter);
    }


    public void upgrade(final String url, final Map<String, String> header, final String apkName, final Integer notificationVisibility, Integer notificationStyle, Integer installType, Boolean useDownloadManager, final Integer upgradeFlavor, final MethodChannel.Result result) {
        installFactory = installTypeToFactory(installType);
        this.isUseDownloadManager = Boolean.TRUE == useDownloadManager;
        if (notificationStyle != null) {
            this.notificationStyle = UpgradeNotificationStyle.values()[notificationStyle];
        } else {
            this.notificationStyle = UpgradeNotificationStyle.none;
        }
        this.notificationVisibility = notificationVisibility;

        downloadPermissions.requestPermissions(activity, permissionsRegistry, notificationVisibility,new DownloadPermissions.ResultCallback() {
            @Override
            public void onResult(String errorCode, String errorDescription) {
                if (errorCode == null) {
                    long id = 0;

                    if (isUseDownloadManager) {
                        DownloadManager manager = (DownloadManager) getSystemService(DOWNLOAD_SERVICE);
                        DownloadManager.Request request = new DownloadManager.Request(Uri.parse(url));
                        if (header != null) {
                            for (Map.Entry<String, String> entry : header.entrySet()) {
                                request.addRequestHeader(entry.getKey(), entry.getValue());
                            }
                        }
                        if (notificationVisibility != null) {
                            request.setNotificationVisibility(notificationVisibility);
                        } else {
                            request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
                        }
                        request.setMimeType("application/vnd.android.package-archive");

                        request.setDestinationInExternalPublicDir(Environment.DIRECTORY_DOWNLOADS, apkName == null ? "release.apk" : apkName);

                        request.setTitle(apkName == null ? "upgradePackage.apk" : apkName);
                        id = manager.enqueue(request);
                        if (timer != null) {
                            timer.cancel();
                        }
                        timer = new Timer();
                        final long finalId = id;
                        timer.schedule(new TimerTask() {
                            @Override
                            public void run() {
                                queryTask(finalId);
                            }
                        }, 0, 500);
                        RUpgradeLogger.get().d(TAG, "upgrade: " + id);
                    } else {
                        id = UpgradeSQLite.getInstance(activity).createRecord(activity, url, apkName, header == null ? "" : new JSONObject(header).toString(), DownloadStatus.STATUS_PENDING.getValue(), upgradeFlavor);

                        Intent intent = new Intent(activity, UpgradeService.class);
                        Bundle bundle = new Bundle();
                        bundle.putBoolean(UpgradeService.DOWNLOAD_RESTART, false);
                        bundle.putInt(UpgradeService.DOWNLOAD_ID, (int) id);
                        bundle.putString(UpgradeService.DOWNLOAD_URL, url);
                        bundle.putString(UpgradeService.DOWNLOAD_APK_NAME, apkName);
                        bundle.putSerializable(UpgradeService.DOWNLOAD_Header, (Serializable) header);
                        intent.putExtras(bundle);
                        startService(intent);
                    }
                    result.success(id);
                } else {
                    result.error(errorCode, errorDescription, null);
                }
            }
        });
    }

    //取消下载
    public boolean cancel(Integer id) {
        if (id == null) return false;
        if (isUseDownloadManager) {
            DownloadManager manager = (DownloadManager) getSystemService(DOWNLOAD_SERVICE);
            return manager.remove(id) == 1;
        } else {
            Intent intent = new Intent(UpgradeService.RECEIVER_CANCEL);
            intent.putExtra(PARAMS_PACKAGE, getPackageName());
            intent.putExtra(PARAMS_ID, id);
            sendBroadcast(intent);
            return true;
        }
    }

    //暂停下载
    public boolean pause(Integer id) {
        if (id == null) return false;
        Intent intent = new Intent(UpgradeService.RECEIVER_PAUSE);
        intent.putExtra(PARAMS_PACKAGE, getPackageName());
        intent.putExtra(PARAMS_ID, id);
        sendBroadcast(intent);
        return true;
    }


    //查询进度
    public void queryTask(long id) {
        DownloadManager manager = (DownloadManager) getSystemService(DOWNLOAD_SERVICE);
        DownloadManager.Query query = new DownloadManager.Query();
        Cursor cursor = manager.query(query.setFilterById(id));
        if (cursor != null && cursor.moveToFirst()) {
            int status = cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_STATUS));
            Intent intent = new Intent();
            switch (status) {
                case DownloadManager.STATUS_PAUSED:
                    RUpgradeLogger.get().d(TAG, "queryTask: 下载被暂停");
                    intent.setAction(DOWNLOAD_STATUS);
                    intent.putExtra(PARAMS_STATUS, DownloadStatus.STATUS_PAUSED.getValue());
                    intent.putExtra(PARAMS_ID, id);
                    intent.putExtra(PARAMS_PACKAGE, getPackageName());
                    sendBroadcast(intent);
                    break;
                case DownloadManager.STATUS_PENDING:
                    RUpgradeLogger.get().d(TAG, "queryTask: 下载延迟==========>总大小:");
                    intent.setAction(DOWNLOAD_STATUS);
                    intent.putExtra(PARAMS_STATUS, DownloadStatus.STATUS_PENDING.getValue());
                    intent.putExtra(PARAMS_ID, id);
                    intent.putExtra(PARAMS_PACKAGE, getPackageName());
                    sendBroadcast(intent);
                    break;
                case DownloadManager.STATUS_RUNNING:
                    //已经下载的字节数
                    int progress = cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_BYTES_DOWNLOADED_SO_FAR));
                    if (lastProgress == 0) {
                        lastProgress = progress;
                        lastTime = System.currentTimeMillis();
                    }
                    //下载的文件到本地的目录
                    String address = cursor.getString(cursor.getColumnIndex(DownloadManager.COLUMN_LOCAL_URI));
                    //总需下载的字节数
                    int total = cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_TOTAL_SIZE_BYTES));
                    //下载速度
                    double speed = ((progress - lastProgress) * 1000f / (System.currentTimeMillis() - lastTime)) / 1024;
                    //下载文件的URL链接
                    String url = cursor.getString(cursor.getColumnIndex(DownloadManager.COLUMN_URI));

                    //计划完成时间
                    double planTime = (total - progress) / (speed * 1024f);
                    //当前进度
                    double percent = new BigDecimal((progress * 1.0f / total) * 100).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
                    if (progress - lastProgress > 0) {
                        RUpgradeLogger.get().d(TAG, "queryTask: 下载中\n" +
                                "url: " +
                                url +
                                "\n============>" +
                                "total:" +
                                total +
                                "，" +
                                "progress:" +
                                progress +
                                "，" +
                                String.format(Locale.getDefault(), "%.2f", percent) +
                                "% , " +
                                String.format(Locale.getDefault(), "%.2f", speed) +
                                "kb/s , " +
                                "预计：" +
                                String.format(Locale.getDefault(), "%.0f", planTime) +
                                "s");
                        intent.setAction(DOWNLOAD_STATUS);

                        intent.putExtra(PARAMS_ID, id);
                        intent.putExtra(PARAMS_CURRENT_LENGTH, progress);
                        intent.putExtra(PARAMS_STATUS, DownloadStatus.STATUS_RUNNING.getValue());
                        intent.putExtra(PARAMS_PERCENT, percent);
                        intent.putExtra(PARAMS_MAX_LENGTH, total);
                        intent.putExtra(PARAMS_SPEED, speed);
                        intent.putExtra(PARAMS_PLAN_TIME, planTime);
                        intent.putExtra(PARAMS_PATH, address);
                        intent.putExtra(PARAMS_PACKAGE, getPackageName());
                        sendBroadcast(intent);
                        lastProgress = progress;
                        lastTime = System.currentTimeMillis();
                    }
                    break;
                case DownloadManager.STATUS_SUCCESSFUL:
                    RUpgradeLogger.get().d(TAG, "queryTask: 下载成功");
                    if (timer != null) {
                        timer.cancel();
                        timer = null;
                    }
                    installApkById((int) id);
                    intent.setAction(DOWNLOAD_STATUS);
                    intent.putExtra(PARAMS_STATUS, DownloadStatus.STATUS_SUCCESSFUL.getValue());
                    intent.putExtra(PARAMS_ID, id);
                    intent.putExtra(PARAMS_PACKAGE, getPackageName());
                    sendBroadcast(intent);
                    lastProgress = 0;
                    break;
                case DownloadManager.STATUS_FAILED:
                    RUpgradeLogger.get().d(TAG, "queryTask: 下载失败");
                    intent.setAction(DOWNLOAD_STATUS);
                    intent.putExtra(PARAMS_STATUS, DownloadStatus.STATUS_FAILED.getValue());
                    intent.putExtra(PARAMS_ID, id);
                    intent.putExtra(PARAMS_PACKAGE, getPackageName());
                    sendBroadcast(intent);
                    lastProgress = 0;
                    break;
            }
        }
        if (cursor != null) {
            cursor.close();
        }
    }


    public void installApkById(int id) {
        installApkById(id, -1, null);
    }

    public void installApkById(final int id, int installType, final MethodChannel.Result result) {
        if (installType != -1) {
            installFactory = installTypeToFactory(installType);
        }
        if (installFactory == null) return;
        downloadPermissions.requestPermissions(activity, permissionsRegistry,notificationVisibility, new DownloadPermissions.ResultCallback() {
            @Override
            public void onResult(String errorCode, String errorDescription) {
                if (errorCode == null) {
                    new GenerateAndInstallAsyncTask(activity, isUseDownloadManager, result, installFactory).execute(id);
                } else {
                    if (result != null) {
                        result.error(errorCode, errorDescription, null);
                    }
                }
            }
        });
    }

    private BaseInstallFactory installTypeToFactory(int installType) {
        BaseInstallFactory installFactory;
        if (installType == 0) {
            installFactory = new NormalInstallFactory(this);
        } else if (installType == 1) {
            installFactory = new SilentInstallFactory(this);
        } else {
            installFactory = null;
        }
        return installFactory;
    }


    public void installApkByPath(final String path, final int upgradeFlavor, int installType, final MethodChannel.Result result) {
        installFactory = installTypeToFactory(installType);

        downloadPermissions.requestPermissions(activity, permissionsRegistry,notificationVisibility, new DownloadPermissions.ResultCallback() {
            @Override
            public void onResult(String errorCode, String errorDescription) {
                if (errorCode == null) {
                    File installPath = new File(path);
                    if (installPath.exists()) {
                        new GenerateAndInstallByPathAsyncTask(activity, path, upgradeFlavor, result, installFactory).execute();

                    } else {
                        result.error("file not exists", "file path:" + path + " is not exists", null);
                    }
                } else {
                    if (result != null) {
                        result.error(errorCode, errorDescription, null);
                    }
                }
            }
        });
    }


    public BroadcastReceiver createBroadcastReceiver() {
        return new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                String packageName = intent.getStringExtra(PARAMS_PACKAGE);
                if (packageName == null || !packageName.equals(getPackageName())) {
                    return;
                }
                if (intent != null && intent.getAction() != null && intent.getAction().equals(DownloadManager.ACTION_DOWNLOAD_COMPLETE)) {
                    if (timer != null) {
                        timer.cancel();
                        timer = null;
                    }
                    long id = intent.getLongExtra("extra_download_id", 0);
                    queryTask(id);
                } else if (intent != null && intent.getAction() != null && intent.getAction().equals(UpgradeManager.DOWNLOAD_STATUS)) {

                    final long current_length = intent.getLongExtra(PARAMS_CURRENT_LENGTH, 0);
                    final long max_length = intent.getLongExtra(PARAMS_MAX_LENGTH, 0);

                    double percent = intent.getDoubleExtra(PARAMS_PERCENT, 0);

                    double speed = intent.getDoubleExtra(PARAMS_SPEED, 0);

                    double planTime = intent.getDoubleExtra(PARAMS_PLAN_TIME, 0);

                    int status = intent.getIntExtra(PARAMS_STATUS, 1);

                    String apkName = intent.getStringExtra(PARAMS_APK_NAME);

                    String path = intent.getStringExtra(PARAMS_PATH);

                    long id = intent.getLongExtra(PARAMS_ID, 0L);

                    if (!isUseDownloadManager) {
                        String contentText = notificationStyle == null ? "" : notificationStyle.getNotificationStyleString(context, speed, planTime);
                        if ((status == DownloadStatus.STATUS_RUNNING.getValue() || status == DownloadStatus.STATUS_SUCCESSFUL.getValue()) && notificationVisibility == 1) {
                            UpgradeNotification.createNotification(context, (int) id, apkName, max_length == -1, percent, contentText, status);
                        } else if (notificationVisibility == 0) {
                            UpgradeNotification.createNotification(context, (int) id, apkName, max_length == -1, percent, contentText, status);
                        } else if (status == DownloadStatus.STATUS_SUCCESSFUL.getValue() && notificationVisibility == 3) {
                            UpgradeNotification.createNotification(context, (int) id, apkName, max_length == -1, percent, contentText, status);
                        }
                        if (status == DownloadStatus.STATUS_SUCCESSFUL.getValue()) {
                            installApkById((int) id);
                        }
                    }
                    if (channel != null)
                        channel.invokeMethod("update", ResultMap.getInstance()
                                .pubClear(PARAMS_CURRENT_LENGTH, current_length)
                                .put(PARAMS_ID, id)
                                .put(PARAMS_PERCENT, percent)
                                .put(PARAMS_PLAN_TIME, planTime)
                                .put(PARAMS_STATUS, status)
                                .put(PARAMS_SPEED, speed)
                                .put(PARAMS_MAX_LENGTH, max_length)
                                .put(PARAMS_PATH, path)
                                .getMap());

                } else if (intent != null && intent.getAction() != null && intent.getAction().equals(UpgradeManager.DOWNLOAD_INSTALL)) {
                    int id = intent.getIntExtra(UpgradeService.DOWNLOAD_ID, 0);
                    installApkById(id);
                    UpgradeNotification.removeNotification(context, id);
                }
            }
        };
    }

    public Integer getLastUpgradedId() {
        String versionName = "";
        int versionCode = 0;
        try {
            PackageManager manager = this.getPackageManager();
            PackageInfo info = manager.getPackageInfo(this.getPackageName(), 0);
            versionName = info.versionName;
            versionCode = info.versionCode;
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }
        return UpgradeSQLite.getInstance(this).queryIdByVersionNameAndVersionCode(versionName, versionCode);
    }

    public void upgradeWithId(final Integer id, Integer notificationVisibility, int installType, final MethodChannel.Result methodResult) {
        this.notificationVisibility = notificationVisibility;
        installFactory = installTypeToFactory(installType);

        final Map<String, Object> result = UpgradeSQLite.getInstance(this).queryById(id);
        if (result == null) {
            methodResult.success(false);
            return;
        }
        String path = (String) result.get(UpgradeSQLite.PATH);
        File downloadFile = new File(path);

        int status = (int) result.get(UpgradeSQLite.STATUS);
        if (status == DownloadStatus.STATUS_PAUSED.getValue() || status == DownloadStatus.STATUS_FAILED.getValue()
                || status == DownloadStatus.STATUS_CANCEL.getValue() || !downloadFile.exists()) {
            downloadPermissions.requestPermissions(activity, permissionsRegistry, notificationVisibility,new DownloadPermissions.ResultCallback() {
                @Override
                public void onResult(String errorCode, String errorDescription) {
                    if (errorCode == null) {
                        Intent intent = new Intent(activity, UpgradeService.class);
                        Bundle bundle = new Bundle();
                        bundle.putBoolean(UpgradeService.DOWNLOAD_RESTART, true);
                        bundle.putInt(UpgradeService.DOWNLOAD_ID, (int) id);
                        bundle.putString(UpgradeService.DOWNLOAD_URL, (String) result.get(UpgradeSQLite.URL));
                        bundle.putString(UpgradeService.DOWNLOAD_APK_NAME, (String) result.get(UpgradeSQLite.APK_NAME));
                        bundle.putSerializable(UpgradeService.DOWNLOAD_Header, (Serializable) result.get(UpgradeSQLite.HEADER));
                        intent.putExtras(bundle);
                        startService(intent);
                        methodResult.success(true);
                    } else {
                        methodResult.error(errorCode, errorDescription, null);
                    }
                }
            });
        } else if (status == DownloadStatus.STATUS_SUCCESSFUL.getValue()) {
            installApkById(id, -1, methodResult);
        } else {
            // not known
            methodResult.success(false);
        }
    }

    public Integer getDownloadStatus(Integer id) {
        return UpgradeSQLite.getInstance(this).queryStatusById(id);

    }

    public boolean upgradeFromUrl(String url) {
        Uri uri = Uri.parse(url);
        try {
            Intent intent = new Intent(Intent.ACTION_VIEW, uri);
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(intent);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean upgradeFromAndroidStore(String store) {
        Uri uri = Uri.parse("market://details?id=" + this.getApplicationInfo().packageName);
        try {
            Intent intent = new Intent(Intent.ACTION_VIEW, uri);
            if (store != null) {
                intent.setPackage(store);
            }
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(intent);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public List<String> getAndroidStores() {
        List<String> pkgs = new ArrayList<>();
        Intent intent = new Intent();
        intent.setAction("android.intent.action.VIEW");
        intent.addCategory(Intent.CATEGORY_DEFAULT);
        intent.setData(Uri.parse("market://details?id="));
        PackageManager pm = this.getPackageManager();
        // 通过queryIntentActivities获取ResolveInfo对象
        List<ResolveInfo> infoList = pm.queryIntentActivities(intent,
                0);
        if (infoList == null || infoList.size() == 0)
            return pkgs;
        int size = infoList.size();
        for (int i = 0; i < size; i++) {
            String pkgName = "";
            try {
                ActivityInfo activityInfo = infoList.get(i).activityInfo;
                pkgName = activityInfo.packageName;
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (!TextUtils.isEmpty(pkgName))
                pkgs.add(pkgName);
        }
        return pkgs;
    }

    public void getVersionFromAndroidStore(@Nullable String store, final MethodChannel.Result result) {
        if (store == null) {
            result.error("-1", "Please enter the package name.", null);
            return;
        }
        VersionCallBack callBack = new VersionCallBack() {
            @Override
            public void versionName(String version) {
                result.success(version);
            }
        };
        switch (store) {
            case "com.android.vending":
                new CheckGooglePlayVersionTask(getPackageName(), callBack).execute();
                break;
            case "com.xiaomi.market":
                new CheckXiaoMiStoreVersionTask(getPackageName(), callBack).execute();
                break;
            case "com.tencent.android.qqdownloader":
                new CheckTencentStoreVersionTask(getPackageName(), callBack).execute();
                break;
            default:
                result.error("-2", "Not Found AndroidStore.", null);
                break;
        }
    }
}



