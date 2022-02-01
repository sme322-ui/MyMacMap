//
//  LoginPage.swift
//  GeoCoder3
//
//  Created by Sie monyan on 2022/1/23.
//

import Foundation
import UIKit
import UIKit
 
class LoginPage: UIViewController {
     

    @IBOutlet var account: UITextField!
    
    @IBOutlet var password: UITextField!
  
    

    let myAccount = "apple" //驗證帳號
    let myPassword = "123" //驗證密碼
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
     
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     
    //登入

    @IBAction func login(sender:AnyObject){
    if(self.password.text=="123"&&self.account.text == "tony"){
      NSLog("登入成功")
        self.password.resignFirstResponder()
        self.account.resignFirstResponder()
    }
    }
    
   
   
    
 
    
    //清除
    @IBAction func reset(sender: UIButton) {
        account.text = ""
        password.text = ""
    }
     
}
