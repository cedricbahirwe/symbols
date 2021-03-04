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

struct SearchingView_Previews: PreviewProvider {
    static var previews: some View {
        SearchingView(.constant(""))
    }
}
