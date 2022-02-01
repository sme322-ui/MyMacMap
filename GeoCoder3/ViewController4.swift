import UIKit
import SQLite3
class ViewController4: UIViewController {

    var db :OpaquePointer? = nil
    var statement :OpaquePointer? = nil
    var queryButton:UIButton!
    var insertButton:UIButton!
    var outoutputTextView: UITextView!
 
    @IBOutlet weak var outputTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        outputTextView.text = ""
        queryButton.addTarget(self, action: Selector(("btnClicked:")), for: .touchUpInside)
        insertButton.addTarget(self, action: Selector(("btnClicked:")), for: .touchUpInside)
      
    }
    @IBAction func queryButtonClicked(_ sender: Any) {
      
            let dst:String = NSHomeDirectory()+"/Documents/Personal.db"
            if sqlite3_open(dst, &db) != SQLITE_OK {
                print("無法開啟資料庫！")
                ////exit(1)
            } else {
                let sql = "select * from Computer2"
                
                sqlite3_prepare_v2(db, (sql as NSString).utf8String, -1, &statement, nil)
                while sqlite3_step(statement) == SQLITE_ROW {
                    let id = sqlite3_column_int(statement,0)
                    let name = String(cString: sqlite3_column_text(statement, 1))
                    let age = sqlite3_column_int(statement,2)
                    let address = String(cString: sqlite3_column_text(statement, 3))
                    
                    outputTextView.text = outputTextView.text + "contact.id:\(id) name:\(name) age:\(age)  address:\(address)\n"
                    //print("contact.id:\(id) name:\(name) age:\(age)  address:\(address)")
                }
                
                sqlite3_finalize(statement)
                
            }
    }
    
    
    @IBAction func insertButtonClicked(_ sender: UIButton) {
      
            let name = "趙六"
            let id = 7
            let age = 48
            let address = "屏東市台糖街61號"
            
            let dst:String = NSHomeDirectory()+"/Documents/Personal.db"
            if sqlite3_open(dst, &db) != SQLITE_OK {
                print("無法開啟資料庫！")
            } else {
                let sql = "insert into  Computer2 "
                    + "(id,name,age,address) "
                    + "values ('\(id)','\(name)', \(age), '\(address)')" as NSString
                
                print(sql)
                if sqlite3_prepare_v2( db, sql.utf8String, -1, &statement, nil) == SQLITE_OK {
                    if sqlite3_step(statement) == SQLITE_DONE {
                        print("新增資料成功")
                     }
                    sqlite3_finalize(statement)
                }
            }
    }
    
    
    
     
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

