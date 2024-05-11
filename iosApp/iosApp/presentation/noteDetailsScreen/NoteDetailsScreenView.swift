//
//  NoteDetailsScreenView.swift
//  iosApp
//
//  Created by Abdelrahman esam on 06/04/2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import shared
struct NoteDetailsScreenView: View {

    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>

    var viewModel : NoteDetailsViewModel = inject()
    
    
    var backgroundColor : Color
    @Binding var title : String
    @Binding var description : String
   @State var showTitleError : Bool = false
   @State var showDescriptionError : Bool = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            
           
            
            VStack{
                TextField("enter title", text: $title,onEditingChanged: { _ in
                    
                    viewModel.onEvent(intent: NoteDetailsIntentsOnNewTitleChanged(title: title))
                }).padding()
                if title.isEmpty && showTitleError {
                    Text("this field can't be empty"
                            )
                            .frame(width: .infinity)
                            .fontWeight(.ultraLight)
                            .font(.system(size:10))
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                
                TextField("enter description", text:$description,onEditingChanged: { _ in
                    
                    viewModel.onEvent(intent: NoteDetailsIntentsOnNewContentChanged(content: description))
                    
                }).padding()
                  
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .background(backgroundColor)
            
            
            Button(action: {
                if title.isEmpty {
                   showTitleError = true
                    return
                }
                
                if description.isEmpty {
                    showDescriptionError = true
                    return
                }
                
                
                viewModel.onEvent(intent: NoteDetailsIntentsInsertNote())
                
                presentationMode.wrappedValue.dismiss()
                
            }, label: {
                
                Image(systemName: "checkmark")
                    .padding(.all,25)
                    .background(Color(hex : 0xFF444444))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .padding(.trailing , 25)
            }
                   
            )
            
        }
    }
}

#Preview {
    NoteDetailsScreenView(backgroundColor: .blue,title : .constant(""),description: .constant(""))
}
