import Flutter
import Payze_iOS_sdk
import UIKit

public class SwiftPayzePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "payze_plugin", binaryMessenger: registrar.messenger())
        let instance = SwiftPayzePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "payze_open") {
            let args = call.arguments as? [String:Any]
            let number = args?["number"] as! String
            let cardHolder = args?["cardHolder"] as! String
            let expirationDate = args?["expirationDate"] as! String
            let securityNumber = args?["securityNumber"] as! String
            let transactionId = args?["transactionId"] as! String
            let billingAdress = args?["billingAddress"] as! String
            guard let paymentDetails = PaymentDetails.init(number: number,
                                                           cardHolder: cardHolder,
                                                           expirationDate: expirationDate,
                                                           securityNumber: securityNumber,
                                                           transactionId: transactionId,
                                                           billingAddress: billingAdress) else {
                result(false)
                return
            }
            PaymentService.shared.startPayment(paymentDetails: paymentDetails) { results in
                print(results)
                result(true)
            }
        }
        
    }
}
