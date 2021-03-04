//
//  RestrictedSymbolsView.swift
//  MySymbols
//
//  Created by Cédric Bahirwe on 04/03/2021.
//

import SwiftUI

fileprivate struct RestrictedSymbol:Decodable, Hashable {
    var symbolName: String
    var feature: String
}


struct RestrictedSymbolsView: View {
    private var restrictedSymbols: [RestrictedSymbol] = Bundle.main.decode([RestrictedSymbol].self, from: "restrictedSymbols.json").filter({ !$0.symbolName.hasSuffix(".rtl")})
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(restrictedSymbols, id: \.self) { restrictedSymbol in
                    VStack {
                        Image(systemName: restrictedSymbol.symbolName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text(restrictedSymbol.feature)
                            .minimumScaleFactor(0.65)
                    }
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                }
            }
            .padding(.horizontal, 10)
            .navigationBarTitle("Restricted Symbols")
        }
        
    }
}

struct RestrictedSymbolsView_Previews: PreviewProvider {
    static var previews: some View {
        RestrictedSymbolsView()
    }
}
