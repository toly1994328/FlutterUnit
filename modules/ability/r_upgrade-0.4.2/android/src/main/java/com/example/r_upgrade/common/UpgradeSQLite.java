package com.example.r_upgrade.common;

import android.content.ContentValues;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

import androidx.annotation.Nullable;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;


public class UpgradeSQLite extends SQLiteOpenHelper {
    private static final String TAG = "r_upgrade.SQLite";
    private static final String DATABASE_NAME = "r_upgrade.db";
    private static final int DATABASE_VERSION = 2;

    private static UpgradeSQLite instance;

    public synchronized static UpgradeSQLite getInstance(Context context) {
        if (instance == null) {
            instance = new UpgradeSQLite(context);
        }
        return instance;
    }

    public static final String VERSION_MANAGER = "version_manager";

    public static final String ID = "id";
    public static final String URL = "url";
    public static final String APK_NAME = "apk_name";
    public static final String PATH = "path";

    public static final String HEADER = "header";
    public static final String CURRENT_LENGTH = "current_length";
    public static final String MAX_LENGTH = "max_length";
    public static final String STATUS = "status";

    public static final String VERSION_NAME = "version_name";
    public static final String VERSION_CODE = "version_code";
    public static final String UPGRADE_FLAVOR = "upgrade_flavor";
    public static final int UPGRADE_FLAVOR_Normal = 0;
    public static final int UPGRADE_FLAVOR_HOT_UPDATE = 1;
    public static final int UPGRADE_FLAVOR_INCREMENT = 2;

    private static final String DATABASE_CREATE = "create table if not exists " + VERSION_MANAGER + "(" +
            ID + " integer primary key autoincrement," +
            URL + " text," +
            PATH + " text," +
            APK_NAME + " text," +
            HEADER + " text," +
            CURRENT_LENGTH + " integer," +
            MAX_LENGTH + " integer," +
            STATUS + " integer," +
            VERSION_NAME + " text," +
            VERSION_CODE + " integer,"+
            UPGRADE_FLAVOR + " integer)";

    public UpgradeSQLite(@Nullable Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL(DATABASE_CREATE);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        RUpgradeLogger.get().d(TAG, String.format(Locale.ENGLISH,"onUpgrade: oldVersion:%d , newVersion:%d", oldVersion, newVersion));
        if(oldVersion == 1){
            db.execSQL("delete from "+VERSION_MANAGER);
            db.execSQL("alter table "+VERSION_MANAGER+" add column "+UPGRADE_FLAVOR+" integer");
        }
    }

    public Integer queryIdByVersionNameAndVersionCode(String versionName, int versionCode) {
        SQLiteDatabase readableDatabase = getReadableDatabase();
        Cursor cursor = readableDatabase.rawQuery("select * from " + VERSION_MANAGER + " where " + VERSION_NAME + "=?" + " and " + VERSION_CODE + "=? order by " + ID + " DESC LIMIT 1", new String[]{versionName, String
                .valueOf(versionCode)});
        boolean canMoveNext = cursor.moveToNext();
        if (canMoveNext) {
            int id = cursor.getInt(cursor.getColumnIndex(ID));
            RUpgradeLogger.get().d(TAG, "queryByVersionNameAndVersionCode: " + id);
            cursor.close();
            return id;
        } else {
            cursor.close();
            return null;
        }
    }

    public Map<String, Object> queryById(long id) {
        Map<String, Object> result = new HashMap<>();

        SQLiteDatabase readableDatabase = getReadableDatabase();
        Cursor cursor = readableDatabase.rawQuery("select * from " + VERSION_MANAGER + " where " + ID + "=?", new String[]{String.valueOf(id)});
        boolean hasNext = cursor.moveToNext();
        if (hasNext) {
            String path = cursor.getString(cursor.getColumnIndex(PATH));
            String url = cursor.getString(cursor.getColumnIndex(URL));
            String apkName = cursor.getString(cursor.getColumnIndex(APK_NAME));
            int status = cursor.getInt(cursor.getColumnIndex(STATUS));
            String header = cursor.getString(cursor.getColumnIndex(HEADER));
            int rUpgradeFlavor = cursor.getInt(cursor.getColumnIndex(UPGRADE_FLAVOR));
            result.put(PATH, path);
            result.put(APK_NAME, apkName);
            result.put(URL, url);
            result.put(STATUS, status);
            result.put(HEADER, header);
            result.put(UPGRADE_FLAVOR, rUpgradeFlavor);
            return result;
        } else {
            cursor.close();
            return null;
        }
    }


