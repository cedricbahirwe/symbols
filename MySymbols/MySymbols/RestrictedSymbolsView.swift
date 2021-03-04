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
    
    @State private var searchedSymbol = ""
    @State private var isSearching: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    Spacer()
                        .frame(height: 45)
                    ForEach(
                        isSearching ?
                            restrictedSymbols.filter({$0.symbolName.lowercased().contains(searchedSymbol.lowercased())})
                            : restrictedSymbols
                        , id: \.self) { restrictedSymbol in
                        VStack {
                            Image(systemName: restrictedSymbol.symbolName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .zIndex(-1)
                            Text(restrictedSymbol.feature)
                                .minimumScaleFactor(0.65)
                        }
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                    }
                    .zIndex(5)
                }
                .padding(.horizontal, 10)
                .navigationBarTitle("Restricted Symbols")
            }
            .frame(maxWidth: .infinity)
            .overlay(SearchingView($searchedSymbol) , alignment: .top)
            .onChange(of: searchedSymbol, perform: checkSearch)
        }
    }
    
    func checkSearch(_ value: String) {
        withAnimation {
            isSearching = !value.isEmpty
        }
    }
}

struct RestrictedSymbolsView_Previews: PreviewProvider {
    static var previews: some View {
        RestrictedSymbolsView()
    }
}
