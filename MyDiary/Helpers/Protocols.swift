//
//  Protocols.swift
//  MyDiary
//
//  Created by Mike Conner on 5/4/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark)
}

protocol LocationDelegate: AnyObject {
    func getLocation(placemark: String)
}
