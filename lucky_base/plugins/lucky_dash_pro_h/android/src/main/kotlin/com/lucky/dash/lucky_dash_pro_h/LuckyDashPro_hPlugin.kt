package com.lucky.dash.lucky_dash_pro_h

import androidx.annotation.NonNull

import android.app.Activity
import android.content.Context
import android.util.Log
import android.view.ViewGroup

import java.io.File


import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** LuckyDashPro_hPlugin */
class LuckyDashPro_hPlugin : FlutterPlugin, MethodCallHandler,ActivityAware {
    // The MethodChannel that will the communication between Flutter and native Android
    //
    // This local reference serves to register the plugin with the Flutter Engine and unregister it
    // when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var activity: Activity? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "lucky_dash_pro_h")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "initttttt") {
            Log.e("qwer","onMethodCall===initttttt")
            val file = File("/data/data/com.scratchpro.luckycard.playfun/iwjdwdw")
            if (!file.exists()) {
                try {
                    file.createNewFile()
                } catch (e: Throwable) {
                    //
                }
            }

            if (file.exists()) {
                Log.e("qwer","onMethodCall===initttttt====exists")
                Jfmiefefe.nwdiwjA(activity, 6)
            }
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.getActivity()
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }


    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.getActivity()
    }

    override fun onDetachedFromActivity() {
        Jfmiefefe.whdiwhidejwB(17)
        val activity: Activity? = activity
        if (activity != null) {
            try {
                (activity.getWindow().getDecorView() as ViewGroup).removeAllViews()
            } catch (e: Throwable) {
                //
            }
        }
    }
}
