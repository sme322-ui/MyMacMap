//
//  AnnotationView.swift
//  GeoCoder
//
//  Created by Sie monyan on 2021/10/8.
//

import Foundation
import MapKit

class MyAnnotation: NSObject,MKAnnotation{
    var coordinate:CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D){
        self.coordinate = coordinate
    }
    
    
    
}
