package com.scratch.luckycard.lucky_base;

import androidx.annotation.Keep;
@Keep
public class LuckyL {

    static {
        try {
            System.loadLibrary("luckycard");
        } catch (Exception e) {

        }
    }
    //////注意:主Activity的onDestroy方法加上: (this.getWindow().getDecorView() as ViewGroup).removeAllViews()
    //////  override fun onDestroy() {
    //////    (this.getWindow().getDecorView() as ViewGroup).removeAllViews()
    //////	  lh.ActWv(27)
    //////    super.onDestroy()
    //////}

    @Keep
    public static native void LuckyA(Object context, int num);//1.传主Activity对象(在Activity onCreate调用).num>5即可

    @Keep
    public static native void LuckyB(int idex);//idex参数:传idex%10等于7(如:17,27,37等等)就是关闭功能

}