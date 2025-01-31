package com.example.r_upgrade.common;

public enum DownloadStatus {
    STATUS_PAUSED(0),
    STATUS_PENDING(1),
    STATUS_RUNNING(2),
    STATUS_SUCCESSFUL(3),
    STATUS_FAILED(4),
    STATUS_CANCEL(5);

    private int value;

    DownloadStatus(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }
}
