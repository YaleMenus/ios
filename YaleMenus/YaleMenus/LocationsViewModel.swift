//
//  LocationsViewModel.swift
//  YaleMenus
//
//  Created by Erik Kieran Boesen on 10/12/20.
//  Copyright © 2020 Erik Boesen. All rights reserved.
//

import Foundation

class LocationsViewModel: Identifiable {
    let id = UUID()
    let nm = NetworkManager()
    
    public var locations: [Location]? = nil;
    
    init() {
        nm.getLocations(completion: { locations in
            self.locations = locations;
        });
    }
    
    func openLocation() {
        
    }
}