    public Integer queryStatusById(int id) {
        SQLiteDatabase readableDatabase = getReadableDatabase();
        Cursor cursor = readableDatabase.rawQuery("select * from " + VERSION_MANAGER + " where " + ID + "=?", new String[]{String.valueOf(id)});
        boolean canMoveNext = cursor.moveToNext();
        if (canMoveNext) {
            int status = cursor.getInt(cursor.getColumnIndex(STATUS));
            cursor.close();
            return status;
        } else {
            cursor.close();
            return null;
        }
    }


    //创建记录
    public long createRecord(Context context, String url, String apk_name, String header, int status, int upgradeFlavor) {
        String versionName = "";
        int versionCode = 0;
        try {
            PackageManager manager = context.getPackageManager();
            PackageInfo info = manager.getPackageInfo(context.getPackageName(), 0);
            versionName = info.versionName;
            versionCode = info.versionCode;
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }

        SQLiteDatabase writableDatabase = getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put(URL, url);
        values.put(PATH, "");
        values.put(APK_NAME, apk_name);
        values.put(HEADER, header);
        values.put(CURRENT_LENGTH, 0);
        values.put(MAX_LENGTH, 0);
        values.put(STATUS, status);
        values.put(VERSION_NAME, versionName);
        values.put(VERSION_CODE, versionCode);
        values.put(UPGRADE_FLAVOR, upgradeFlavor);
        return writableDatabase.insert(VERSION_MANAGER, null, values);
    }

    void update(long id, String url, String path, String apkName, String header, Long current_length, Long max_length, int status) {
        SQLiteDatabase writableDatabase = getWritableDatabase();
        ContentValues values = new ContentValues();
        if (current_length != null) {
            values.put(CURRENT_LENGTH, current_length);
        }
        if (max_length != null) {
            values.put(MAX_LENGTH, max_length);
        }
        if (url != null) {
            values.put(URL, url);
        }

        if (path != null) {
            values.put(PATH, path);
        }

        if (apkName != null) {
            values.put(APK_NAME, apkName);
        }
        if (header != null) {
            values.put(HEADER, header);
        }
        values.put(STATUS, status);
        writableDatabase.update(VERSION_MANAGER, values, ID + "=?", new String[]{String.valueOf(id)});
    }

    void update(long id, Long current_length, Long max_length, int status) {
        SQLiteDatabase writableDatabase = getWritableDatabase();
        ContentValues values = new ContentValues();
        if (current_length != null) {
            values.put(CURRENT_LENGTH, current_length);
        }
        if (max_length != null) {
            values.put(MAX_LENGTH, max_length);
        }
        values.put(STATUS, status);
        writableDatabase.update(VERSION_MANAGER, values, ID + "=?", new String[]{String.valueOf(id)});
    }

    void delete(long id) {
        SQLiteDatabase writableDatabase = getWritableDatabase();
        writableDatabase.delete(VERSION_MANAGER, ID + "=?", new String[]{String.valueOf(id)});
    }

    public void pauseDownloading() {
        SQLiteDatabase writableDatabase = getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put(STATUS, DownloadStatus.STATUS_PAUSED.getValue());
        writableDatabase.update(VERSION_MANAGER, values, STATUS + "=? or " + STATUS + "=?", new String[]{String.valueOf(DownloadStatus.STATUS_PENDING.getValue()), String.valueOf(DownloadStatus.STATUS_RUNNING.getValue()),});
    }
}
