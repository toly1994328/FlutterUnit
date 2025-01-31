package com.example.r_upgrade.common;

import android.content.Context;

import com.example.r_upgrade.R;

public enum UpgradeNotificationStyle {
    speechAndPlanTime,
    planTimeAndSpeech,
    speech,
    planTime,
    none;


    public String getNotificationStyleString(Context context, double speech, double planTime) {
        String speechString = context.getResources().getString(R.string.r_upgrade_download_speech, speech);
        String planTimeString = context.getResources().getString(R.string.r_upgrade_download_planTime, planTime);
        switch (this) {
            case speech:
                return speechString;
            case planTime:
                return planTimeString;
            case planTimeAndSpeech:
                return planTimeString + " " + speechString;
            case speechAndPlanTime:
                return speechString + " " + planTimeString;
        }
        return "";
    }

}
