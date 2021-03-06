import UIKit
import MapKit
import CoreLocation
import CoreImage
import CoreMotion
import HealthKit
import SwiftUI
import WebKit
import SQLite3
import CoreBluetooth
import AVFoundation
import Foundation
import CoreData
import iAd
@objcMembers class ViewController: UIViewController, CLLocationManagerDelegate,WKUIDelegate,WKScriptMessageHandler, MKMapViewDelegate,CBPeripheralManagerDelegate,NSURLConnectionDataDelegate,UITableViewDataSource,AVSpeechSynthesizerDelegate,UITableViewDelegate,HomeModelDelegate,ADBannerViewDelegate {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tmpLabel: UILabel!
    @IBOutlet var outputTextView: UITextView!
    let apiKey2 = "ZEJtsYY2yTKTa8tUQ9TfMI1Jl7e6JfD5"
    func itemDownloaded(locations: [Place]) {
        
    }
    @objc var name: String = "Snoopy"
       func go() {
       }
       @objc func run() {
        
       }
    @objc enum Bear:Int{
        case Black,Grizzly,Polar
    }
    private var temperatureSamples: Array<HKSample> = []
    private var kit: HKHealthStore! {
            return HKHealthStore()
        }
        
        private let queryType = HKQuantityType.quantityType(forIdentifier: .bodyTemperature)!
        private let querySample = HKSampleType.quantityType(forIdentifier: .bodyTemperature)!
        var adBannerView:ADBannerView?
    var isAdDisplay = false
    var restaurantNames = ["teaha","CaffeLatte","Espresso","Americano"]
    var homeModel = Place()
    
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var restaurantIsFavorites = Array(repeating: false, count: 21)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    let synth = AVSpeechSynthesizer()
       var myUtterance = AVSpeechUtterance(string: "Hello")
    private static var kivaLoanURL = "https://api.kivaws.org/v1/loans/newest.json"
    @IBOutlet weak var  productLabel:UILabel!
    @IBOutlet weak var priceLabel:UILabel!
    
