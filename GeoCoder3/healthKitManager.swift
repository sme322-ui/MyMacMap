//
//  healthkitManager.swift
//  GeoCoder
//
//  Created by Sie monyan on 2021/10/17.
//

import UIKit
import HealthKit

class HealthKitManager: NSObject {
    
    class var sharedInstance: HealthKitManager{
        struct Singleton {
            static let instance = HealthKitManager()
        }
        return Singleton.instance
    }
    
    let healthStore: HKHealthStore? = {
        
        if HKHealthStore.isHealthDataAvailable(){
            return HKHealthStore()
        }else{
            return nil
        }
    }()
    
    let stepsCount = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
    let stepsUnit  = HKUnit.count()
    
    let distanceWalkingRunning = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)
    let distanceSwimming = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceSwimming)
    
    let distanceUnit =  HKUnit.mile()
    
    let flightsClimbed = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.flightsClimbed)
    let flightClimbedUnit  = HKUnit.count()


}
