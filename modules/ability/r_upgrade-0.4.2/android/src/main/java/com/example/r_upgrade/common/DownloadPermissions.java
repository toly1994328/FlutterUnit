package com.example.r_upgrade.common;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Build;

import androidx.annotation.RequiresApi;
import androidx.annotation.VisibleForTesting;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import io.flutter.plugin.common.PluginRegistry;

public class DownloadPermissions {
    public interface PermissionsRegistry {
        void addListener(PluginRegistry.RequestPermissionsResultListener handler);
    }

    public interface ResultCallback {
        void onResult(String errorCode, String errorDescription);
    }

    private static final int STORAGE_REQUEST_ID = 9790;
    private boolean ongoing = false;

    public void requestPermissions(
            Activity activity,
            PermissionsRegistry permissionsRegistry,
            Integer notificationVisibility,
            final ResultCallback callback) {

        if (Build.VERSION.SDK_INT >= 33) {
            if (ongoing) {
                callback.onResult("downloadPermission", "Notification permission request ongoing");
            }
            if (notificationVisibility != 2&&!hasNotificationPermission(activity)) {
                permissionsRegistry.addListener(
                        new StorageRequestPermissionsListener(new ResultCallback() {
                            @Override
                            public void onResult(String errorCode, String errorDescription) {
                                ongoing = false;
                                callback.onResult(errorCode, errorDescription);
                            }
                        }));
                ongoing = true;
                ActivityCompat.requestPermissions(
                        activity,
                        new String[]{Manifest.permission.POST_NOTIFICATIONS},
                        STORAGE_REQUEST_ID);
            } else {
                // Permissions already exist. Call the callback with success.
                callback.onResult(null, null);
            }
        } else if (Build.VERSION.SDK_INT < 30 && (!hasReadStoragePermission(activity) || !hasWritePermission(activity))) {
            if (ongoing) {
                callback.onResult("downloadPermission", "Read/Write External Storage permission request ongoing");
            }
            permissionsRegistry.addListener(
                    new StorageRequestPermissionsListener(new ResultCallback() {
                        @Override
                        public void onResult(String errorCode, String errorDescription) {
                            ongoing = false;
                            callback.onResult(errorCode, errorDescription);
                        }
                    }));
            ongoing = true;
            ActivityCompat.requestPermissions(
                    activity,
                    new String[]{Manifest.permission.READ_EXTERNAL_STORAGE, Manifest.permission.WRITE_EXTERNAL_STORAGE},
                    STORAGE_REQUEST_ID);
        } else {
            // Permissions already exist. Call the callback with success.
            callback.onResult(null, null);
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.TIRAMISU)
    private boolean hasNotificationPermission(Activity activity) {
        return ContextCompat.checkSelfPermission(activity, Manifest.permission.POST_NOTIFICATIONS)
                == PackageManager.PERMISSION_GRANTED;
    }

    private boolean hasReadStoragePermission(Activity activity) {
        return ContextCompat.checkSelfPermission(activity, Manifest.permission.READ_EXTERNAL_STORAGE)
                == PackageManager.PERMISSION_GRANTED;
    }

    private boolean hasWritePermission(Activity activity) {
        return ContextCompat.checkSelfPermission(activity, Manifest.permission.WRITE_EXTERNAL_STORAGE)
                == PackageManager.PERMISSION_GRANTED;
    }

    @VisibleForTesting
    public static final class StorageRequestPermissionsListener
            implements PluginRegistry.RequestPermissionsResultListener {

        // There's no way to unregister permission listeners in the v1 embedding, so we'll be called
        // duplicate times in cases where the user denies and then grants a permission. Keep track of if
        // we've responded before and bail out of handling the callback manually if this is a repeat
        // call.
        boolean alreadyCalled = false;

        final ResultCallback callback;

        @VisibleForTesting
        StorageRequestPermissionsListener(ResultCallback callback) {
            this.callback = callback;
        }

        @Override
        public boolean onRequestPermissionsResult(int id, String[] permissions, int[] grantResults) {
            if (alreadyCalled || id != STORAGE_REQUEST_ID) {
                return false;
            }
            if (Build.VERSION.SDK_INT >= 33) {
                if (grantResults.length != 1) return false;
                alreadyCalled = true;

                if (grantResults[0] != PackageManager.PERMISSION_GRANTED) {
                    callback.onResult("downloadPermission", "Notification permission not granted");
                } else {
                    callback.onResult(null, null);
                }
                return true;
            } else {
                if (grantResults.length != 2) return false;
                alreadyCalled = true;

                if (grantResults[0] != PackageManager.PERMISSION_GRANTED || grantResults[1] != PackageManager.PERMISSION_GRANTED) {
                    callback.onResult("downloadPermission", "Read/Write External Storage permission not granted");
                } else {
                    callback.onResult(null, null);
                }
                return true;
            }
        }
    }
}
