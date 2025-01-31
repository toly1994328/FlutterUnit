package com.example.r_upgrade.common;

import android.annotation.TargetApi;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.os.Build;

import androidx.core.app.NotificationCompat;
import androidx.core.app.NotificationManagerCompat;

import com.example.r_upgrade.R;
import com.example.r_upgrade.common.manager.UpgradeManager;

public class UpgradeNotification {
    public static final String TAG = "r_upgrade.Notification";

    private static String CHANNEL_NAME;

    public static void createNotification(Context context, int id, String title,boolean indeterminate, Double percent, String contentText, int status) {
        if (CHANNEL_NAME == null) {
            try {
                CHANNEL_NAME = context.getPackageName() + "_notification";
            } catch (Exception e) {
                e.printStackTrace();
                CHANNEL_NAME = "r_upgrade_notification";
            }
        }
        if (status == DownloadStatus.STATUS_CANCEL.getValue()) {
            removeNotification(context, id);
            return;
        }
        Notification notification;
        if (status == DownloadStatus.STATUS_RUNNING.getValue()) {
            Intent pauseIntent = new Intent();
            pauseIntent.setAction(UpgradeService.RECEIVER_PAUSE);
            pauseIntent.putExtra(UpgradeManager.PARAMS_ID, id);
            pauseIntent.putExtra(UpgradeManager.PARAMS_PACKAGE, context.getPackageName());


            PendingIntent pausePendingIntent =
                    PendingIntent.getBroadcast(context, 0, pauseIntent, getPendingIntentFlag());
//            PendingIntent.getBroadcast(context, 0, pauseIntent, PendingIntent.FLAG_IMMUTABLE);
            int current_length = percent.intValue();

            notification = new NotificationCompat.Builder(context, CHANNEL_NAME)
                    .setSmallIcon(context.getApplicationInfo().icon)
                    .setContentTitle(title)
                    .setContentText(indeterminate ? "" : contentText)
                    .setContentIntent(pausePendingIntent)
                    .setProgress(indeterminate ? 0 : 100, indeterminate ? 0 : current_length, indeterminate)
                    .build();
        } else if (status == DownloadStatus.STATUS_SUCCESSFUL.getValue()) {
            Intent installIntent = new Intent();
            installIntent.setAction(UpgradeManager.DOWNLOAD_INSTALL);
            installIntent.putExtra(UpgradeService.DOWNLOAD_ID, id);
            installIntent.putExtra(UpgradeManager.PARAMS_PACKAGE, context.getPackageName());

            PendingIntent installPendingIntent =
                    PendingIntent.getBroadcast(context, 0, installIntent, getPendingIntentFlag());
//                    PendingIntent.getBroadcast(context, 0, installIntent, PendingIntent.FLAG_IMMUTABLE);

            notification = new NotificationCompat.Builder(context, CHANNEL_NAME)
                    .setSmallIcon(context.getApplicationInfo().icon)
                    .setContentTitle(title)
                    .setContentIntent(installPendingIntent)
                    .setContentText(context.getResources().getString(R.string.r_upgrade_download_finish))
                    .build();
        } else if (status == DownloadStatus.STATUS_PAUSED.getValue()) {
            Intent reStartIntent = new Intent();
            reStartIntent.setAction(UpgradeService.RECEIVER_RESTART);
            reStartIntent.putExtra(UpgradeManager.PARAMS_ID, id);
            reStartIntent.putExtra(UpgradeManager.PARAMS_PACKAGE, context.getPackageName());

            PendingIntent reStartPendingIntent =
                    PendingIntent.getBroadcast(context, 0, reStartIntent, getPendingIntentFlag());
//                    PendingIntent.getBroadcast(context, 0, reStartIntent, PendingIntent.FLAG_IMMUTABLE);

            notification = new NotificationCompat.Builder(context, CHANNEL_NAME)
                    .setSmallIcon(context.getApplicationInfo().icon)
                    .setContentTitle(title)
                    .setContentIntent(reStartPendingIntent)
                    .setContentText(context.getResources().getString(R.string.r_upgrade_download_paused))
                    .build();
        } else if (status == DownloadStatus.STATUS_FAILED.getValue()) {
            Intent failedIntent = new Intent();
            failedIntent.setAction(UpgradeService.RECEIVER_RESTART);
            failedIntent.putExtra(UpgradeManager.PARAMS_ID, id);
            failedIntent.putExtra(UpgradeManager.PARAMS_PACKAGE, context.getPackageName());

            PendingIntent reStartPendingIntent =
                    PendingIntent.getBroadcast(context, 0, failedIntent, getPendingIntentFlag());
//            PendingIntent.getBroadcast(context, 0, failedIntent, PendingIntent.FLAG_IMMUTABLE);
            notification = new NotificationCompat.Builder(context, CHANNEL_NAME)
                    .setSmallIcon(context.getApplicationInfo().icon)
                    .setContentTitle(title)
                    .setContentIntent(reStartPendingIntent)
                    .setContentText(context.getResources().getString(R.string.r_upgrade_download_failed))
                    .build();
        } else {
            notification = new NotificationCompat.Builder(context, CHANNEL_NAME)
                    .setSmallIcon(context.getApplicationInfo().icon)
                    .setContentTitle(title)
                    .setProgress(0, 0, true)
                    .build();
        }
        NotificationManagerCompat compat = NotificationManagerCompat.from(context);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationManager notificationManager = context.getSystemService(NotificationManager.class);
            notificationManager.createNotificationChannel(createNotificationChannel());
        }
        compat.notify(id, notification);
    }

    private static int getPendingIntentFlag() {
        int pendingFlag = PendingIntent.FLAG_UPDATE_CURRENT;
        if (Build.VERSION.SDK_INT >= 31) {
            pendingFlag = PendingIntent.FLAG_IMMUTABLE | PendingIntent.FLAG_UPDATE_CURRENT;
        }
        return pendingFlag;
    }

    public static void removeNotification(Context context, long id) {
        NotificationManagerCompat compat = NotificationManagerCompat.from(context);
        compat.cancel((int) id);
    }

    @TargetApi(Build.VERSION_CODES.O)
    private static NotificationChannel createNotificationChannel() {
        String description = "Upgrade Application";
        int importance = NotificationManager.IMPORTANCE_DEFAULT;
        NotificationChannel channel = new NotificationChannel(CHANNEL_NAME, CHANNEL_NAME, importance);
        channel.setDescription(description);
        channel.enableVibration(false);
        channel.setImportance(NotificationManager.IMPORTANCE_LOW);
        // Register the channel with the system; you can't change the importance
        // or other notification behaviors after this
        return channel;
    }
}
