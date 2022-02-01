//
//  RouteTableViewController.swift
//  GeoCoder
//
//  Created by Sie monyan on 2021/12/26.
//

import Foundation
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

class RouteTableViewController: UIViewController, CLLocationManagerDelegate{
    var routeSteps = [MKRoute.Step]()
    var currentRoute:MKRoute?
  
     func numberOfSessionsInTableView(tableView:UITableView)->Int{
        return 1
    }
    func tableView(tableView:UITableView,numberOfRowsInSection session:Int)->Int{
        return routeSteps.count
    }
     func tableView(tableView:UITableView,cellForRowAtIndexPath indexPath:NSIndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath as IndexPath) as! UITableViewCell
        cell.textLabel?.text = routeSteps[indexPath.row].instructions
        return cell
    }
    func mapView(mapView:MKMapView!,annotationView view: MKAnnotationView!,calloutAccessoryControlTApped control:UIControl!){
        self.performSegue(withIdentifier: "showSteps", sender: view)
    }
    
    func prepareForSeque(seque: UIStoryboardSegue,sender:AnyObject?){
        if seque.identifier == "showSteps"{
            let destinationController = seque.destination as! UINavigationController
            let routeTableViewController = destinationController.childViewControllerForPointerLock?.isFirstResponder as! RouteTableViewController
            if let steps = currentRoute?.steps as? [MKRoute.Step]{
                routeTableViewController.routeSteps = steps
            }
        }
    }
    
}
