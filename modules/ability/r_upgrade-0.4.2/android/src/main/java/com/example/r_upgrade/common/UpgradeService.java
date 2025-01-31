package com.example.r_upgrade.common;

import android.app.Service;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.net.ConnectivityManager;
import android.net.Network;
import android.net.NetworkInfo;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.os.IBinder;

import androidx.core.net.ConnectivityManagerCompat;

import org.json.JSONObject;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.RandomAccessFile;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLSocketFactory;

import static com.example.r_upgrade.common.manager.UpgradeManager.DOWNLOAD_STATUS;
import static com.example.r_upgrade.common.manager.UpgradeManager.PARAMS_APK_NAME;
import static com.example.r_upgrade.common.manager.UpgradeManager.PARAMS_CURRENT_LENGTH;
import static com.example.r_upgrade.common.manager.UpgradeManager.PARAMS_ID;
import static com.example.r_upgrade.common.manager.UpgradeManager.PARAMS_MAX_LENGTH;
import static com.example.r_upgrade.common.manager.UpgradeManager.PARAMS_PACKAGE;
import static com.example.r_upgrade.common.manager.UpgradeManager.PARAMS_PATH;
import static com.example.r_upgrade.common.manager.UpgradeManager.PARAMS_PERCENT;
import static com.example.r_upgrade.common.manager.UpgradeManager.PARAMS_PLAN_TIME;
import static com.example.r_upgrade.common.manager.UpgradeManager.PARAMS_SPEED;
import static com.example.r_upgrade.common.manager.UpgradeManager.PARAMS_STATUS;

public class UpgradeService extends Service {
    public static final String DOWNLOAD_ID = "download_id";
    public static final String DOWNLOAD_URL = "download_url";
    public static final String DOWNLOAD_Header = "download_header";
    public static final String DOWNLOAD_APK_NAME = "download_apkName";
    public static final String DOWNLOAD_RESTART = "download_restart";


    private static final String TAG = "r_upgrade.Service";
    private final Executor mExecutor = Executors.newSingleThreadExecutor();
    private UpgradeSQLite sqLite;
    private UpgradeRunnable runnable;
    private UpgradeService service;
    private boolean isFirst = true;