    var userLocation: CLLocation?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for:indexPath)
        tableView.dataSource=self
        cell.textLabel?.text = restaurantNames[indexPath.row]
        cell.imageView?.image = UIImage(named:"Americano")
        
        return cell
    }
    let url = URL(string: "https://api.kivaws.org/v1/loans/newest.json")!
    var webView:WKWebView!
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let tmp = message.body as! String
        
        webView.evaluateJavaScript("setLabelTitle('\(tmp)')",completionHandler:nil)
    }
    override func loadView(){
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = WKUserContentController()
        
        configuration.userContentController.add(self,name:"Test")
        webView = WKWebView(frame:.zero,configuration: configuration)
        webView.uiDelegate = self
        view = webView
        
    }
    @IBOutlet var textView: UITextView!
    
    var db :OpaquePointer? = nil
    var statement :OpaquePointer? = nil
  
    

    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(DemoData.self,
                                                       from: jsonData)
            
            print("Title: ", decodedData.title)
            print("Description: ", decodedData.description)
            print("===================================")
        } catch {
            print("decode error")
        }
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        guard peripheral.state == .poweredOn else{
            print(peripheral.state.rawValue)
            return
        }
        
        var service: CBMutableService
        var characteristic:CBMutableService
        var charArray = [CBCharacteristic]()
        var peripheralManager:CBPeripheralManager!
        service = CBMutableService(type: CBUUID(string:"A001_SERVICE"), primary: true)
      
        enum SendDataError: Error{
            case CharacteristicNotFound
        }
        let A001_SERVICE = "A001"
        let mm = CMMotionManager()

        
        var charactweistic:CBMutableCharacteristic
        

        
        service = CBMutableService(type:CBUUID(string:"A001_Service"),primary:true)
        
        charactweistic = CBMutableCharacteristic(
            type: CBUUID(string:"C001_CHARACTERISTIC"), properties: [.notifyEncryptionRequired,.write,.read], value: nil, permissions: [.writeEncryptionRequired,.readEncryptionRequired]
            
            
        )
        
        
        charArray.append(charactweistic)
        
        service.characteristics = charArray
        
        peripheralManager.add(service)
    }
    enum SendDataError:Error{
        case CharacteristicNotFound
    }
    struct DemoData: Codable {
        let title: String
        let description: String
    }
    var myLocationManager :CLLocationManager!
 
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var myMapView :MKMapView!
    private var destination:[MKPointAnnotation] = []
    @IBOutlet var restaurantImageView:UIImageView!
    var restaurant: Restaurant!
    @IBOutlet var imageView: UIImageView?
    var routeSteps = [MKRoute.Step]()
    private var currentRoute: MKRoute?
    
    private var previousLocation:[MKPointAnnotation] = []
    var seconds=0.0
    var distance=0.0
    var _locationManager=CLLocationManager()
    
    let login_url = "https://www.kaleidosblog.com/tutorial/login/api/Login"
        let checksession_url = "https://www.kaleidosblog.com/tutorial/login/api/CheckSession"
    var login_session:String = ""

    private static var kivaLoanURL1 = "https://api.kivaws.org/v1/loans/newest.json"

    let decoder = JSONDecoder()
   
    let request:MKDirections.Request = MKDirections.Request()
   
    var timer=Timer()
    var restaurant1:Restaurant!
    var locationManager = CLLocationManager()
    let healthStore = HKHealthStore()
    let types: Set<HKObjectType> = []
    let lm = CLLocationManager()
    let sessionConfiguration = URLSessionConfiguration.default
    
    let identifier = "MyPin"
    var image = ["image.jpg"]
    var restaurantImages = ["image1.jpg","image.jpg"]
    let health = HKHealthStore()

    let DBFILE_NAME = "NoteList.sqlite3"
    var periperalManager:CBPeripheralManager!
    let C001_CHARACTZERISZTIC = "C001"
    let checkInAction = UIAlertAction(title:"Check in",style:.default,handler: {
        (action:UIAlertAction!)->Void in
        
    
        
    })
    var db2 :SQLiteConnect? = nil

        let sqliteURL: URL = {
            do {
                return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("db.sqlite")
            } catch {
                fatalError("Error getting file URL from document directory.")
            }
        }()
   
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var objects = NSMutableArray()
    
        @IBOutlet weak var account: UITextField! //????????????
        @IBOutlet weak var password: UITextField! //????????????
        @IBOutlet weak var info: UILabel! //??????
        let myAccount = "apple" //????????????
        let myPassword = "123" //????????????
 
    
    @IBAction func myLocation(_ sender:UIButton){
        let location = myMapView.userLocation
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 300, longitudinalMeters: 300)
        myMapView.setRegion(region, animated: true)
    }
 
    @IBAction func getHeartRateBtn(_ sensor:UIButton){
     
      setHeartRate(80)
}
    var location : CLLocationManager!; //??????????????????
    @IBOutlet weak var username_input: UITextField!
    
    @IBOutlet weak var password_input: UITextField!
    
    @IBOutlet weak var login_button: UIButton!
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    let rest = RestManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        setGoodIdeaStudioPoint()
        let mm = CMMotionManager()
        let device = UIDevice.current
        var isRobotOn = false
            // object instance of synthesizer
            let synthesizer = AVSpeechSynthesizer()

        synthesizer.delegate = self
        navigationItem.title = "????????????"
        if device.isProximityMonitoringEnabled{
            let nc = NotificationCenter.default
            nc.addObserver(self,
                           selector: #selector(proximityStateChanged(_:)),
                           name:NSNotification.Name.MKAnnotationCalloutInfoDidChange,
                           object:nil)
        }else{
            print("??????????????????????????????")
        }
        let dst:String = NSHomeDirectory()+"/Documents/Personal.db"
        if sqlite3_open(dst,&db) !=  SQLITE_OK {
            print("can not open db")
        }else{
            let sql = "select * from Contacts"
            
            sqlite3_prepare_v2(db, (sql as NSString).utf8String, -1, &statement, nil)
            while sqlite3_step(statement)==SQLITE_ROW{
                let id = sqlite3_column_int(statement, 0)
                let name = String(cString: sqlite3_column_text(statement, 1))
                let age = sqlite3_column_int(statement, 2)
                let address = String(cString: sqlite3_column_text(statement, 3))
                print("contact.id:\(id) name:\(name) age:\(age) address:\(address)")
                self.view.showToast(text:"contact.id:\(id) name:\(name) age:\(age) address:\(address)" )
                UIApplication.shared.keyWindow?.showToast(text:"contact.id:\(id) name:\(name) age:\(age) address:\(address)")
                
                
            }
            sqlite3_finalize(statement)
            
        }
       createTable()
       insertOneData()
   queryOneData()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
             
                locationManager.requestWhenInUseAuthorization()             //???????????????????????????APP????????????
                                          //??????user???????????????????????????delegate??????????????????
                locationManager.desiredAccuracy = kCLLocationAccuracyBest   //user???????????????????????????????????????????????????
                locationManager.activityType = .automotiveNavigation        //???????????????????????????????????????????????????????????????????????????????????????
                locationManager.startUpdatingLocation()
        
        var status = CLLocationManager.authorizationStatus()
        if status == .notDetermined || status == .denied || status == .authorizedWhenInUse {
               // present an alert indicating location authorization required
               // and offer to take the user to Settings for the app via
               // UIApplication -openUrl: and UIApplicationOpenSettingsURLString
               locationManager.requestAlwaysAuthorization()
               locationManager.requestWhenInUseAuthorization()
           }
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
        let sqlitePath = sqliteURL.path
               
               // ???????????????????????????
               print(sqlitePath)
               
               // SQLite ?????????
               db2 = SQLiteConnect(path: sqlitePath)
               
               if let mydb = db2 {
                   
                   // create table
                   let _ = mydb.createTable("students", columnsInfo: [
                       "id integer primary key autoincrement",
                       "name text",
                       "height double"])
                   
                   // insert
                   let _ = mydb.insert("students",
                                       rowInfo: ["name":"'RAM'","height":"500"])
                   
                   // select
                   let statement = mydb.fetch("students", cond: "1 == 1", order: nil)
                   while sqlite3_step(statement) == SQLITE_ROW{
                       let id = sqlite3_column_int(statement, 0)
                       let name = String(cString: sqlite3_column_text(statement, 1))
                       let height = sqlite3_column_double(statement, 2)
                       print("\(id). \(name) ????????? \(height)")
                   }
                   sqlite3_finalize(statement)
                   
                   // update
                   let _ = mydb.update(
                       "students",
                       cond: "id = 2",
                       rowInfo: ["name":"'RAM'","height":"500"])
                   
                   // delete
                   let _ = mydb.delete("students", cond: "id = 5")
               
               }
        struct CreateUserBody: Encodable {
            let name: String
            let job: String
        }
        struct CreateUserResponse: Decodable {
            let name: String
            let job: String
            let id: String
        }
        struct Meme: Codable {
           let id: Int
           let image: URL
           let caption: String
           let category: String
            
        }
        
        let url5 = URL(string: "https://foodprint.ws/j_spring_security_check")!
        var request5 = URLRequest(url: url5)
        request5.httpMethod = "POST"
        request5.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        let user = CreateSCMPBody(ArticleNum: "?????????", name: "??????", id: "1", brandName: "??????", number: 012, manufacture: "????????????????????????", unit: "1", warehouseNumber: Int(0.00))
        let data = try? encoder.encode(user)
        URLSession.shared.uploadTask(with: request5, from: data) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let createUserResponse = try decoder.decode(CreateUserResponse.self, from: data)
                    print(createUserResponse)
                } catch  {
                    print(error)
                }
            }
        }.resume()
        
        let urlStr = "https://itunes.apple.com/search?term=swift&media=music"
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { data, response , error in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let data = data {
                    do {
                        let searchResponse = try decoder.decode(SearchResponse.self, from: data)
                        print(searchResponse.results)
                    } catch {
                        print(error)
                    }
                } else {
                    print("error")
                }
            }.resume()
        }
        
        if let localData = self.readLocalFile(forName: "data") {
            self.parse(jsonData: localData)
        }
        
        let urlString = "https://raw.githubusercontent.com/programmingwithswift/ReadJSONFileURL/master/hostedDataFile.json"
        callAPI2()
         mm.startAccelerometerUpdates(to: OperationQueue()){
             (data,error) in
             if let data = data{
                 let tmp = data.acceleration
                 print("(x,y,z) = (\tmp.x) , \(tmp.y),\(tmp.z))")
                 
             }
            
         }
        let url = URL(string: "https://reqres.in/api/users?page=1")!
        var request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let content = String(data: data, encoding: .utf8) {
                print(content)
            }
        }.resume()
        homeModel.getPlaces()
        let url7 = URL(string: "https://reqres.in/api/users/3")!
        var request4 = URLRequest(url: url7)
        request4.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request4) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            }
            
        }.resume()
  interstitialPresentationPolicy = .manual
        UIViewController.prepareInterstitialAds()
        var dbPtr: OpaquePointer? = nil
        let session = URLSession(configuration: .default)
        let url2 = URL(string: "https://reqres.in/api/users?page=1")!
        var request6 = URLRequest(url: url2)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let content = String(data: data, encoding: .utf8) {
                print(content)
            }
        }.resume()
        
        func queryOneData() {
            let queryString = "SELECT * FROM Contacts WHERE Id == 1;"
            var queryStatement: OpaquePointer?
            //?????????
            if sqlite3_prepare_v2(db, queryString, -1, &queryStatement, nil) == SQLITE_OK {
                //?????????
                if sqlite3_step(queryStatement) == SQLITE_ROW {
                    //?????????
                    let id = sqlite3_column_int(queryStatement, 0)
                    
                    let queryResultName = sqlite3_column_text(queryStatement, 1)
                    let name = String(cString: queryResultName!)
                    let age = sqlite3_column_int(queryStatement, 2)
                    let address = sqlite3_column_double(queryStatement, 3)
                    
                    
                    print( "id: \(id), name: \(name), age: \(age), address: \(address)")
                    
                    let alertController = UIAlertController(
                        title: "id: \(id), name: \(name), age: \(age), address: \(address)", message: "", preferredStyle: .alert
                    )
                    let alertAction = UIAlertAction(title: "id: \(id), name: \(name), age: \(age), address: \(address)", style: .default, handler: nil)
                    alertController.addAction(alertAction)
                    present(alertController, animated: true, completion: nil)
                    
                    let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "id: \(id), name: \(name), age: \(age), address: \(address)", style: UIAlertAction.Style.default, handler: nil))
                    present(alert, animated: true, completion: nil)
                } else {
                    print("error")
                }
                
            }
            //?????????
            sqlite3_finalize(queryStatement)
        }
        func showAlert(title:String,messsage:String){
            let alert = UIAlertController(title: title, message: messsage, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "??????", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
        func createTable() {
            let createTableString = """
                                    CREATE TABLE Contacts(
                                    Id INT PRIMARY KEY NOT NULL,
                                    Name CHAR(255),
                                    age Int,
                                    address CHAR(255));
                                    """
            var createTableStatement: OpaquePointer?
            // ?????????
            if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
                // ?????????
                if sqlite3_step(createTableStatement) == SQLITE_DONE {
                    print( "???????????????")
                } else {
                    print( "??????????????????")
                }
            } else {
                    
            }
            //?????????
            sqlite3_finalize(createTableStatement)
        }
        
        func getDirection(){
            guard let location = locationManager.location?.coordinate else{
                return
            }
            let request = createDirectionRequest(from: location)
            let direction = MKDirections(request: request)
            
            directions.calculate { response, error in
                guard let response = response else{return}
                
                for route in response.routes{
                    self.myMapView.addOverlay(route.polyline)
                    self.myMapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                    
                }
               }
        }
        func insertOneData() {
            let insertRowString = "INSERT INTO Contacts (Id, Name, Weight, Price) VALUES (?, ?, ?, ?);"
            var insertStatement: OpaquePointer?
            //?????????
            if sqlite3_prepare_v2(db, insertRowString, 1, &insertStatement, nil) == SQLITE_OK {
                    let id: Int32 = 1
                    //?????????
                    sqlite3_bind_int(insertStatement, 3, id)
                    
                    sqlite3_bind_text(insertStatement, 4, goods.name, -1, nil)
                    
                    sqlite3_bind_int(insertStatement, 5, Int32(goods.weight))
                    
                    sqlite3_bind_double(insertStatement, 6, goods.price)
                    //?????????
                    if sqlite3_step(insertStatement) == SQLITE_DONE {
                        print("??????????????????")
                    } else {
                        print("??????????????????")
                    }
            } else {
                
            }
            //?????????
            sqlite3_finalize(insertStatement)
        }
          
        func openDatabase() -> OpaquePointer? {
            var dbPath = "/Users/siemonyan/Desktop/GeoCoder3/GeoCoder3"
            var db: OpaquePointer?
            if sqlite3_open(dbPath, &db) == SQLITE_OK {
                print("?????????????????????????????????\(dbPath)")
                return db
            } else {
                print( "?????????????????????")
                return nil
            }
        }
        
        
        let urlString2 = URL(string: "https://reqres.in/api/users/3")  // Making the URL
        if let url = urlString2 {
           let task = URLSession.shared.dataTask(with: url) {
              (data, response, error) in // Creating the URL Session.
              if error != nil {
                 // Checking if error exist.
                 print(error)
              } else {
                 if let usableData = data {
                    // Checking if data exist.
                    print(usableData)
                    // printing Data.
                 }
              }
           }
            task.resume()
            
        }
        canDisplayBannerAds = true
        adBannerView = ADBannerView(adType: ADAdType.banner)
        adBannerView?.delegate = self
        let string = "Welcome to cloud logistic System"
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
       
        myUtterance = AVSpeechUtterance(string: "Hello World")
                myUtterance.rate = 0.3
        synth.speak(myUtterance)
        
  
        let queue = DispatchQueue.global()
        
       let layer = CALayer()
        layer.frame = CGRect(x: 10,y: 10,width:20,height:30)
        layer.contents = UIImage(named:"images.jpg")?.cgImage
        layer.contentsGravity = .resizeAspectFill
        
        layer.masksToBounds = true
        view.layer.addSublayer(layer)
        requestLocationAccess()
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        myLocationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        myLocationManager.requestAlwaysAuthorization()
        myLocationManager.startUpdatingLocation()
        myLocationManager.startUpdatingHeading()
        // ?????????????????????
        let fullSize = UIScreen.main.bounds.size

        let anns = [MKPointAnnotation(),MKPointAnnotation()]
        let url6 = Bundle.main.url(forResource:"test",withExtension: "json")
        
        anns[0].coordinate = CLLocationCoordinate2D(latitude:24.13726,longitude:121.275753)
        anns[0].title = "??????"
        anns[0].subtitle = "??????????????????????????????"
        
        anns[1].coordinate = CLLocationCoordinate2D(latitude: 23.510041, longitude: 120.700458)
        anns[1].title = "?????????"
        anns[1].subtitle = "??????????????????(??????)"
        
 callAPI3()
    
        myMapView = MKMapView(frame: CGRect(x: 0, y: 20, width: fullSize.width, height: fullSize.height - 20))
        callAPI()
        myMapView.showsUserLocation = true
        myMapView.delegate = self
        myMapView.mapType = .standard
        myMapView.isPitchEnabled = true
        
        myMapView.userTrackingMode = .follow//??????:?????????????????????,?????????????????????,???????????????????????????
      
        myMapView.showsUserLocation = true
        myMapView.userTrackingMode = .follow
        
        myMapView.isZoomEnabled = true
      
        self.startRequest()
        
   
        let center = UNUserNotificationCenter.current()
        let locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoringVisits()

        var restaurantNames = ["teaha","CaffeLatte","Espresso","Americano"]
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return restaurantNames.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cellIdentifier = "datacell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for:indexPath)
            
            cell.textLabel?.text = restaurantNames[indexPath.row]
            
            return cell
        }
        weak var routeMap: MKMapView!
        var currentTransportType = MKDirectionsTransportType.automobile
        var peripheralManager : CBPeripheralManager!
        let latDelta = 0.05
        let longDelta = 0.05
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let sourceLocation = CLLocationCoordinate2D(latitude: 25.033493, longitude: 121.564101)
        let destinationLocation = CLLocationCoordinate2D(latitude: 22.817701, longitude: 120.2858)
                // 3.
                let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
                let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
                
                // 4.
                let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
                let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
                
                // 5.
                let sourceAnnotation = MKPointAnnotation()
                sourceAnnotation.title = "??????101"
        
        if let location = sourcePlacemark.location {
                  sourceAnnotation.coordinate = location.coordinate
              }
              
              
              let destinationAnnotation = MKPointAnnotation()
              destinationAnnotation.title = "??????????????????"
              
              if let location = destinationPlacemark.location {
                  destinationAnnotation.coordinate = location.coordinate
              }
        
        self.myMapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
               directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate{
            (response,error)-> Void in
            guard let response = response else {
                            if let error = error {
                                print("Error: \(error)")
                            }
                            
                            return
                        }
            let route = response.routes[0]
            self.myMapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
        }
        let sourceLocation2 = CLLocationCoordinate2D(latitude: 25.033671, longitude: 121.564427)
        let destinationLocation2 = CLLocationCoordinate2D(latitude: 22.42, longitude: 120.21)
        let sourcePlacemark2 = MKPlacemark(coordinate: sourceLocation2, addressDictionary: nil)
        let destinationPlacemark2 = MKPlacemark(coordinate: destinationLocation2, addressDictionary: nil)
        let sourceMapItem2 = MKMapItem(placemark: sourcePlacemark2)
        let destinationMapItem2 = MKMapItem(placemark: destinationPlacemark2)
        let sourceAnnotation2 = MKPointAnnotation()
        sourceAnnotation2.title = "Taipei City"

