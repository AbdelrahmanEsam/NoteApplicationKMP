//
//  HideableTextSearch.swift
//  iosApp
//
//  Created by Abdelrahman esam on 06/04/2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct HideableTextSearch<Destination : View>: View {
    
    @Binding var textSearch : String
    var onSearchToggled : () -> Void
    var isSearchActive : Bool
    var onSearchChangedCallback : (String) -> Void
    var destinationProvider : () -> Destination
    var body: some View {
        HStack{
            TextField("search ...", text: $textSearch, onEditingChanged:{ (editing) in
                
              })
                .textFieldStyle(.roundedBorder )
                .opacity(isSearchActive ? 1 : 0)
            if !isSearchActive {
                Spacer()
            }
            Button(action : onSearchToggled){
                Image(systemName:  isSearchActive ? "xmark": "magnifyingglass")
            }
            NavigationLink(destination: destinationProvider){
                Image(systemName: "plus" )
            }
        }
        
    }
}

#Preview {
    HideableTextSearch( textSearch : .constant("yes"), onSearchToggled: {
    
    }, isSearchActive: true,onSearchChangedCallback: { searchText in
        
    }, destinationProvider: {
        EmptyView()
    })
}
