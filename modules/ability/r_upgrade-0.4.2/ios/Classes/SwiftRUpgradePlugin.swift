import Flutter
import UIKit

public class SwiftRUpgradePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.rhyme/r_upgrade_method", binaryMessenger: registrar.messenger())
        let instance = SwiftRUpgradePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "setDebug":
            result(nil)
            break
        case "upgradeFromUrl":
            print(call.arguments ?? "null")
            guard let url = (call.arguments as? Dictionary<String, Any>)?["url"] as? String else {
                result(FlutterError(code: "参数url不能为空", message: nil, details: nil))
                return
            }
            result(openUrl(url: url))
            break
        case "upgradeFromAppStore":
            print(call.arguments ?? "null")
            guard let appId = (call.arguments as? Dictionary<String, Any>)?["appId"] as? String else {
                result(FlutterError(code: "参数appId不能为空", message: nil, details: nil))
                return
            }
            guard let isChina = (call.arguments as? Dictionary<String, Any>)?["isChina"] as? Bool else {
                result(FlutterError(code: "参数isChina不能为空", message: nil, details: nil))
                return
            }
            upgradeFromAppStore(appId: appId,isChina: isChina,result: result)
            break;
        case "getVersionFromAppStore":
            print(call.arguments ?? "null")
            guard let appId = (call.arguments as? Dictionary<String, Any>)?["appId"] as? String else{
                result(FlutterError(code: "参数appId不能为空", message: nil, details: nil))
                return
            }
            guard let isChina = (call.arguments as? Dictionary<String, Any>)?["isChina"] as? Bool else {
                result(FlutterError(code: "参数isChina不能为空", message: nil, details: nil))
                return
            }
            getVersionFromAppStore(appId: appId,isChina:isChina,result: result)
            break;
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    func openUrl(url:String) ->Bool{
        if let url = URL(string: url) {
            //根据iOS系统版本，分别处理
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],completionHandler: {(success) in })
            } else {
                UIApplication.shared.openURL(url)
            }
            return true;
        }
        return false;
    }
    
    //跳转到应用的AppStore页页面
    func upgradeFromAppStore(appId: String, isChina: Bool,result: @escaping FlutterResult) {
        getInfoFromAppStore(appId: appId,isChina: isChina) { dict in
            if dict == nil{
                result(false)
            }else{
                let res = dict!["results"] as! NSArray
                let xx = res[0] as! NSDictionary
                let urlString = xx["trackViewUrl"] as! String
                result(self.openUrl(url: urlString))
            }
           
        } error: { error in
            result(false)
        }
    }
    
    //获取应用信息
    func getInfoFromAppStore(appId:String,isChina:Bool,complete:@escaping(_ result:NSDictionary?)->Void,error:@escaping(_ error:Error?)->Void) {
        let checkLink = isChina == true ? "https://itunes.apple.com/cn/lookup?id=" : "https://itunes.apple.com/lookup?id="
        let appUrl = checkLink + appId
            let url = NSURL(string: appUrl)! as URL
            let request = NSMutableURLRequest(url: url, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 30)
            request.httpMethod = "GET"
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request as URLRequest){(data,response,err) in
                if err == nil{
                    if data == nil{
                        NSLog("获取appId:%@ 对应的appStore信息失败",appId)
                        complete(nil)
                    }
                    let httpRequest = response as! HTTPURLResponse
                    if httpRequest.statusCode == 200 {
                            let json = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves) as! NSDictionary
                        if json["resultCount"] as! Int > 0{
                            complete(json)
                        }else{
                            NSLog("获取appId:%@ 对应的appStore信息失败，未上架或ID不存在", appId)
                            complete(nil)
                        }
                    }else{
                        NSLog("获取appId:%@ 对应的appStore信息失败，未上架或ID不存在", appId)
                        complete(nil)
                    }
                }else{
                    NSLog("获取appId:%@ 对应的appStore信息失败",appId)
                    error(err)
                }
            }
        task.resume()
    }
    
    func getVersionFromAppStore(appId:String,isChina:Bool,result: @escaping FlutterResult){
        getInfoFromAppStore(appId: appId,isChina: isChina) {dict in
            if dict != nil {
                let res = dict!["results"] as! NSArray
                let xx = res[0] as! NSDictionary
                result(xx["version"]! as! String)
            }else{
                result(nil)
            }
        } error: { err in
            result(nil)
        }
    }
}
