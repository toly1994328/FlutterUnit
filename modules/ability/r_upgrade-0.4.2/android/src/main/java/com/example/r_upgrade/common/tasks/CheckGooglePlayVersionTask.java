package com.example.r_upgrade.common.tasks;

import android.os.AsyncTask;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;

import java.io.IOException;

public class CheckGooglePlayVersionTask extends AsyncTask<String, String, String> {
    private final String packageName;
    private final VersionCallBack callBack;

    public CheckGooglePlayVersionTask(String packageName, VersionCallBack callBack) {
        this.packageName = packageName;
        this.callBack = callBack;
    }

    @Override
    protected String doInBackground(String... strings) {
        String latestVersion = "";
        try {
            Element element = Jsoup.connect("https://play.google.com/store/apps/details?id=" + packageName)
                    .timeout(30000)
                    .referrer("http://www.google.com")
                    .get()
                    .select("div.hAyfc:nth-child(4) > span:nth-child(2) > div:nth-child(1) > span:nth-child(1)")
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
