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

    @Published var location: Location
    @Published var managers: [Manager]?

    init(location: Location) {
        self.location = location
        nm.getManagers(locationId: self.location.id, completion: { managers in
            self.managers = managers
            print(self.managers)
        })
    }
}
