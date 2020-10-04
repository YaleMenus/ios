//
//  ContentView.swift
//  YaleMenus
//
//  Created by Erik Kieran Boesen on 10/3/20.
//  Copyright © 2020 Erik Boesen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            LocationsView()
        }.padding()
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
