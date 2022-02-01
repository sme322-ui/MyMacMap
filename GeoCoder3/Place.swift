//
//  Place.swift
//  GeoCoder
//
//  Created by Sie monyan on 2021/10/24.
//

import Foundation
import UIKit

protocol HomeModelDelegate {
    func itemDownloaded(locations:[Place])
}
class Place{
    var delegate:HomeModelDelegate?
    
   
    func getPlaces(){
        
    }
    
}
