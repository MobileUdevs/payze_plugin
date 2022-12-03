package uz.udevs.payze_plugin


import android.app.Activity
import android.content.Intent
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import uz.udevs.payze_plugin.PayzePlugin.Payze.MAIN_ACTIVITY
import uz.udevs.payze_plugin.PayzePlugin.Payze.PAYZE_ACTIVITY_FINISH

/** PayzePlugin */
class PayzePlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    PluginRegistry.NewIntentListener, PluginRegistry.ActivityResultListener {

    private lateinit var channel: MethodChannel
    private var resultMethod: Result? = null
    private var activity: Activity? = null

    object Payze {
        const val MAIN_ACTIVITY = 201
        const val PAYZE_ACTIVITY_FINISH = 301
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "payze_plugin")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        resultMethod = result
        if (call.method == "payze_open") {
            val intent = Intent(activity, PayzeActivity::class.java)
            intent.putExtra("number", call.argument<String>("number"))
            intent.putExtra("cardHolder", call.argument<String>("cardHolder"))
            intent.putExtra("expirationDate", call.argument<String>("expirationDate"))
            intent.putExtra("securityNumber", call.argument<String>("securityNumber"))
            intent.putExtra("transactionId", call.argument<String>("transactionId"))
            activity?.startActivityForResult(intent, MAIN_ACTIVITY)
        } else {
            result.notImplemented()
        }
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onNewIntent(intent: Intent): Boolean {
        return true
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == MAIN_ACTIVITY && resultCode == PAYZE_ACTIVITY_FINISH) {
            if (data == null || data.extras == null) {
                resultMethod?.success(false)
            } else if (data.getStringExtra("result") == null) {
                resultMethod?.success(false)
            } else {
                resultMethod?.success(data.getBooleanExtra("result", false))
            }
        }
        return true
    }

}
