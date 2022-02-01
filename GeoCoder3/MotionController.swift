import UIKit
import CoreMotion
class ViewController2:UIViewController{
    @IBOutlet weak var xAccel:UITextField!
    @IBOutlet weak var jAccel: UITextField!
    @IBOutlet weak var zAccel: UITextField!

    
    var motion = CMMotionManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    func myAcclerometer(){
        motion.accelerometerUpdateInterval = 0.5
        motion.startAccelerometerUpdates(to: OperationQueue.current!){
            (data,error) in
            if let trueData = data{
                self.view.reloadInputViews()
                let x = trueData.acceleration.x
         
                let z = trueData.acceleration.z
                
                self.xAccel.text = "x: \(Double(x))"
              

                self.zAccel.text = "z: \(Double(z))"

            }
        }
    }
}

extension Double{
    func rounded(toPlaces places:Int)->Double{
        let divisor = pow(10.0,Double(places))
        return (self*divisor).rounded()/divisor
    }
    
}
