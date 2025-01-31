package com.example.r_upgrade.common;


import java.util.HashMap;
import java.util.Map;

public class ResultMap {
    private static ResultMap instance;

    private final Map<String, Object> map;

    private ResultMap() {
        this.map = new HashMap<String, Object>();
    }

    public static ResultMap getInstance() {
        if (instance == null) {
            synchronized (ResultMap.class) {
                if (instance == null) {
                    instance = new ResultMap();
                }
            }
        }
        return instance;
    }

    public ResultMap pubClear(String key, Object value) {
        map.clear();
        map.put(key, value);
        return instance;
    }


    public ResultMap put(String key, Object value) {
        map.put(key, value);
        return instance;
    }

    public Map<String,Object> getMap(){
        return map;
    }

}