    private final BroadcastReceiver actionReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            String packageName = intent.getStringExtra(PARAMS_PACKAGE);
            if (packageName == null || !packageName.equals(getPackageName())) {
                return;
            }
            if (intent != null && intent.getAction() != null && intent.getAction().equals(RECEIVER_CANCEL)) {
                int id = intent.getIntExtra(PARAMS_ID, 0);
                runnable.cancel(id);
            } else if (intent != null && intent.getAction() != null && intent.getAction().equals(RECEIVER_PAUSE)) {
                int id = intent.getIntExtra(PARAMS_ID, 0);
                runnable.pause(id);
            } else if (intent != null && intent.getAction() != null && intent.getAction().equals(RECEIVER_RESTART)) {
                int id = intent.getIntExtra(PARAMS_ID, 0);
                runnable = new UpgradeRunnable(true, (long) id, null, null, null, service, sqLite);
                mExecutor.execute(runnable);
            } else if (intent != null && intent.getAction() != null && intent.getAction().equals(ConnectivityManager.CONNECTIVITY_ACTION)) {
                ConnectivityManager conMgr = (ConnectivityManager) context.getSystemService(CONNECTIVITY_SERVICE);
                NetworkInfo info = ConnectivityManagerCompat.getNetworkInfoFromBroadcast(conMgr, intent);
                handleNetworkChange(info != null && info.isConnected());
            }
        }
    };
    private ConnectivityManager.NetworkCallback networkCallback;

    public static final String RECEIVER_CANCEL = "com.example.r_upgrade.RECEIVER_CANCEL";
    public static final String RECEIVER_PAUSE = "com.example.r_upgrade.RECEIVER_PAUSE";
    public static final String RECEIVER_RESTART = "com.example.r_upgrade.RECEIVER_RESTART";

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        service = this;
        sqLite = UpgradeSQLite.getInstance(this);
        IntentFilter filter = new IntentFilter();
        filter.addAction(RECEIVER_CANCEL);
        filter.addAction(RECEIVER_RESTART);
        filter.addAction(RECEIVER_PAUSE);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            ConnectivityManager conMgr = (ConnectivityManager) getSystemService(CONNECTIVITY_SERVICE);
            networkCallback = new ConnectivityManager.NetworkCallback() {
                @Override
                public void onAvailable(Network network) {
                    super.onAvailable(network);
                    ConnectivityManager conMgr = (ConnectivityManager) getSystemService(CONNECTIVITY_SERVICE);
                    NetworkInfo info = conMgr.getNetworkInfo(network);
                    handleNetworkChange(info != null && info.isConnected());
                }

                @Override
                public void onLost(Network network) {
                    super.onLost(network);
                    ConnectivityManager conMgr = (ConnectivityManager) getSystemService(CONNECTIVITY_SERVICE);
                    NetworkInfo info = conMgr.getNetworkInfo(network);
                    handleNetworkChange(info != null && info.isConnected());
                }
            };
            conMgr.registerDefaultNetworkCallback(networkCallback);
        } else {
            filter.addAction(ConnectivityManager.CONNECTIVITY_ACTION);
        }
        registerReceiver(actionReceiver, filter);

    }

    private void handleNetworkChange(boolean isConnected) {
        if (runnable == null || runnable.isFinish) {
            return;
        }
        if (isConnected) {
            RUpgradeLogger.get().d(TAG, "onReceive: 当前网络正在连接");
            if (isFirst) {
                isFirst = false;
                return;
            }
            long id = runnable.id;
            runnable = new UpgradeRunnable(true, (long) id, runnable.url, runnable.header, runnable.apkName, service, sqLite);
            mExecutor.execute(runnable);
        } else {
            if (isFirst) {
                isFirst = false;
                return;
            }
            runnable.handlerDownloadFinish();
            runnable.pause(-1);
            isFirst = false;
            RUpgradeLogger.get().d(TAG, "onReceive: 当前网络已断开");
        }
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        if (intent == null) return super.onStartCommand(null, flags, startId);
        Bundle bundle = intent.getExtras();
        assert (bundle != null);
        String url = bundle.getString(DOWNLOAD_URL);
        int id = bundle.getInt(DOWNLOAD_ID);

        Map<String, Object> header;
        if (bundle.get(DOWNLOAD_Header) != null && bundle.get(DOWNLOAD_Header) instanceof String) {
            header = getMapForJson(bundle.getString(DOWNLOAD_Header));
        } else {
            header = (Map<String, Object>) bundle.getSerializable(DOWNLOAD_Header);
        }
        String apkName = bundle.getString(DOWNLOAD_APK_NAME);
        boolean isReStart = bundle.getBoolean(DOWNLOAD_RESTART);

        runnable = new UpgradeRunnable(
                isReStart,
                (long) id,
                url,
                header,
                apkName, service, sqLite);

        mExecutor.execute(runnable);

        return super.onStartCommand(intent, flags, startId);
    }

    @Override
    public void onDestroy() {
        unregisterReceiver(actionReceiver);
        if (runnable != null) {
            runnable.handlerDownloadPause();
        }
        super.onDestroy();
    }

    private static class UpgradeRunnable implements Runnable {
        private String url;
        private Long id;
        private Map<String, Object> header;
        private String apkName;
        private UpgradeService upgradeService;

        private long maxLength = 0;
        private long currentLength = 0;
        private long lastCurrentLength = 0;
        private long lastTime = System.currentTimeMillis();
        private File downloadFile = null;
        private UpgradeSQLite sqLite;
        private HttpURLConnection httpURLConnection;
        private HttpsURLConnection httpsURLConnection;

        private Timer timer;
        private boolean isRunning = true;
        private boolean isReStart;

        private boolean isNewDownload;

        private boolean isFinish;

        UpgradeRunnable(boolean isReStart, Long id, String url, Map<String, Object> header, String apkName, UpgradeService upgradeService, UpgradeSQLite sqLite) {
            this.id = id;
            this.url = url;
            this.header = header;
            this.apkName = apkName == null ? "release.apk" : apkName;
            this.upgradeService = upgradeService;
            this.sqLite = sqLite;
            this.isReStart = isReStart;
            this.isFinish = false;
        }

        /**
         * cancel timer
         */
        private void cancelTimer() {
            if (timer != null) {
                timer.cancel();
            }
        }

        private void cancel(int id) {
            if (isFinish) return;
            if (this.id == id) {
                cancelTimer();
                if (httpsURLConnection != null) {
                    httpsURLConnection.disconnect();
                }
                if (httpURLConnection != null) {
                    httpURLConnection.disconnect();
                }
                isRunning = false;
                handlerDownloadCancel();
                boolean isSuccess = downloadFile.delete();
                RUpgradeLogger.get().d(TAG, "cancel: delete download file " + isSuccess);

            }
        }

        private void pause(int id) {
            if (isFinish) return;

            if (id == -1 || this.id == id) {
                if (httpsURLConnection != null) {
                    httpsURLConnection.disconnect();
                }
                if (httpURLConnection != null) {
                    httpURLConnection.disconnect();
                }
                isRunning = false;
                handlerDownloadPause();
            }
        }

        private File getDownloadDirectory() {
            if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
                return upgradeService.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS);
            }
            return Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS);
        }

        private boolean handlerDownloadPending() {
            if (isReStart) {
                SQLiteDatabase readableDatabase = sqLite.getReadableDatabase();
                Cursor cursor = readableDatabase.rawQuery("select * from " + UpgradeSQLite.VERSION_MANAGER + " where " + UpgradeSQLite.ID + "=?", new String[]{String.valueOf(id)});
                boolean canMove = cursor.moveToNext();
                if (!canMove) {
                    // 重新下载
                    File parentFile = getDownloadDirectory();
                    if (!parentFile.exists()) {
                        parentFile.mkdir();
                    }
                    downloadFile = new File(parentFile.getPath(), apkName);
                    JSONObject object = null;
                    if (header != null) {
                        object = new JSONObject(header);
                    }
                    //更新一条SQL
                    sqLite.update(id, url, downloadFile.getPath(), apkName, object == null ? "" : object.toString(), currentLength, maxLength, DownloadStatus.STATUS_PENDING.getValue());
                    cursor.close();
                    return true;
                } else {
                    boolean isNewDownload = false;

                    //续传
                    String path = cursor.getString(cursor.getColumnIndex(UpgradeSQLite.PATH));
                    downloadFile = new File(path);
                    //下载的文件已被删除
                    if (!downloadFile.exists()) {
                        try {
                            boolean isSuccess = downloadFile.createNewFile();
                            RUpgradeLogger.get().d(TAG, "handlerDownloadPending: download file create " + isSuccess);
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                        currentLength = 0;
                        lastCurrentLength = currentLength;
                        isNewDownload = true;
                    } else {
                        currentLength = cursor.getLong(cursor.getColumnIndex(UpgradeSQLite.CURRENT_LENGTH));
                        lastCurrentLength = currentLength;
                        maxLength = cursor.getLong(cursor.getColumnIndex(UpgradeSQLite.MAX_LENGTH));
                    }
                    apkName = cursor.getString(cursor.getColumnIndex(UpgradeSQLite.APK_NAME));
                    url = cursor.getString(cursor.getColumnIndex(UpgradeSQLite.URL));
                    String header = cursor.getString(cursor.getColumnIndex(UpgradeSQLite.HEADER));
                    this.header = getMapForJson(header);
                    cursor.close();
                    //更新一条SQL
                    sqLite.update(id, currentLength, maxLength, DownloadStatus.STATUS_PENDING.getValue());

                    return isNewDownload;
                }
            } else {
                // 重新下载
                File parentFile = getDownloadDirectory();
                downloadFile = new File(parentFile.getPath(), apkName);
                JSONObject object = null;
                if (header != null) {
                    object = new JSONObject(header);
                }
                //更新一条SQL
                sqLite.update(id, url, downloadFile.getPath(), apkName, object == null ? "" : object.toString(), currentLength, maxLength, DownloadStatus.STATUS_PENDING.getValue());
                return true;
            }
        }

        private void handlerDownloadRunning() {
            try {
                if (currentLength - lastCurrentLength > 0) {
                    double percent = new BigDecimal((currentLength * 1.0f / maxLength) * 100).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
                    double speed = ((currentLength - lastCurrentLength) * 1000f / (System.currentTimeMillis() - lastTime)) / 1024;
                    //计划完成时间
                    double planTime = (maxLength - currentLength) / (speed * 1024f);
                    Intent intent = new Intent();
                    intent.setAction(DOWNLOAD_STATUS);
                    intent.putExtra(PARAMS_CURRENT_LENGTH, currentLength);
                    intent.putExtra(PARAMS_STATUS, DownloadStatus.STATUS_RUNNING.getValue());
                    intent.putExtra(PARAMS_PERCENT, percent);
                    intent.putExtra(PARAMS_MAX_LENGTH, maxLength);
                    intent.putExtra(PARAMS_SPEED, speed);
                    intent.putExtra(PARAMS_PLAN_TIME, planTime);
                    intent.putExtra(PARAMS_PATH, downloadFile.getPath());
                    intent.putExtra(PARAMS_ID, id);
                    intent.putExtra(PARAMS_APK_NAME, apkName);
                    intent.putExtra(PARAMS_PACKAGE, upgradeService.getPackageName());
                    upgradeService.sendBroadcast(intent);
                    sqLite.update(id, currentLength, maxLength, DownloadStatus.STATUS_RUNNING.getValue());
                    RUpgradeLogger.get().d(TAG, "handlerDownloadRunning: running queryTask: 下载中\n" +
                            "url: " +
                            url +
                            "\n============>" +
                            "total:" +
                            maxLength +
                            "，" +
                            "progress:" +
                            currentLength +
                            "，" +
                            String.format("%.2f", percent) +
                            "% , " +
                            String.format("%.2f", speed) +
                            "kb/s , " +
                            "预计：" +
                            String.format("%.0f", planTime) +
                            "s");
                    lastCurrentLength = currentLength;
                    lastTime = System.currentTimeMillis();
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        private void handlerDownloadCancel() {
            RUpgradeLogger.get().d(TAG, "handlerDownloadCancel: ");
            cancelTimer();
            Intent intent = new Intent();
            intent.setAction(DOWNLOAD_STATUS);
            intent.putExtra(PARAMS_ID, id);
            intent.putExtra(PARAMS_APK_NAME, apkName);
            intent.putExtra(PARAMS_PATH, downloadFile.getPath());
            intent.putExtra(PARAMS_STATUS, DownloadStatus.STATUS_CANCEL.getValue());
            intent.putExtra(PARAMS_PACKAGE, upgradeService.getPackageName());
            upgradeService.sendBroadcast(intent);
            sqLite.delete(id);
        }

        private void handlerDownloadPause() {
            RUpgradeLogger.get().d(TAG, "handlerDownloadPause: downloadFile:" + downloadFile);
            cancelTimer();
            Intent intent = new Intent();
            intent.setAction(DOWNLOAD_STATUS);
            intent.putExtra(PARAMS_ID, id);
            intent.putExtra(PARAMS_APK_NAME, apkName);
            if (downloadFile != null) {
                intent.putExtra(PARAMS_PATH, downloadFile.getPath());
            }
            intent.putExtra(PARAMS_STATUS, DownloadStatus.STATUS_PAUSED.getValue());
            if (upgradeService != null) {
                intent.putExtra(PARAMS_PACKAGE, upgradeService.getPackageName());
                upgradeService.sendBroadcast(intent);
            }
            if (sqLite != null) {
                sqLite.update(id, currentLength, maxLength, DownloadStatus.STATUS_PAUSED.getValue());
            }
        }

        private void handlerDownloadFinish() {
            RUpgradeLogger.get().d(TAG, "handlerDownloadFinish: finish");
            cancelTimer();
            Intent intent = new Intent();
            intent.setAction(DOWNLOAD_STATUS);
            intent.putExtra(PARAMS_ID, id);
            intent.putExtra(PARAMS_APK_NAME, apkName);
            intent.putExtra(PARAMS_PATH, downloadFile.getPath());
            intent.putExtra(PARAMS_STATUS, DownloadStatus.STATUS_SUCCESSFUL.getValue());
            intent.putExtra(PARAMS_PACKAGE, upgradeService.getPackageName());
            upgradeService.sendBroadcast(intent);
            sqLite.update(id, null, null, DownloadStatus.STATUS_SUCCESSFUL.getValue());
            lastCurrentLength = 0;
            isFinish = true;
        }

        private void handlerDownloadFailure() {
            RUpgradeLogger.get().d(TAG, "handlerDownloadFailure: failure");
            Intent intent = new Intent(DOWNLOAD_STATUS);
            intent.putExtra(PARAMS_ID, id);
            intent.putExtra(PARAMS_APK_NAME, apkName);
            intent.putExtra(PARAMS_PATH, downloadFile.getPath());
            intent.putExtra(PARAMS_STATUS, DownloadStatus.STATUS_FAILED.getValue());
            sqLite.update(id, null, null, DownloadStatus.STATUS_FAILED.getValue());
            intent.putExtra(PARAMS_PACKAGE, upgradeService.getPackageName());
            upgradeService.sendBroadcast(intent);
        }

        private long getMaxLength(HttpURLConnection connection) {
            long maxLength = connection.getContentLength();
            if (maxLength < 0) {
                List<String> values = connection.getHeaderFields().get("content-Length");
                if (values != null && !values.isEmpty()) {
                    String sLength = values.get(0);
                    if (sLength != null) {
                        maxLength = Long.parseLong(sLength, 10);
                    }
                }
            }
            return maxLength;
        }

        private InputStream getInputStreamFromUrl(String inputUrl) throws IOException {
            InputStream is = null;
            URL url = new URL(inputUrl);
            int code;
            if (inputUrl.startsWith("https")) {
                HttpsURLConnection connection = (HttpsURLConnection) url.openConnection();
                connection.setRequestMethod("GET");
                connection.setReadTimeout(6 * 60 * 1000);
                connection.setConnectTimeout(6 * 60 * 1000);
                if (header != null && !header.isEmpty()) {
                    for (Map.Entry<String, Object> entry : header.entrySet()) {
                        connection.setRequestProperty(entry.getKey(), (String) entry.getValue());
                    }
                }
                if (!isNewDownload) {
                    connection.setRequestProperty("range", "bytes=" + currentLength + "-");
                }
                connection.setSSLSocketFactory((SSLSocketFactory) SSLSocketFactory.getDefault());
                connection.setDoInput(true);
                code = connection.getResponseCode();
                RUpgradeLogger.get().d(TAG, "run: code=" + code);
                if (code == 200 || code == 206) {
                    connection.connect();
                    is = connection.getInputStream();
                    if (isNewDownload) {
                        maxLength = getMaxLength(connection);
                    }
                } else if (code == 301 || code == 302) {
                    URL redirectUrl = connection.getURL();
                    RUpgradeLogger.get().d(TAG, "redirect to: " + redirectUrl.toString());
                    is = getInputStreamFromUrl(redirectUrl.toString());
                }
            } else {
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                connection.setRequestMethod("GET");
                connection.setConnectTimeout(6 * 60 * 1000);
                connection.setReadTimeout(6 * 60 * 1000);
                connection.setRequestProperty("Accept-Encoding", "identity");
                if (header != null && !header.isEmpty()) {
                    for (Map.Entry<String, Object> entry : header.entrySet()) {
                        connection.setRequestProperty(entry.getKey(), (String) entry.getValue());
                    }
                }
                if (!isNewDownload) {
                    connection.setRequestProperty("range", "bytes=" + currentLength + "-");
                }
                connection.setDoInput(true);
                code = connection.getResponseCode();
                RUpgradeLogger.get().d(TAG, "run: code=" + code);
                if (code == 200 || code == 206) {
                    connection.connect();
                    is = connection.getInputStream();
                    if (isNewDownload) {
                        maxLength = getMaxLength(connection);
                    }
                } else if (code == 301 || code == 302) {
                    URL redirectUrl = connection.getURL();
                    RUpgradeLogger.get().d(TAG, "redirect to: " + redirectUrl.toString());
                    is = getInputStreamFromUrl(redirectUrl.toString());
                }
            }
            return is;
        }

        @Override
        public void run() {
            isNewDownload = handlerDownloadPending();
            //下载文件不存在，但是需要续下载？
            if (!downloadFile.exists() && !isNewDownload) {
                isNewDownload = true;
                currentLength = 0;

            }
            timer = new Timer();
            timer.schedule(new TimerTask() {
                @Override
                public void run() {
                    handlerDownloadRunning();
                }
            }, 500, 500);

            InputStream is = null;
            FileOutputStream fos = null;
            RandomAccessFile raf = null;

            try {
                if (isNewDownload) {
                    if (downloadFile.exists()) {
                        downloadFile.delete();
                    }
                    downloadFile.createNewFile();
                    fos = new FileOutputStream(downloadFile);
                } else {
                    raf = new RandomAccessFile(downloadFile, "rwd");
                    raf.seek(currentLength);
                }
                is = getInputStreamFromUrl(this.url);
                if (is == null) {
                    handlerDownloadFailure();
                    return;
                }
                assert (is != null);
                RUpgradeLogger.get().d(TAG, "run: maxLength:" + maxLength);

                byte[] buff = new byte[1024];

                int len = 0;
                while ((len = is.read(buff)) != -1) {
                    if (!isRunning) {
                        break;
                    }
                    if (isNewDownload) {
                        assert (fos != null);
                        fos.write(buff, 0, len);
                    } else {
                        assert (raf != null);
                        raf.write(buff, 0, len);
                    }
                    currentLength += len;
                }
                if (isNewDownload) {
                    assert (fos != null);
                    fos.flush();
                    fos.close();
                } else {
                    assert (raf != null);
                    raf.close();
                }
                is.close();
                if (isRunning) {
                    handlerDownloadFinish();
                }
            } catch (Exception e) {
                timer.cancel();
                e.printStackTrace();
                if (is != null) {
                    try {
                        is.close();
                    } catch (IOException ex) {
                        ex.printStackTrace();
                    }
                }
                if (fos != null) {
                    try {
                        fos.close();
                    } catch (IOException ex) {
                        ex.printStackTrace();
                    }
                }
                if (raf != null) {
                    try {
                        raf.close();
                    } catch (IOException ex) {
                        ex.printStackTrace();
                    }
                }
                //防止断网的情况，出现下载失败，而不是下载暂停的问题
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException ex) {
                    ex.printStackTrace();
                }
                if (isRunning) {
                    handlerDownloadFailure();
                }
            }
        }

        private Map<String, Object> getMapForJson(String jsonStr) {
            if (jsonStr == null || jsonStr.isEmpty()) return null;

            JSONObject jsonObject;
            try {
                jsonObject = new JSONObject(jsonStr);

                Iterator<String> keyIter = jsonObject.keys();
                String key;
                Object value;
                Map<String, Object> valueMap = new HashMap<String, Object>();
                while (keyIter.hasNext()) {
                    key = keyIter.next();
                    value = jsonObject.get(key);
                    valueMap.put(key, value);
                }
                return valueMap;
            } catch (Exception e) {
                e.printStackTrace();
            }
            return new HashMap<String, Object>();
        }

    }

    private Map<String, Object> getMapForJson(String jsonStr) {
        if (jsonStr == null || jsonStr.isEmpty()) return null;

        JSONObject jsonObject;
        try {
            jsonObject = new JSONObject(jsonStr);

            Iterator<String> keyIter = jsonObject.keys();
            String key;
            Object value;
            Map<String, Object> valueMap = new HashMap<String, Object>();
            while (keyIter.hasNext()) {
                key = keyIter.next();
                value = jsonObject.get(key);
                valueMap.put(key, value);
            }
            return valueMap;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new HashMap<String, Object>();
    }


}