if let location = sourcePlacemark2.location {
          sourceAnnotation2.coordinate = location.coordinate
      }
      
      
      let destinationAnnotation2 = MKPointAnnotation()
      destinationAnnotation2.title = "Empire State Building"
      
      if let location = destinationPlacemark2.location {
          destinationAnnotation2.coordinate = location.coordinate
      }

self.myMapView.showAnnotations([sourceAnnotation2,destinationAnnotation2], animated: true )
let directionRequest2 = MKDirections.Request()
directionRequest2.source = sourceMapItem2
directionRequest2.destination = destinationMapItem2
       directionRequest2.transportType = .automobile

let directions2 = MKDirections(request: directionRequest2)

directions2.calculate{
    (response2,error)-> Void in
    guard let response2 = response2 else {
                    if let error = error {
                        print("Error: \(error)")
                    }
                    
                    return
                }
    let route2 = response2.routes[0]
    self.myMapView.addOverlay((route2.polyline), level: MKOverlayLevel.aboveRoads)

    
}
        ///
        location = CLLocationManager();
          location.delegate = self;
          //??????????????????????????????APP????????????
          location.requestWhenInUseAuthorization();
          //??????????????????????????????
          location.startUpdatingLocation();
          location.distanceFilter = CLLocationDistance(10); //????????????10???????????????????????????
        getUsersList()
        mm.startDeviceMotionUpdates(to:OperationQueue()){(motion,error) in
            if let motion = motion{
                
                let attitude = motion.attitude
                
                print("\(attitude.pitch),\(attitude.roll),\(attitude.yaw)")
                let rotation = motion.rotationRate
                
                print("\(rotation.x),\(rotation.y),\(rotation.z)")
                
                let gravity = motion.gravity
                print("\(gravity.x),\(gravity.y),\(gravity.z)")
                
                let acceleration = motion.userAcceleration
                print("\(acceleration.x),\(acceleration.y),\(acceleration.z)")
                
                let magnetic = motion.magneticField
                print("\(magnetic.field.x),\(magnetic.field.y),\(magnetic.field.z)")
                }
        }
      let typestoRead = Set([
                  HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.mindfulSession)!,
                  ])
        
              let typestoShare = Set([
                  HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.mindfulSession)!
                  ])
        
              let healthStore = HKHealthStore()
        
        
        
        if HKHealthStore.isHealthDataAvailable(){
            let shareTypes = self.dataTypeToShare()
            let readTypes = self.dataTypeToRead()
            
            healthStore.requestAuthorization(toShare: shareTypes, read: readTypes) { (success, error) -> Void in
                  if(success){
                          // Read or write the HealthKit data
                    print("????????????")
                    self.setHeartRate(72)
                    sleep(60)
                    
                    
                    self.setHeartRate(80)
                    sleep(60)
                    
                    self.setHeartRate(76)
                    sleep(60)
                    
                    self.getHeartRate(completion:{(results) in
                        if let results = results{
                            let unit = HKUnit.count().unitDivided(by: .minute())
                            var value:Double
                            for p in results as! [HKQuantitySample]{
                                value = p.quantity.doubleValue(for: unit)
                                print("????????????\(value)")
                            }
                        }
                    })
                  }
                  else{
                          // Authorization failure
                    print("????????????")
                  }
              }
            
        }

     
        let center2:CLLocation = CLLocation(latitude: 25.05, longitude: 121.515)
        let currentRegion = MKCoordinateRegion(center: center2.coordinate, span: currentLocationSpan)
        myMapView.setRegion(currentRegion, animated: true)
        
        var annView = myMapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKPinAnnotationView
        self.view.addSubview(myMapView)
        
        var restaurants:[Restaurant] = [Restaurant(name:"Cafe Deadend",type:"Coffe & Tea shop",location:"Hong Kong",image:"Americano.jpg", isVisited: true)]
        var objectAnnotation = MKPointAnnotation()
        var objectAnnotation1 = MKPointAnnotation()
        objectAnnotation.coordinate = CLLocation(latitude: 25.036798, longitude: 121.499962).coordinate
        objectAnnotation.title = "????????????"
        objectAnnotation.subtitle = "???????????????????????????????????????????????????????????????????????????"
        myMapView.addAnnotation(objectAnnotation)
        var location = CLLocation(latitude:22.999034,longitude:120.212868)
        var region = MKCoordinateRegion(center:location.coordinate,latitudinalMeters:300,longitudinalMeters: 300)
      
     
        let annotation = MyAnnotation(coordinate: location.coordinate)
        annotation.title = "???????????????"
        annotation.subtitle = "????????????"
        
        myMapView.addAnnotation(annotation)
        // ??????????????????????????? (??????????????????????????????)
        objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = CLLocation(latitude: 25.063059, longitude: 121.533838).coordinate
        objectAnnotation.title = "?????????"
        objectAnnotation.subtitle = "???????????????????????????????????????????????????"
        myMapView.addAnnotation(objectAnnotation)
        
        objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = CLLocation(latitude: 24.441304, longitude: 120.74123).coordinate
        objectAnnotation.title = "????????????"
        objectAnnotation.subtitle = "??????|35750???????????????????????????166???"
        myMapView.addAnnotation(objectAnnotation)
        
        objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = CLLocation(latitude: 23.760679, longitude: 120.365768).coordinate
        objectAnnotation.title = "???????????????"
        objectAnnotation.subtitle = "??????|637???????????????????????????182???32???"
        myMapView.bounds = CGRect(x:400,y:400,width: 400,height: 600)
        myMapView.addAnnotation(objectAnnotation)
        
        objectAnnotation1 = MKPointAnnotation()
        objectAnnotation1.coordinate = CLLocation(latitude: 37.3852, longitude: -122.1141).coordinate
        objectAnnotation1.title = "??????????????????"
        objectAnnotation1.subtitle = ""
        myMapView.addAnnotation(objectAnnotation1)
        
        if(objectAnnotation.title)!=="????????????"{

            annView!.pinTintColor = UIColor.green

        }
        lm.delegate = self
        lm.startUpdatingHeading()
        
       var points = [CLLocationCoordinate2D]()
        points.append(CLLocationCoordinate2D(latitude: 24.2013, longitude: 120.5810))
        points.append(CLLocationCoordinate2D(latitude: 24.2044, longitude: 120.6559))
        points.append(CLLocationCoordinate2D(latitude: 24.1380, longitude: 120.6401))
        points.append(CLLocationCoordinate2D(latitude: 24.1424, longitude: 120.5783))
        let polygon = MKPolygon(coordinates: &points, count: points.count)
        myMapView.addOverlay(polygon)
        myMapView.setCenter(points[0],animated:false)
 
        
        myMapView.setCenter(points[0], animated: false)
        
       //23.7606595,120.3657646
        var points2 = [CLLocationCoordinate2D]()
        points2.append(CLLocationCoordinate2D(latitude:23.76 , longitude:120.3657646 ))
        points2.append(CLLocationCoordinate2D(latitude: 23.7606595, longitude: 120.4))
        points2.append(CLLocationCoordinate2D(latitude: 23.755, longitude: 120.43))
        points2.append(CLLocationCoordinate2D(latitude: 23.77, longitude: 120.3))
         let polygon2 = MKPolygon(coordinates: &points2, count: points2.count)
         myMapView.addOverlay(polygon2)
         myMapView.setCenter(points2[0],animated:false)
         
         
         myMapView.setCenter(points2[1], animated: false)
        
        var points3 = [CLLocationCoordinate2D]()
        points3.append(CLLocationCoordinate2D(latitude:23.76 , longitude:120.3657646 ))
        points3.append(CLLocationCoordinate2D(latitude: 23.7606595, longitude: 120.4))
        myMapView.addOverlay(polygon2)
        myMapView.setCenter(points2[0],animated:false)
        
        
        myMapView.showsCompass = true
        myMapView.showsScale = true
        myMapView.showsTraffic = true
        myMapView.showsUserLocation = true
        
       
        let request2 = MKLocalSearch.Request()
        
        request2.naturalLanguageQuery = "??????"
        
        request2.region = myMapView.region
        
        let search = MKLocalSearch(request:request2)
        
        search.start{(response,error) in
            guard error == nil else{
                return
            }
            guard response != nil else{
                return
            }
            for item in (response?.mapItems)!{
                self.myMapView.addAnnotation(item.placemark)
            }
            
        }
    
        print("present location : (newLocation.coordinate.latitude), (newLocation.coordinate.longitude)")
        
        let url4:NSURL! = NSURL(string: "http://www.hangge.com")
        //??????????????????
        let urlRequest:NSURLRequest = NSURLRequest(url: url4! as URL)
        //????????????
        var response:URLResponse?
                 
        do{
              //????????????
            let data:NSData? = try NSURLConnection.sendSynchronousRequest(urlRequest as URLRequest,
                                                                          returning: &response) as NSData
            let str = NSString(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
              print(str)
                     
        }catch let error as NSError{
              //??????????????????
              print(error.code)
              print(error.description)
        }
  
      checkLocationService()
        do{
            let data = try Data(contentsOf:url6!)
            
            let jsonObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments)as! [[String:Any]]
            
            for p in jsonObj{
                print("????????? \(p["??????"]!)")
                print("????????? \(p["??????"]!)")
                if let tels = p["??????"] as?[String:String]{
                    print("????????? \(tels["??????"]!)")
                    print("????????? \(tels["??????"]!)")
                }
                print("------------------------------")
                
            }
        }
        catch{
            print(error.localizedDescription)
        }
        
     //????????????
        let flycow = CLLocationCoordinate2D(latitude:24.441304,longitude: 120.74123)
        let yuansin = CLLocationCoordinate2D(latitude:24.429672,longitude:120.738737)
        let chien = CLLocationCoordinate2D(latitude:23.45384,longitude:120.21568)
        
        let pA = MKPlacemark(coordinate: flycow, addressDictionary: nil)
        let pB = MKPlacemark(coordinate: yuansin, addressDictionary: nil)
        let pC = MKPlacemark(coordinate: chien, addressDictionary: nil)
        
        let miA = MKMapItem(placemark: pA)
        miA.name = "????????????"
        let miB = MKMapItem(placemark: pB)
        miB.name = "??????????????????"
        let miC = MKMapItem(placemark: pC)
        miC.name = "?????????????????????"
        
        let routes = [miA,miC]
      
        
        
        let options = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
        getDirection()
         
        func getTemperatureAndDate(sample: HKSample) -> (Date, Double) {
                let quantitySample = sample as! HKQuantitySample
                let date = sample.startDate
                let temperature = quantitySample.quantity.doubleValue(for: .degreeCelsius())
                return (date, temperature)
            }
                
            // MARK: - Table view data source
            
        func numberOfSections(in tableView: UITableView) -> Int {
                return 1
            }
          // MARK: - Tool Methods - Alert
            func showAlert(title: String, message: String, buttonTitle: String) {
                let alert = UIAlertController(title: title,
                                              message: message,
                                              preferredStyle: .alert)
                let okAction = UIAlertAction(title: buttonTitle, style: .default, handler: { (action) in
                })
                alert.addAction(okAction)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
        if HKHealthStore.isHealthDataAvailable(){
            let shareTypes = self.dataTypeToShare()
            let readTypes = self.dataTypeToRead()
            
            health.requestAuthorization(toShare: shareTypes, read: readTypes, completion: {(success,error) in
                if success{
                    print("????????????")
                    
                    self.setHeartRate(72)
                    sleep(60)
                    
                    self.setHeartRate(85)
                    sleep(60)
                    
                    self.setHeartRate(76)
                    sleep(60)
                    
                  self.getHeartRate(completion:{(results) in
                        if let results = results{
                            let unit = HKUnit.count().unitDivided(by: .minute())
                            var value:Double
                            
                            for p in results as! [HKQuantitySample]{
                                value = p.quantity.doubleValue(for:unit)
                                print("????????????\(value)")
                                
                            }
                        }
                    })
               }else{
                    print("???????????????")
                }
            })
        }
        
        
        let urlString3 = URL(string: "api.openweathermap.org/data/2.5/forecast?id=524901&APPID=1111111111")  // Making the URL
        if let url = urlString3 {
           let task = URLSession.shared.dataTask(with: url) {
              (data, response, error) in // Creating the URL Session.
              if error != nil {
                 // Checking if error exist.
                print(error!)
                
              } else {
                 if let usableData = data {
                    // Checking if data exist.
                    print(usableData)
                    // printing Data.
                 }
              }
           }
            task.resume()
        }
        
        
        let webservice = Webservice()
        webservice.load(resource: Acronym.all) { result in
            debugPrint(result)
        }
  
        MKMapItem.openMaps(with:routes,launchOptions: options)
        
       
        peripheralManager = CBPeripheralManager(delegate:self,queue:queue)
        let urlString4 = URL(string: "api.openweathermap.org/data/2.5/forecast?id=524901&APPID=1111111111")  // Making the URL
        if let url = urlString4 {
           let task = URLSession.shared.dataTask(with: url) {
              (data, response, error) in // Creating the URL Session.
              if error != nil {
                 // Checking if error exist.
                 print(error)
              } else {
                 if let usableData = data {
                    // Checking if data exist.
                    print(usableData)
                    // printing Data.
                 }
              }
           }
            task.resume()
        }
        
        let path = Bundle.main.path(forResource: "index", ofType: ".html")
}
     @IBAction func signUpAction(_ sender: Any) {
        let signUpAlert = UIAlertController(title: "??????", message: "??????", preferredStyle: .alert)
                let saveAction = UIAlertAction(title: "??????", style: .default) { (action) in
                    let emailSignUpTextField = signUpAlert.textFields![0]
                    let passwordSignUpTextField = signUpAlert.textFields![1]
                
                }
                
                let cancelAction = UIAlertAction(title: "??????", style: .cancel, handler: nil)
                
                signUpAlert.addTextField { (emailSignUpTextField) in
                    emailSignUpTextField.placeholder = "?????????Email"
                }
                signUpAlert.addTextField { (passwordSignUpTextField) in
                    passwordSignUpTextField.placeholder = "???????????????"
                    passwordSignUpTextField.isSecureTextEntry = true
                }
                
                signUpAlert.addAction(saveAction)
                signUpAlert.addAction(cancelAction)
                
                present(signUpAlert, animated: true, completion: nil)
    }
    
       
   
    private func callAPI3() {
        // ??????????????? Request tab info ???????????????????????????
        let url = URL(string: "https://dataservice.accuweather.com/currentconditions/v1/315078?apikey=\(apiKey2)&language=zh-Tw")!
        
        // ????????????????????? URLRequest
        var request = URLRequest(url: url)
        
        // ???????????????????????? GET
        request.httpMethod = "GET"
        
        // ?????? URLSession
        let session = URLSession.shared
        
        // ?????? sesstion + request ???????????? task
        // ?????????????????????????????????????????????????????????
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            // ???????????????????????????????????? code
            
            // ?????? data ??? optional????????????????????????????????? data ?????????
            // ?????????????????????????????? return???????????????????????????
            guard let data = data else {
                return
            }
            
            do {
                // ?????? JSONDecoder ????????? data
                let weatherModel = try JSONDecoder().decode([WeatherModel].self, from: data)
                print(weatherModel)
                
                // ?????? UI ?????????????????????????????????????????????????????? code ?????? DispatchQueue.main.async ??????????????????
                DispatchQueue.main.async {
                   
                    // ??????????????? Array<WeatherModel> ????????? data????????????????????????????????????????????????????????????
                    let tmp = weatherModel.first?.temperature.metric.value ?? -1
              
                }
                
            } catch {
                print(error)
            }
            
        })
        
        // ?????? task
        dataTask.resume()
}
    private func callAPI2() {
       // ??????????????? Request tab info ???????????????????????????
       let url = URL(string: "https://dataservice.accuweather.com/currentconditions/v1/315078?apikey=\(apiKey2)&language=zh-Tw")!
     
       // ????????????????????? URLRequest
       var request = URLRequest(url: url)
     
       // ???????????????????????? GET
       request.httpMethod = "GET"
     
       // ?????? URLSession
       let session = URLSession.shared
     
       // ?????? sesstion + request ???????????? task
       // ?????????????????????????????????????????????????????????
       let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
           // ???????????????????????????????????? code
     
           // ?????? data ??? optional????????????????????????????????? data ?????????
           // ?????????????????????????????? return???????????????????????????
           guard let data = data else {
               return
           }
     
           do {
               // ?????? JSONDecoder ????????? data
            let weatherModel = try JSONDecoder().decode([WeatherModel].self, from: data)
               print(weatherModel)
          
           } catch {
               print(error)
           }
     
       })
     
       // ?????? task
       dataTask.resume()
    }
    /*
         nameSpace:????????????
         urlStr:????????????
         method:?????????
         */
        func webServiceConnect( nameSpace:String, urlStr:String, method:String){
            
            //soap?????????
            let soapMsg:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"+"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"+"<soap:Body>\n"+"<"+method+" xmlns=\""+nameSpace+"\">\n"+"<byProvinceName>"+"??????"+"</byProvinceName>\n"+"</"+method+">\n"+"</soap:Body>\n"+"</soap:Envelope>\n"
            
            let soapMsg2:NSString = soapMsg as NSString
            //??????????????????url
            let url:URL = URL.init(string:urlStr)!
            //?????????soap?????????????????????????????????
            let msgLength:NSString = NSString.init(format: "%i", soapMsg2.length)
            //??????request???????????????????????????????????????
            var request:URLRequest = NSMutableURLRequest.init() as URLRequest
            //????????????????????????????????????
            request.timeoutInterval = 10
            request.cachePolicy = .reloadIgnoringLocalCacheData
            request.url = url
            request.httpMethod = "POST"
            //??????????????????
            request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.addValue(msgLength as String, forHTTPHeaderField: "Content-Length")
            request.httpBody = soapMsg.data(using: String.Encoding.utf8)
            //soapAction?????????
            let soapActionStr:String = nameSpace + method
            request.addValue(soapActionStr, forHTTPHeaderField: "SOAPAction")
            
            //????????????session?????????????????????
            let session:URLSession = URLSession.shared
            //????????????
            let task:URLSessionDataTask = session.dataTask(with: request as URLRequest , completionHandler: {( data, respond, error) -> Void in
                
                if (error != nil){
                    
                    print("error is coming")
                }else{
                    //????????????
                    let result:NSString = NSString.init(data: data!, encoding: String.Encoding.utf8.rawValue)!
                    print("result=\(result),\n adress=\(String(describing: request.url))")
                }
            })
            
            //????????????
            task.resume()
        }
    @IBAction func login(sender: UIButton) {
            if account.text == myAccount && password.text == myPassword {
                self.info.text = "??????"
                 
                //??????????????????
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapsActivity")
                 
                self.present(viewController, animated: false, completion: nil)
                // ?????? self.dismissViewControllerAnimated(true, completion: nil)
                 
            }else{
                
                self.info.text = "????????????"
            }
        }
    func peripheralManager(_ peripheral: CBPeripheralManager) {
        guard peripheral.state == .poweredOn else{
            print(peripheral.state.rawValue)
            return
        }
        var service:CBMutableService
        var characteristic:CBMutableCharacteristic
        var charArray = [CBCharacteristic]()
        var charDictionary = [String: CBMutableCharacteristic]()
        service = CBMutableService(type: CBUUID(string:"A001_SERVICE"), primary: true)
        characteristic = CBMutableCharacteristic(type: CBUUID(string: "A001_SERVICES"), properties: [.notifyEncryptionRequired,.write,.read], value: nil, permissions: [.writeEncryptionRequired,.readEncryptionRequired])
        charArray.append(characteristic)
        service.characteristics = charArray
        
        periperalManager.add(service)
        
        
    }
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            print("???????????????")
            self.view.showToast(text: "???????????????\n\n")
            let string = "Detected device shacking"
            let utterance = AVSpeechUtterance(string: string)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

            let synth = AVSpeechSynthesizer()
            synth.speak(utterance)
            
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail"{
            var destinationController = segue.destination as! RestaurantDetailViewController
        
        }
    }
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        print("?????????????????????")
    }
    
    func sendData(_ data:Data,uuidString:String) throws{
        var charDictionary = [String: CBMutableCharacteristic]()
        guard let characteristic = charDictionary[uuidString] else{
            throw SendDataError.CharacteristicNotFound
        }
        periperalManager.updateValue(data, for: characteristic, onSubscribedCentrals: nil)
    }
    
    func getItems(){
        let serviceUrl = ""
        
        let url = URL(string: serviceUrl)
        
        if let url = url{
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url,completionHandler: {(data,response,error) in
                
                if error == nil{
                    self.parseJson(data!)
                }
            })
            task.resume()
        }
    }
    func parseJson(_ data:Data){
        var locArray = [Place]()
        do{
     let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            for jsonResult in jsonArray{
                let jsonDict = jsonResult as! [String:String]
                let locName = jsonResult as![String:String]
                let loc = Place()
                
                locArray.append(loc)
                
            }
        }
        catch{
            print("There was an error")
        }
        
        
    }
    func peripheralManager(_ peripheral: CBPeripheralManager, central:CBCentral,didSubscribeTo characteristic:CBCharacteristic) {
        if peripheral.isAdvertising{
            peripheral.stopAdvertising()
            print("????????????")
        }
        if characteristic.uuid.uuidString == C001_CHARACTZERISZTIC{
            print("?????????001")
            do{
                let data = "hello central ".data(using: .utf8)
                try sendData(data!, uuidString: "C001_CHARACTERISTIC")
            }catch{
                print(error)
            }
        }
        
    }
    @objc func proximityStateChanged(_ sender:NSNotification){
        let device = UIDevice.current
        if device.proximityState{
            print("????????????")
     
        }else{
            print("????????????")
        }
    }
    //????????????
    func peripheralManager(_ peripheral: CBPeripheralManager,central:CBCentral,didUnsubscribeFrom characteristic:CBCharacteristic) {
        if characteristic.uuid.uuidString == C001_CHARACTZERISZTIC{
            print("???????????????001")
        }
    }
    //Central ???????????????Peripheral
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        guard let at = requests.first else{
            return
        }
        guard let data = at.value else{
            return
        }
        
        if at.characteristic.uuid.uuidString == "C001_CHARACTERISTIC"{
            peripheral.respond(to:at,withResult: .success)
            let string = ">" + String(data:data,encoding:.utf8)!
            print(string)
        }
        
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        request.value = nil
        
        if request.characteristic.uuid.uuidString == "C001_CHARACRISTIC"{
        let data = "WHAT do you want?".data(using: .utf8)
        request.value = data}
    peripheral.respond(to: request, withResult: .success)
    }
   
    //???????????????ebService
    func startRequest(){
        var srtURL = "http://www.51work6.com"
        var post = String(format:"https://mail.google.com/mail/u/0/#sent","<????????????>","JSON","query")
        var postData:NSData;
        
        let url = NSURL(string: srtURL)!
}
    
    
    func statisticsQuery(){
        let unit = HKUnit.count().unitDivided(by: .minute())
        let type = HKQuantityType.quantityType(forIdentifier: .heartRate)
        
        let min = HKStatisticsQuery(
            quantityType:type!,
            quantitySamplePredicate:nil,
            options:.discreteMin
        ){
            (query,result,error) in
            if error == nil{
                let value = result?.minimumQuantity()?.doubleValue(for: unit)
                print("?????????????????????\(value!)")
                
            }
        }
        health.execute(min)
    }
    func webView(_ webView:WKWebView,runJavaScriptAlertPanelWithMessage message:String,initiatedByFrame:WKFrameInfo,completionHandler:@escaping()->Void){
        let alert = UIAlertController(
            title:"???hat you selected are",
            message:message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title:"??????",
            style:.default,
            handler:nil
        )
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
        completionHandler()
    }
