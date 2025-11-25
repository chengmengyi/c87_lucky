package com.lucky.dash.lucky_dash_pro_h;


import androidx.annotation.Keep;
import android.webkit.WebResourceRequest;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.util.Log;

@Keep
public class Wjidwjdow extends WebViewClient {

    @Keep
    @Override
    public void onPageStarted(WebView view, String url, android.graphics.Bitmap favicon) {
        super.onPageStarted(view, url, favicon);
        Log.e("qwer",url);
    }


    @Keep
    @Override
    public void onPageFinished(WebView view, String url) {
        super.onPageFinished(view, url);
    }
}
