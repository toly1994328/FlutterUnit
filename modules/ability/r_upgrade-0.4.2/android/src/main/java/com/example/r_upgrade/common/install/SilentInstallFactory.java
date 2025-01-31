package com.example.r_upgrade.common.install;

import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageInstaller;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;

import androidx.annotation.RequiresApi;

import com.example.r_upgrade.common.RUpgradeLogger;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class SilentInstallFactory extends BaseInstallFactory {
    private static final String TAG = "SilentInstall";

    public SilentInstallFactory(Context base) {
        super(base);
    }

    @Override
    public boolean install(Uri uri) {
        if (uri == null) return false;
        File apkFile = new File(uri.getPath());
        if (!apkFile.exists()) {
            return false;
        }
        RUpgradeLogger.get().d(TAG, "startSilentInstall:file path" + apkFile.getPath());
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            PackageInstaller installer = getPackageManager().getPackageInstaller();
            PackageInfo packageInfo = getPackageManager().getPackageArchiveInfo(apkFile.getPath(), PackageManager.GET_ACTIVITIES |
                    PackageManager.GET_SERVICES);
            PackageInstaller.SessionParams params = new PackageInstaller.SessionParams(
                    PackageInstaller.SessionParams.MODE_FULL_INSTALL
            );
            if (packageInfo != null) {
                String packageName = packageInfo.packageName;
                params.setAppPackageName(packageName);
            }
            params.setSize(apkFile.length());
            int sessionId = createSession(installer, params);

            PackageInstaller.Session session = copyInstallFile(installer, sessionId, apkFile.getPath());
            if (session != null) {
                PendingIntent broadCastTest = PendingIntent.getBroadcast(
                        this,
                        sessionId,
                        new Intent(Intent.ACTION_PACKAGE_ADDED),
                        getPendingIntentFlag());
                session.commit(broadCastTest.getIntentSender());
                session.close();
            }
        }
        return true;
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    private void closeQuietly(Object obj) {
        if (obj != null) {
            if (obj instanceof PackageInstaller.Session) {
                ((PackageInstaller.Session) obj).close();
            } else if (obj instanceof FileOutputStream) {
                try {
                    ((FileOutputStream) obj).close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else if (obj instanceof FileInputStream) {
                try {
                    ((FileInputStream) obj).close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else if (obj instanceof OutputStream) {
                try {
                    ((OutputStream) obj).close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else if (obj instanceof InputStream) {
                try {
                    ((InputStream) obj).close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    private int createSession(PackageInstaller packageInstaller,
                              PackageInstaller.SessionParams sessionParams) {
        int sessionId = -1;
        try {
            sessionId = packageInstaller.createSession(sessionParams);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return sessionId;
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    private PackageInstaller.Session copyInstallFile(PackageInstaller packageInstaller,
                                                     int sessionId, String apkFilePath) {
        InputStream in = null;
        OutputStream out = null;
        PackageInstaller.Session session = null;
        try {
            File apkFile = new File(apkFilePath);
            session = packageInstaller.openSession(sessionId);
            out = session.openWrite("app_store_session", 0, apkFile.length());
            in = new FileInputStream(apkFile);
            int total = 0;
            byte[] buffer = new byte[65536];
            int len;
            while ((len = in.read(buffer)) != -1) {
                total += len;
                out.write(buffer, 0, len);
                RUpgradeLogger.get().d(TAG, "Write install session:" + len);
            }
            RUpgradeLogger.get().d(TAG, "Finish session total size:" + total);
            session.fsync(out);
            return session;
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            closeQuietly(in);
            closeQuietly(session);
            closeQuietly(out);
        }
        return null;
    }

    private static int getPendingIntentFlag() {
        int pendingFlag = PendingIntent.FLAG_UPDATE_CURRENT;
        if (Build.VERSION.SDK_INT >= 31) {
            pendingFlag = PendingIntent.FLAG_IMMUTABLE | PendingIntent.FLAG_UPDATE_CURRENT;
        }
        return pendingFlag;
    }
}