func createDirectionRequest(from coordinate:CLLocationCoordinate2D)->MKDirections.Request{
        let startingLocation = MKPlacemark(coordinate: coordinate)
        let destinationLocation = MKPlacemark(coordinate: coordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startingLocation)
        request.destination = MKMapItem(placemark: destinationLocation)
        request.transportType = .transit
        request.requestsAlternateRoutes = true
        return request
    }
    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
            
        case .denied, .restricted:
            print("location access denied")
            
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func dataTypeToShare()->Set<HKSampleType>{
        var set = Set<HKSampleType>()
        
        set.insert(HKQuantityType.quantityType(forIdentifier: .heartRate)!)
        
        return set
    }
    func addAnnotations() {
        myMapView?.delegate = self
}
 
    func getHeartRate(completion: @escaping (_ _results:[HKSample]?)->Void){
        let type = HKQuantityType.quantityType(forIdentifier: .heartRate)
        let sort = NSSortDescriptor(key:HKSampleSortIdentifierStartDate,ascending: false)
        
        let query = HKSampleQuery(
            sampleType:type!,
            predicate: nil,
            limit:HKObjectQueryNoLimit,
            sortDescriptors: [sort])
            {
                (query,results,error) in
            if error == nil{
                completion(results)
            }
            }
        health.execute(query)
        
    }
    func getUsersList() {
        guard let url = URL(string: "https://reqres.in/api/users/3") else { return }
        rest.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
        }
    }
    func tableView(_tableView:UITableView,didSelectRowAt indexPath:IndexPath){
        let optionMenu = UIAlertController(title: nil, message: "What do you eant to do", preferredStyle: .actionSheet)
        present(optionMenu,animated:true,completion: nil)
        let callActionHandler = {(action:UIAlertAction!)->Void in
            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry,the call feature is not available yet", preferredStyle: .alert)
            self.present(alertMessage, animated: true, completion: nil)
            
        }
        //?????????
        let callAction = UIAlertAction(title:"call"+"123-000-\(indexPath.row)",style:.default,handler: callActionHandler)
        optionMenu.addAction(callAction)
        
        
        //????????????
        let checkInAction = UIAlertAction(title:"Check in",style:.default,handler:{
            (action:UIAlertAction!) ->Void in
            
            let cell = _tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            
            
        
        })
        optionMenu.addAction(checkInAction)
     
        let favoriteAction = UIAlertAction(title: "Mark as favorite", style: .default, handler: {(action:UIAlertAction!)->Void in
            
            let cell = _tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            
            cell?.tintColor = .systemYellow
            self.restaurantIsFavorites[indexPath.row] = true
            if self.restaurantIsFavorites[indexPath.row]{
                cell?.accessoryType = .checkmark
            }else{
                cell?.accessoryType = .none
            }
        
        })
        optionMenu.addAction(favoriteAction)
        
        present(optionMenu, animated: true, completion: nil)
        
        _tableView.deselectRow(at: indexPath, animated: false)
       
    }
    
    
    func getJSONData(completed: @escaping () -> ()) {
        if let filepath = Bundle.main.path(forResource: "weather", ofType: "json") {
            if let data = try? String(contentsOf: URL(fileURLWithPath: filepath)) {
              

                // I must assign json to weatherData here
                DispatchQueue.main.async {
                    completed()
                }
            }
        } else {
            print("file not found")
        }
    }

    func getDirection(){
        guard let location = locationManager.location?.coordinate else{
            return
        }
        let request = createDirectionRequest(from: location)
        let directions = MKDirections(request:request)
        
        let callActionHandler = {
            (action:UIAlertAction!)->Void in
            let alertMessage = UIAlertController(title:"Service Unavalable",message:"sorry,the call feature is not avalable yet",preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title:"ok",style:.default,handler:nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
 
    }
  func prepareForSeque(seque:UIStoryboardSegue,sender:AnyObject?){
        if seque.identifier == "showSteps"{
            let destinationController = seque.destination as! UINavigationController
            let routeTableViewController = destinationController.childViewControllerForPointerLock?.isFirstResponder as! ViewController
            if let steps = currentRoute?.steps as? [MKRoute.Step]{
                routeTableViewController.routeSteps = steps
            }
        }
    }
    func setHeartRate(_ heartRate:Double){
        let unit = HKUnit.count().unitDivided(by: HKUnit.minute())
        let type = HKQuantityType.quantityType(forIdentifier: .heartRate)
        
        let quantity = HKQuantity(unit:unit,doubleValue:heartRate)
        let sample = HKQuantitySample(
            type:type!,
            quantity:quantity,
            start: Date(),
            end:Date()
        )
        
        health.save(sample){(success,error) in
            if success {
                print("??????????????????")
                
            }else{
                print("????????????????????????rror:\(error!)")
                
            }
        }
        
    }

   
    func dataTypeToRead()->Set<HKObjectType>{
        var set = Set<HKSampleType>()
        set.insert(HKQuantityType.quantityType(forIdentifier: .heartRate)!)
        return set
    }
   
    let healthKitStore: HKHealthStore = HKHealthStore()
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000)
        }
        
    }
    
    func authorizeHealthKit(completion: ((_ success: Bool, _ error: NSError?) -> Void)!) {

           // State the health data type(s) we want to read from HealthKit.
        let healthDataToRead = Set(arrayLiteral: HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!)

           // State the health data type(s) we want to write from HealthKit.
        let healthDataToWrite = Set(arrayLiteral: HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!)

           // Just in case OneHourWalker makes its way to an iPad...
           if !HKHealthStore.isHealthDataAvailable() {
               print("Can't access HealthKit.")
           }

           // Request authorization to read and/or write the specific data.
        healthKitStore.requestAuthorization(toShare: healthDataToWrite, read: healthDataToRead) { (success, error) -> Void in
               if( completion != nil ) {
                completion(success, error as NSError?)
               }
           }
       }
   
    private func mapView(mapView:MKMapView,viewForAnnotation annotation:MKAnnotation)->MKAnnotationView?{
        let identifier = "MyPin"
        
        let annotationView:MKPinAnnotationView?=mapView.dequeueReusableAnnotationView(withIdentifier: identifier)as?
        MKPinAnnotationView
        
        let leftIconView = UIImageView(frame:CGRect(x: 0,y: 0,width: 53,height: 53))
          leftIconView.image = UIImage(named:restaurant.image)
          annotationView?.leftCalloutAccessoryView = leftIconView
        
        
          return annotationView
    }
    func fetchLatestLoans(){
        guard let loanUrl = URL(string:Self.kivaLoanURL) else{
            return
        }
        
        let request = URLRequest(url: loanUrl)
        
        let task = URLSession.shared.dataTask(with: request,completionHandler: {(data,response,error)->Void in
            
            if let error = error{
                print(error)
                return
            }
            
            if let data = data{
                DispatchQueue.main.async {
                    self.loans = self.parseJsonData(data:data)
                }
            }
            
        })
        task.resume()
    }
    @Published var loans:[Loan] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var location = "Paris,France"
        // ???????????? ??????????????????????????????????????????
        if CLLocationManager.authorizationStatus() == .notDetermined {
            // ????????????????????????
            myLocationManager.requestWhenInUseAuthorization()

            // ????????????????????????
            myLocationManager.startUpdatingLocation()
            
        }
        // ?????????????????????????????????????????????
        else if CLLocationManager.authorizationStatus() == .denied {
            // ????????????[??????]???????????????
            let alertController = UIAlertController( title: "?????????????????????", message: "??????????????????????????? ?????? > ????????? > ???????????? ??????", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "??????", style: .default, handler:nil)
            alertController.addAction(okAction)
            self.present( alertController, animated: true, completion: nil)
        }
        // ?????????????????????????????????????????????
        else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            // ????????????????????????
            myLocationManager.startUpdatingLocation()
        }
 }
     
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // ????????????????????????
        myLocationManager.stopUpdatingLocation()
    }
    func parseJsonData(data:Data)->[Loan]{
        let decoder = JSONDecoder()
        
        do{
            let loanStore = try!decoder.decode(LoanStore.self, from: data)
            self.loans = loanStore.loans
        }catch{
            print(error)
        }
        return loans
    }
    func setUpLocationManager(){
        myLocationManager.delegate = self
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    func setGoodIdeaStudioPoint(){
      
    }
   
    func checkLocationServices()
    {
        if CLLocationManager.locationServicesEnabled(){
            setUpLocationManager()
            checkLocationAuthorization()
        }else{}
    }
    private func addAnotation(){
        let appleParkAnnotation = MKPointAnnotation()
        appleParkAnnotation.title = "Apple Park"
        appleParkAnnotation.coordinate = CLLocationCoordinate2D(latitude:37.332072300,longitude:-122.11130300)
        let ortegapartAnnotation = MKPointAnnotation()
        ortegapartAnnotation.title = "Ortega Park"
        ortegapartAnnotation.coordinate = CLLocationCoordinate2D(latitude:37.362226,longitude:-122.023617)
        
        
        destination.append(appleParkAnnotation)
        destination.append(ortegapartAnnotation)
        
        myMapView.addAnnotation(appleParkAnnotation)
        myMapView.addAnnotation(ortegapartAnnotation)
 }
    
    func showRoute(_ response: MKDirections.Response) {
        
        for route in response.routes {
            
            myMapView.addOverlay(route.polyline,
                         level: MKOverlayLevel.aboveRoads)
            
            for step in route.steps {
                print(step.instructions)
            }
        }
        
        if let coordinate = userLocation?.coordinate {
            _ =
                MKCoordinateRegion(center: coordinate,
                                   latitudinalMeters: 2000, longitudinalMeters: 2000)
         
        }
    }

    
    func mapView(_ mapView: MKMapView, rendererFor
                    overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)

        renderer.strokeColor = UIColor.orange
        renderer.lineWidth = 5.0
        return renderer
    }
    public func constructRoute(userLocation: CLLocationCoordinate2D){
        let directionsRequest = MKDirections.Request()
        directionsRequest.source = MKMapItem(placemark:MKPlacemark(coordinate: userLocation))
        directionsRequest.destination = MKMapItem(placemark:MKPlacemark(coordinate:destination[0].coordinate))
        directionsRequest.transportType = .automobile
        
        let directions = MKDirections(request:directionsRequest)
        
        directions.calculate{[weak self](directionsResponse,error)in
            guard let strongSelf = self else{return}
            
            if let error = error{
                print(error.localizedDescription)
            }else if let response = directionsResponse,response.routes.count>0{
                strongSelf.currentRoute =  response.routes[0]
                let route = directionsResponse!.routes[0] as! MKRoute
                
                strongSelf.myMapView.removeOverlays((self?.myMapView.overlays)!)
                strongSelf.myMapView.addOverlay(route.polyline,level:MKOverlayLevel.aboveRoads)
                strongSelf.currentRoute = route
                
                strongSelf.myMapView.addOverlay(response.routes[0].polyline)
                strongSelf.myMapView.setVisibleMapRect(response.routes[0].polyline.boundingMapRect, animated: true)
                let rect = route.polyline.boundingMapRect
                self?.myMapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
            
        }
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            myMapView.showsUserLocation = true
            break
        case .notDetermined:
            myLocationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways:
            break
        
        @unknown default:
            break
        }
    }
    func getCenterLocation() -> CLLocation{
        let latitude = myMapView.centerCoordinate.latitude
        let longitude = myMapView.centerCoordinate.longitude
        return CLLocation(latitude:latitude,longitude:longitude)
        
    }
    
    // MARK: MKMapViewDelegate Methods
    func checkLocationService(){
        if CLLocationManager.locationServicesEnabled(){
            setUpLocationManager()
        }
    }
    func mapView(_mapView:MKMapView,rendererFor overlay:MKOverlay)->MKOverlayRenderer{
        let renderer = MKPolygonRenderer(overlay:overlay)
        renderer.strokeColor = UIColor.systemBlue
        renderer.lineWidth = 3.0
        if overlay is MKPolygon{
            renderer.fillColor = UIColor.red.withAlphaComponent(0.2)
            renderer.strokeColor = UIColor.red.withAlphaComponent(0.7)
            
            renderer.lineWidth = 3
        }
        return renderer
    }
   func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.orange
            renderer.lineWidth = 4.0
        
            return renderer
        }
    
    //????????????????????????
   
   
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        // ????????????????????????
        var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        if(annotation.title)! == "?????????"{
            annotationView!.pinTintColor = UIColor.blue
            
            
        }
        if(annotation.title)! == "????????????"{
            annotationView!.pinTintColor = UIColor.blue
        }
        if(annotation.title)! == "???????????????"{
            annotationView!.pinTintColor = UIColor.blue
        }
        if(annotation.title)! == "????????????"{
            annotationView!.pinTintColor = UIColor.blue
        }
        if(annotation.title)! == "???????????????"{
            annotationView!.pinTintColor = UIColor.blue
            
        }
        let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 33, height: 33))
        leftIconView.image = UIImage(named: "image1")
        annotationView?.leftCalloutAccessoryView = leftIconView
        let button = UIButton(type: .detailDisclosure) as UIButton

            annotationView?.rightCalloutAccessoryView = button
        
        return annotationView
    }
    @IBAction func onClick(_sender:UIButton,forEvent event:UIButton){
        if _sender === UIButton(){
           print("on button touch")
        }
    }
    
    private func mapView(mapView: MKMapView!, viewForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
           if (overlay is MKPolyline) {
               let pr = MKPolylineRenderer(overlay: overlay)
               pr.strokeColor = UIColor.blue.withAlphaComponent(0.5)
               pr.lineWidth = 4
               return pr
           }
           return nil
       }
  
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool,didUpdateLocations locations: [CLLocation]!) {
        print("??????????????????")
    }
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        print("?????????????????????")
   
    }
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.location!.coordinate
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    
        print("????????????????????????")
        let route = currentRoute?.distance
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineMyCurrentLocation()
        
    }
    func determineMyCurrentLocation(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager:CLLocationManager,didUpdateLocations locations:[CLLocation]){
        let userLocation:CLLocation = locations[0] as CLLocation
        print("user latitude = \(userLocation.coordinate.latitude)")
               print("user longitude = \(userLocation.coordinate.longitude)")
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
        {
            print("Error \(error)")
        }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    
     
        print("???????????????")
        let string = "Select a pin"
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
       
        myUtterance = AVSpeechUtterance(string: "Hello World")
                myUtterance.rate = 0.3
        synth.speak(myUtterance)
        
    }
    var shopName:[String] = []
    var shopCity:[String] = []
    var newLocation : CLLocation!
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
 
        
       
        print("?????????????????????")
    }
    
    @IBAction func showDirection(_ sender: AnyObject) {
        var currentTransportType = MKDirectionsTransportType.automobile
        if segmentedControl.selectedSegmentIndex == 0{
            currentTransportType = MKDirectionsTransportType.automobile
        }else{
            currentTransportType = MKDirectionsTransportType.walking
        }
        segmentedControl.isHidden = false
        let directionRequest = MKDirections.Request()
        
        }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation],newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
    //locations??????????????????CLLocation???????????????,????????????????????????last,?????????????????????.
           print("????????????")
        
        
    }
  
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
    print("??????????????? -> \\(region.identifier)")
    }
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
    print("??????????????? -> \\(region.identifier)")
    }
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
    switch state {
    case .inside:
    print("?????????????????? -> \\(region.identifier)")
    case .outside:
    print("?????????????????? -> \\(region.identifier)")
    case .unknown:
    print("???????????????????????????")
       }
    }
    func mapView(_mapView:MKMapView,ViewFor annotation:MKAnnotation)->MKAnnotationView?{
        if let temp = annotation as? MyAnnotation{
        var myView = myMapView.dequeueReusableAnnotationView(withIdentifier: "Pins") as?MKMarkerAnnotationView
        if myView == nil{
            myView = MKMarkerAnnotationView(annotation: temp, reuseIdentifier: "Pins")
            myView?.markerTintColor = UIColor.green
            myView?.glyphText = "TEST"
            myView?.glyphTintColor = UIColor.black
            myView?.titleVisibility = .adaptive
            myView?.subtitleVisibility = .visible
        }
            
            
     return myView
           
    
    }
        func getUsersList() {
            guard let url = URL(string: "https://reqres.in/api/users/3") else { return }
            rest.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
                if let data = results.data {
                
                }
                print("\n\nResponse HTTP Headers:\n")
                if let response = results.response {
                    for (key, value) in response.headers.allValues() {
                        print(key, value)
                    }
                }
            }
        }

