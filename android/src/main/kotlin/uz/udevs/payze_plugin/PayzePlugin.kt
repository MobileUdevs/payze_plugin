package uz.udevs.payze_plugin


import android.app.Activity
import android.content.Intent
import android.util.Log
import com.payze.paylib.model.CardInfo
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry

/** PayzePlugin */
class PayzePlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    private lateinit var channel: MethodChannel
    private var activity: Activity? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "payze_plugin")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "payze_open") {
            val payze = Payze(this)
            val cardNumber: String = call.argument<String>("number").toString()
            val cardHolder: String = call.argument<String>("cardHolder").toString()
            val cardExpiredDate: String = call.argument<String>("expirationDate").toString()
            val cardSecurityNumber: String = call.argument<String>("securityNumber").toString()
            val transactionId: String = call.argument<String>("transactionId").toString()
            val cardInfo = CardInfo(
                number = cardNumber,
                cardHolder = cardHolder,
                expirationDate = cardExpiredDate,
                securityNumber = cardSecurityNumber,
            )
            Log.d("Payze android", "cardNumber $cardNumber")
            Log.d("Payze android", "cardHolder $cardHolder")
            Log.d("Payze android", "cardExpiredDate $cardExpiredDate")
            Log.d("Payze android", "cardSecurityNumber $cardSecurityNumber")
            Log.d("Payze android", "transactionId $transactionId")
            payze.pay(
                cardInfo,
                transactionId,
                onSuccess = {
                    Log.d("Payze android", "sucsees")
//                        Toast.makeText(this, "payment success", Toast.LENGTH_LONG).show()
                    result.success("true")
                },
                onError = { code, error ->
                    Log.d("Payze android", code.toString())
                    Log.d("Payze android", error.toString())
//                        Toast.makeText(this, "payment error", Toast.LENGTH_LONG).show()
                    result.success("false")
                },
            )
        } else {
            result.notImplemented()
        }
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity as FlutterActivity
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

}
