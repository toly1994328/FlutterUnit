package com.example.r_upgrade.common.tasks;

import android.os.AsyncTask;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;

import java.io.IOException;

public class CheckXiaoMiStoreVersionTask extends AsyncTask<String, String, String> {
    private final String packageName;
    private final VersionCallBack callBack;

    public CheckXiaoMiStoreVersionTask(String packageName, VersionCallBack callBack) {
        this.packageName = packageName;
        this.callBack = callBack;
    }

    @Override
    protected String doInBackground(String... strings) {
        String latestVersion = "";
        try {
            Element element = Jsoup.connect("https://app.mi.com/details?id="+packageName)
                    .timeout(30000)
                    .referrer("https://app.mi.com")
                    .get()
                    .select("div.container:nth-child(1) > div:nth-child(6) > div:nth-child(1) > div:nth-child(2)")
                    .first();
            if (element != null) {
                latestVersion = element.ownText();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return latestVersion;
    }

    @Override
    protected void onPostExecute(String s) {
        super.onPostExecute(s);
        callBack.versionName(s);
    }
}