// MARK: CLLocationManagerDelegate Methods
    func setGoodIdeaStudioPoint(){
        let location = CLLocation(latitude:22.999034,longitude:120.212868)
        let region = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: 300,longitudinalMeters: 300)
        myMapView.setRegion(region, animated: true)
        let annotation = MyAnnotation(coordinate: location.coordinate)
        annotation.subtitle = "???????????????"
        annotation.subtitle = "????????????"
        myMapView.addAnnotation(annotation)
        
    }
      
        func tableView(tableView:UITableView,viewForHeaderInSection session:Int)->UIView?{
            return adBannerView
        }
        func displayInterstitialAds(){
            if isAdDisplay{
                canDisplayBannerAds = false
            }
            requestInterstitialAdPresentation()
            canDisplayBannerAds = true
        }
        func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!){
            //drawing path or route covered
            if let oldLocationNew = oldLocation as CLLocation?{
                 let oldCoordinates = oldLocationNew.coordinate
                 let newCoordinates = newLocation.coordinate
                 var area = [oldCoordinates, newCoordinates]
                let polyline = MKPolyline(coordinates: &area, count: area.count)
                myMapView.addOverlay(polyline)
             }
        }
        
        func createPolyline(mapView: MKMapView) {
            let point1 = CLLocationCoordinate2DMake(-73.761105, 41.017791);
            let point2 = CLLocationCoordinate2DMake(-73.760701, 41.019348);
            let point3 = CLLocationCoordinate2DMake(-73.757201, 41.019267);
            let point4 = CLLocationCoordinate2DMake(-73.757482, 41.016375);
            let point5 = CLLocationCoordinate2DMake(-73.761105, 41.017791);
            
            let points: [CLLocationCoordinate2D]
            points = [point1, point2, point3, point4, point5]
            
            let geodesic = MKGeodesicPolyline(coordinates: points, count: 5)
            myMapView.addOverlay(geodesic)
            
            UIView.animate(withDuration: 1.5, animations: { () -> Void in
                let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                let region1 = MKCoordinateRegion(center: point1, span: span)
                self.myMapView.setRegion(region1, animated: true)
            })
        }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // ??????????????????????????????
        
        let currentLocation :CLLocation =
            locations[0] as CLLocation
          //???????????????
        let range:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
       
          //??????
          let myLocation = currentLocation.coordinate
          let appearRegion:MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: range)
          
          //??????????????????
          myMapView.setRegion(appearRegion, animated: true)
        myMapView.showsUserLocation = true
        
        

    }
     func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer!{
            if (overlay is MKPolyline) {
                let pr = MKPolylineRenderer(overlay: overlay)
                pr.strokeColor = UIColor.red
                pr.lineWidth = 5
                return pr
            }
            return nil
        }
        //function to add annotation to map view
        func addAnnotationsOnMap(locationToPoint : CLLocation){

            let annotation = MKPointAnnotation()
            annotation.coordinate = locationToPoint.coordinate
            let geoCoder = CLGeocoder ()
            geoCoder.reverseGeocodeLocation(locationToPoint, completionHandler: { (placemarks, error) -> Void in
                if let placemarks = placemarks, placemarks.count > 0 {
                    let placemark = placemarks[0]
                    let addressDictionary = placemark.addressDictionary;
                    annotation.title = addressDictionary?["Name"] as? String
                    self.myMapView.addAnnotation(annotation)
                }
            })
            
            
        }
        
        func locationManager(_ manager: CLLocationManager,didUpdateHeading newHeading:CLHeading){
            if newHeading.headingAccuracy<0{
                print("???????????????????????????????????????")
            }else{
                print("????????????\(newHeading.magneticHeading)")

            }
        }
        
        func addAnnotations() {
          
        }
        enum SerializationError: Error {
            case missing(String)
        }
        struct Acronym {
            let id: Int
            let short: String
            let long: String
        }
        typealias JSONDictionary = [String : Any]
        return nil

    }
}

