//
//  LocationInfoViewModel.swift
//  YaleMenus
//
//  Created by Erik Kieran Boesen on 12/30/20.
//  Copyright © 2020 Erik Boesen. All rights reserved.
//

import Foundation

class LocationInfoViewModel: ObservableObject, Identifiable {
    let id = UUID()
    let nm = NetworkManager()
    
    var location: Location
    var managers: [Manager]? = nil
    
    init(location: Location) {
        self.location = location
    }
}
