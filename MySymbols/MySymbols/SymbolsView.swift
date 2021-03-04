//
//  SymbolsView.swift
//  MySymbols
//
//  Created by Cédric Bahirwe on 04/03/2021.
//

import SwiftUI

struct SymbolsView: View {
    private var symbols: [String] = Bundle.main.decode([String].self, from: "symbols.json")
    
    @State private var columns =
        [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    @State private var searchedSymbol = ""
    @State private var isSearching: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(
                            isSearching ?
                                symbols.filter({$0.lowercased().contains(searchedSymbol.lowercased())})
                                : symbols
                            , id:\.self) { symbol in
                            VStack {
                                Image(systemName: symbol)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text(symbol)
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.5)
                            }
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                        }
                    }
                    .padding(.horizontal, 10)
                    
                }
                .navigationBarTitle("Symbols")
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

struct SymbolsView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolsView()
    }
}


struct SearchingView: View {
    @Binding var searchedSymbol: String
    
    init(_ term: Binding<String>) {
        _searchedSymbol = term
    }
    var body: some View {
        HStack(spacing: 5) {
            HStack {
                TextField("Type somethin'", text: $searchedSymbol)
                    .autocapitalization(.none)
                    .disableAutocorrection(false)
                    .padding(.leading, 8)
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(.label))
                        .frame(width: 40, height: 40)
                })
            }
            .frame(height: 40)
            .border(Color(.label))
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            if !searchedSymbol.isEmpty {
                Button(action: {
                    withAnimation {
                        searchedSymbol = ""
                    }
                }, label: {
                    Text("Cancel")
                        .foregroundColor(Color(.darkGray))
                })
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 3)
        .background(Color(.systemBackground).opacity(0.9))
        
    }
}