//QR code????????????????????????????????????
func launchApp(decodedURL: String){
    let alertPrompt = UIAlertController(title: "Open App", message: "You're going to open \(decodedURL)", preferredStyle: .actionSheet)
    let alert = UIAlertController(title: "title", message: "message", preferredStyle: .alert)

    //Create and add the Confirm action
    let confirmAction = UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
        //Do Something here...
        if let url = NSURL(string: decodedURL)
        {
            if UIApplication.shared.canOpenURL(url as URL){
                UIApplication.shared.openURL(url as URL)
            }
        }
    })
    
    alert.addAction(confirmAction)

    //Create and add the Cancel action
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
      
        //Do Something here...
    })
    alert.addAction(cancelAction)

    // Set Preferred Action method
    alert.preferredAction = confirmAction


}
func captureOutput(captureOutput:AVCaptureOutput!,didOutputMetadataObjects metadataObjects:[AnyObject]!,
                   fromConnection connection:AVCaptureConnection!){
    let metaObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
    if metadataObjects == nil || metadataObjects.count == 0{
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if metadataObj.stringValue != nil{
            
            launchApp(decodedURL: metadataObjects.debugDescription)
        }
        
    }
}
private func callAPI() {
       // ??????????????? Request tab info ???????????????????????????
    let apiKey2 = "ZEJtsYY2yTKTa8tUQ9TfMI1Jl7e6JfD5"
       let url = URL(string: "https://dataservice.accuweather.com/currentconditions/v1/315078?apikey=\(apiKey2)&language=zh-Tw")!
       
       // ????????????????????? URLRequest
       var request = URLRequest(url: url)
       
       // ???????????????????????? GET
       request.httpMethod = "GET"
       
       // ?????? URLSession
       let session = URLSession.shared
       
       // ?????? sesstion + request ???????????? task
       // ?????????????????????????????????????????????????????????
       let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
           // ???????????????????????????????????? code
           
           // ?????? data ??? optional????????????????????????????????? data ?????????
           // ?????????????????????????????? return???????????????????????????
           guard let data = data else {
               return
           }
           
           do {
               // ?????? JSONDecoder ????????? data
           
               
               // ?????? UI ?????????????????????????????????????????????????????? code ?????? DispatchQueue.main.async ??????????????????
               DispatchQueue.main.async {
            
                   // ??????????????? Array<WeatherModel> ????????? data????????????????????????????????????????????????????????????
               
            
               }
               
           } catch {
               print(error)
           }
           
       })
       
       // ?????? task
       dataTask.resume()
    

   }

