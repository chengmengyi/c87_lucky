package com.scratch.luckycard.lucky_base;

import androidx.annotation.Keep;
import android.os.Handler;
import android.os.Message;


@Keep
public class LuckyH extends Handler {

    @Keep
    public LuckyH() {

    }
    @Keep
    @Override
    public void handleMessage(Message message) {
        int r0 = message.what;
        LuckyL.LuckyB(r0);
    }
}

