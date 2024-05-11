//
//  NotesScreenView.swift
//  iosApp
//
//  Created by Abdelrahman esam on 05/04/2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import shared
struct NotesScreenView: View {

//todo koin is incompatible with androidx viewModel
    @State var viewModel : NotesViewModel = inject()
    
    var body: some View {
        ZStack{
            VStack{
                ZStack{
                    HideableTextSearch(textSearch: .constant("...search"), onSearchToggled: {
                        
                        viewModel.onEvent(intent: NotesIntentsGetAllNotes())
                        
                    }, isSearchActive: viewModel.notesState.value.isSearchingActive, onSearchChangedCallback: { searchText in
                        
                        viewModel.onEvent(intent: NotesIntentsSearchNoteByTitle(search: searchText))
                    }, destinationProvider: {
                        EmptyView()
                    }).frame(maxWidth : .infinity , minHeight: 40)
                        .padding()
                    
                    if !viewModel.notesState.value.isSearchingActive {
                        Text("All Notes")
                            .font(.title2 )
                    }
                    
                    List{
                        ForEach(viewModel.notesState.value.filteredNotes, id: \.self.id){ note in
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                                NoteItem(note: note, onDeleteNote: {
                                    viewModel.onEvent(intent:  NotesIntentsDeleteNoteById(id: note.id!.int64Value))
                                })
                            }
                            
                        }
                    }.listStyle(.plain)
                        .listRowSeparator(.hidden)
                }
            }
            
            Button {} label: {
                Image(systemName: "plus").padding()
                    .background(.brown)
                    .clipShape(Circle())
            }.padding(.trailing , 25)
        }
    }
}

#Preview {
    NotesScreenView()
}