let json = """
{
  "name":"John Davis",
  
  
}
"""
struct Resource<Model> {
    let url: URL
    let parse: (Data) throws -> Model
}
struct UpdateUserBody: Encodable {
    let name: String
    let job: String
}
struct UpdateUserResponse: Decodable {
    let name: String
    let job: String
}
extension Resource {
    init(url: URL, parseJSON: @escaping (Any) throws -> Model) {
        self.url = url
        self.parse = { data in
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return try parseJSON(json)
        }
    }
}

struct CreateSCMPBody: Encodable {
    let ArticleNum: String
    let name: String
    let id: String
    let brandName:String
    let number:Int
    let manufacture:String
 
    let unit:String
    let warehouseNumber:Int
    
    
}
struct CreateUserResponse: Decodable {
    let name: String
    let job: String
    let id: String
}
struct Meme {
   let id: Int
   let image: URL
   let caption: String
   let category: String
}
struct StoreItem: Codable {
   let artistName: String
   let trackName: String
   let collectionName: String?
   let previewUrl: URL
   let artworkUrl100: URL
   let trackPrice: Double?
   let releaseDate: Date
   let isStreamable: Bool?
}
struct SearchResponse: Codable {
   let resultCount: Int
   let results: [StoreItem]
}

extension Meme: Codable { }
struct Loan:Codable{
    var name:String
    var country:String
    var use:String
    var amount:Int
    
