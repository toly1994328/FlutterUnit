package com.example.r_upgrade.common.install;

import android.content.Context;
import android.content.ContextWrapper;
import android.net.Uri;

public abstract class BaseInstallFactory extends ContextWrapper {

    public BaseInstallFactory(Context base) {
        super(base);
    }

    public abstract  boolean install(Uri uri);
}
