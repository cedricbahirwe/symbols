//
//  TabBarView.swift
//  MySymbols
//
//  Created by Cédric Bahirwe on 04/03/2021.
//

import SwiftUI

struct TabBarView: View {
    @State private var selection: Int = 1
    @State private var color = Color.primary
    var body: some View {
        TabView(selection: $selection)  {
            SymbolsView(color: $color)
                .tabItem {
                    Image(systemName: "house.circle.fill")
                    Text("Symbols")
                }.tag(1)
            
            RestrictedSymbolsView(color: $color)
                .tabItem {
                    Image(systemName: "staroflife.circle.fill")
                    Text("Restricted Symbols")
                }.tag(2)
        }
        .foregroundColor(color)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