    enum CodingKeys:String,CodingKey{
        case name
        case country = "location"
        case use
        case amount = "loan_amount"
    }
    enum LocationKeys:String,CodingKey{
        case contry
    }
  
}
struct CoffeeData: Decodable {
     var name: String
     var city: String
 }
struct LoanStore:Codable{
    var loans:[Loan]
}
extension UIView{

    func showToast(text: String){
        
        self.hideToast()
        let toastLb = UILabel()
        toastLb.numberOfLines = 0
        toastLb.lineBreakMode = .byWordWrapping
        toastLb.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLb.textColor = UIColor.white
        toastLb.layer.cornerRadius = 10.0
        toastLb.textAlignment = .center
        toastLb.tintColor = .orange
        toastLb.font = UIFont.systemFont(ofSize: 15.0)
        toastLb.text = text
        toastLb.layer.masksToBounds = true
        toastLb.tag = 9999//tag???hideToast??????????????????remove??????label
        
        let maxSize = CGSize(width: self.bounds.width - 40, height: self.bounds.height)
        var expectedSize = toastLb.sizeThatFits(maxSize)
        var lbWidth = maxSize.width
        var lbHeight = maxSize.height
        if maxSize.width >= expectedSize.width{
            lbWidth = expectedSize.width
        }
        if maxSize.height >= expectedSize.height{
            lbHeight = expectedSize.height
        }
        expectedSize = CGSize(width: lbWidth, height: lbHeight)
        toastLb.frame = CGRect(x: ((self.bounds.size.width)/2) - ((expectedSize.width + 20)/2), y: self.bounds.height - expectedSize.height - 40 - 20, width: expectedSize.width + 20, height: expectedSize.height + 20)
        self.addSubview(toastLb)
        
        UIView.animate(withDuration: 1.5, delay: 1.5, animations: {
            toastLb.alpha = 0.0
        }) { (complete) in
            toastLb.removeFromSuperview()
        }
    }
    
    func hideToast(){
        for view in self.subviews{
            if view is UILabel , view.tag == 9999{
                view.removeFromSuperview()
            }
        }
    }
}

extension Acronym {
    static let all = Resource<[Acronym]>(url: URL(string: "http://localhost:8080/")!, parseJSON: { json in
        guard let dictionaries = json as? [JSONDictionary] else { throw SerializationError.missing("acronyms") }
        return try dictionaries.map(Acronym.init)
    })
}

enum Result<Model> {
    case success(Model)
    case failure(Error)
}
 
final class Webservice {
    func load<Model>(resource: Resource<Model>, completion: @escaping (Result<Model>) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { (data, _, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else {
                if let data = data {
                    do {
                        let result = try resource.parse(data)
                        DispatchQueue.main.async {
                            completion(.success(result))
                        }
                    } catch let error {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
            }
        }.resume()
    }
}
extension HKHealthStore
{
    public typealias CompletionHandler = ((HKQuantity?, Error?) -> Void)
}
enum SerializationError: Error {
    case missing(String)
}


struct City: Codable {
  let name: String
}

struct List: Codable {
  let main: Main
  let weather: [Weather]
  let dtTxt: String

  enum CodingKeys: String, CodingKey {
    case main, weather
    case dtTxt = "dt_txt"
  }
}

 struct Main: Codable {
    let temp: Double
 }

 struct Weather: Codable {
    let main, description: String
 }
struct User: Codable {
  let id: Int
  let userName: String
  let age: Int?

  // Generated automatically by the compiler if not specified
  private enum CodingKeys: String, CodingKey {
    case id
    case userName = "user_name"
    case age
  }
  
  // Generated automatically by the compiler if not specified
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: . id)
    try container.encode(userName, forKey: . userName)
    try container.encode(age, forKey: . age)
  }

 // Generated automatically by the compiler if not specified
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    userName = try container.decode(String.self, forKey: .userName)
    age = try container.decode(Int.self, forKey: .age)
  }
}

struct Acronym {
    let id: Int
    let short: String
    let long: String
}
extension UIView{

    func showToast2(text: String){
        
        let toastLb = UILabel()
        toastLb.numberOfLines = 0
        toastLb.lineBreakMode = .byWordWrapping
        toastLb.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLb.textColor = UIColor.white
        toastLb.layer.cornerRadius = 10.0
        toastLb.textAlignment = .center
        toastLb.font = UIFont.systemFont(ofSize: 15.0)
        toastLb.text = text
        toastLb.layer.masksToBounds = true
        
    }
}
typealias JSONDictionary = [String : Any]
extension Acronym {
    init(json: JSONDictionary) throws {
        guard let id = json["id"] as? Int else {
            throw SerializationError.missing("id")
        }
        guard let short = json["short"] as? String else {
            throw SerializationError.missing("short")
        }
        guard let long = json["long"] as? String else {
            throw SerializationError.missing("long")
        }
        self.id = id
        self.short = short
        self.long = long
    }
}
extension AppDelegate: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
    // create CLLocation from the coordinates of CLVisit
    let clLocation = CLLocation(latitude: visit.coordinate.latitude, longitude: visit.coordinate.longitude)

    // Get location description
  }

  func newVisitReceived(_ visit: CLVisit, description: String) {
   // let location = Location(visit: visit, descriptionString: description)
    // Save location to disk
  }
}
extension HKHealthStore
{
    func getClassName(obj : AnyObject) -> String
    {
        let objectClass : AnyClass! = object_getClass(obj)
        let className = objectClass.description()
        
        return className
    }
    
    func mostRecentQuantitySample(ofType quantityType: HKQuantityType, predicate: NSPredicate? = nil, completion: CompletionHandler? = nil)
    {
        let timeSortDescript: NSSortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        // Since we are interested in retrieving the user's latest sample, we sort the samples in descending order, and set the limit to 1. We are not filtering the data, and so the predicate is set to nil.
        let resultsHandler: (HKSampleQuery, [HKSample]?, Error?) -> Void = {
            
            (query, results, error) -> Void in
            
            guard let results = results else {
                
                if let completion = completion {
                    completion(nil, error)
                }
                
                return
            }
            
            if let completion = completion,
                let quantitySample: HKQuantitySample = results.last as? HKQuantitySample {
                
                // If quantity isn't in the database, return nil in the completion block.
                let quantity: HKQuantity = quantitySample.quantity
                
                completion(quantity, error)
            }
        }
        
        let query: HKSampleQuery = HKSampleQuery(sampleType: quantityType, predicate: predicate, limit: 1, sortDescriptors: [timeSortDescript], resultsHandler: resultsHandler)
        
        self.execute(query)
    }
}

