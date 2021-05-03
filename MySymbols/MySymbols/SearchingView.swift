//
//  SearchingView.swift
//  MySymbols
//
//  Created by Cédric Bahirwe on 04/03/2021.
//

import SwiftUI

struct SearchingView: View {
    @Binding var searchedSymbol: String
    
    init(_ term: Binding<String>) {
        _searchedSymbol = term
    }
    var body: some View {
        HStack {
            TextField("Type somethin'", text: $searchedSymbol)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.leading, 8)
            
            Button(action: {
                withAnimation {
                    searchedSymbol = ""
                }
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

            }, label: {
                Image(systemName: searchedSymbol.isEmpty ? "magnifyingglass" : "multiply")
                    .foregroundColor(Color(.label))
                    .frame(width: 40, height: 40)
            })
            .disabled(searchedSymbol.isEmpty)
        }
        .font(.system(size: 20, weight: .semibold, design: .rounded))
        .frame(height: 40)
        .border(Color(.label))
        .padding(.horizontal)
        .padding(.bottom, 3)
        .background(Color(.systemBackground).opacity(0.9))
        
    }
}

struct SearchingView_Previews: PreviewProvider {
    static var previews: some View {
        SearchingView(.constant(""))
    }
}
