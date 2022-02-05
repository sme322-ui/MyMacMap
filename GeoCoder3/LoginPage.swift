//
//  LoginPage.swift
//  GeoCoder3
//
//  Created by Sie monyan on 2022/1/23.
//

import Foundation
import UIKit
import UIKit
import LocalAuthentication
class LoginPage: UIViewController {
     

    @IBOutlet var account: UITextField!
    
    @IBOutlet var password: UITextField!
  
    

    let myAccount = "tony" //驗證帳號
    let myPassword = "123" //驗證密碼
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       authenticateWithTouchID()
        
        let context = LAContext()
                var error: NSError? = nil
                let canEvaluatePolicy = context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) as Bool
                if error != nil {
                    print(error!.localizedDescription as String)
                }
                
                if canEvaluatePolicy {
                    print("有指纹验证功能")
                    context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "放上您的狗爪", reply: { (success: Bool, error: Error?) in
                        if success {
                            print("验证成功")
                        } else {
                            print("验证失败: \(error?.localizedDescription)")
                        }
                    })
                } else {
                    print("还没开启指纹验证呢")
                }
    LoginPage.myFingureAuthentication { (result) in
                switch result {
                case .success:
                    print("成功")
                case .fialed:
                    print("失败")
                case .passwordNotSet:
                    print("未设置密码")
                case .touchIDNotSet:
                    print("未设置指纹")
                case .touchIDNotAvaliable:
                    print("系统不支持")
                default:
                    break
                }
            }
    }
     
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Variable Declaration(s)
    class var isFaceIdAvailable: Bool {
        let context: LAContext = LAContext()
        let evaluate = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        if #available(iOS 11.0, *) {
            return (context.biometryType == .faceID)
        }
        return evaluate
    }

    //登入

    @IBAction func login(sender:AnyObject){
    if(self.password.text=="123"&&self.account.text == "tony"){
      NSLog("登入成功")
        self.password.resignFirstResponder()
        self.account.resignFirstResponder()
        performSegue(withIdentifier: "ViewController", sender: nil)
        print("Successfully authentically")
        OperationQueue.main.addOperation({
            self.performSegue(withIdentifier: "ViewController", sender: nil)
        })
    }else{
        view.transform = CGAffineTransform(translationX: 25,y: 0)
        UIView.animate(withDuration: 0.2, animations: {
            
        }, completion: nil)
        dismiss(animated: true, completion: nil)
        
    }
        
    }
    
   
    func authenticateWithTouchID(){
        let localAuthContext = LAContext()
        let resonText = "Authentication is required to sign in AppCoda"
        var authError:NSError?
        
        if !localAuthContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics,error: &authError){
            print(authError?.localizedDescription)
            
            return
            
        }
        if localAuthContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
               localAuthContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: resonText) { [weak self] (success, error) in
                   if success {
                       // success
                    print("Successfully authentically")
                    OperationQueue.main.addOperation({
                        self?.performSegue(withIdentifier: "ViewController", sender: nil)
                    })
                   } else {
                       // failure
                    switch authError!.code{
                    case LAError.authenticationFailed.rawValue:
                        print("Authentication failed")
                    case LAError.passcodeNotSet.rawValue:
                        print("Password not set")
                    case LAError.systemCancel.rawValue:
                        print("Authentication was canceled by system")
                    case LAError.userCancel.rawValue:
                        print("Authentication was canceled by the user")
                    case LAError.touchIDNotEnrolled.rawValue:
                        print("Authentication could not start because Touch ID is not available.")
                    case LAError.userFallback.rawValue:
                        print("User Tapped the fallback button (Enter Password)")
                    default:
                        print(authError?.localizedDescription)
                    }
                    
                    
                   }
               }
           } else {
               // can't evaluate policy
            dismiss(animated: true, completion: nil)
           }
        
        
        
    }
    
 

    
    //清除
    @IBAction func reset(sender: UIButton) {
        account.text = ""
        password.text = ""
    }
    static func myFingureAuthentication(withTips tips: String = "验证指纹", block: @escaping (_ result: FingureCheckResult) -> () ) {
        guard #available(iOS 8.0, *) else {
            block(FingureCheckResult.touchIDNotAvaliable)
            return
        }
        let context = LAContext()
        var error: NSError? = nil
        
        if context.canEvaluatePolicy(LAPolicy(rawValue: Int(kLAPolicyDeviceOwnerAuthenticationWithBiometrics))!, error: &error) {
            context.evaluatePolicy(LAPolicy(rawValue: Int(kLAPolicyDeviceOwnerAuthenticationWithBiometrics))!, localizedReason: tips, reply: { (success, error) in
                if success {
                    block(FingureCheckResult.success)
                    print("指纹验证成功")
                }else {
                    let laError = error as! LAError
                    switch laError.code {
                    case LAError.authenticationFailed:
                        block(FingureCheckResult.fialed)
                        print("连续三次输入错误，身份验证失败")
                    case LAError.userCancel:
                        block(FingureCheckResult.userCancel)
                        print("用户点击取消按钮")
                    case LAError.userFallback:
                        block(FingureCheckResult.inputPassword)
                        print("用户点击输入密码")
                    case LAError.systemCancel:
                        block(FingureCheckResult.systemCancel)
                        print("系统取消")
                    case LAError.passcodeNotSet:
                        block(FingureCheckResult.passwordNotSet)
                        print("用户未设置密码")
                    case LAError.touchIDNotAvailable:
                        block(FingureCheckResult.touchIDNotAvaliable)
                        print("touchID不可用")
                    case LAError.touchIDNotEnrolled:
                        block(FingureCheckResult.touchIDNotSet)
                        print("touchID未设置指纹")
                    default:
                        break
                    }
                }
            })
        }else {
            print("不支持TouchID")
        }
    }
    }
enum FingureCheckResult {
    case success    //成功
    case fialed     //失败
    case passwordNotSet     //未设置手机密码
    case touchIDNotSet      //未设置指纹
    case touchIDNotAvaliable       //不支持指纹
    case systemCancel       //系统取消
    case userCancel         //用户取消
    case inputPassword      //输入密码
}
     

