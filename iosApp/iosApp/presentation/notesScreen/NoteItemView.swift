//
//  NoteCardItem.swift
//  iosApp
//
//  Created by Abdelrahman esam on 06/04/2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import shared

struct NoteItem: View {
    var note : NoteModel
    var onDeleteNote : () -> Void
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(note.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                Button(action : onDeleteNote){
                    Image(systemName:"xmark").foregroundColor(.black)
                }
                
            }.padding(.bottom, 3 )
            Text(note.content)
                .fontWeight(.light)
                .padding(.bottom,3 )
            
            HStack{
                Spacer()
                Text(DateTimeUtil().formatNoteDate(time : note.timeStamp))
                    .font(.footnote)
                    .fontWeight(.light)
            }
        }.padding()
            .background(Color(hex : note.color))
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

#Preview  {
    NoteItem(note: NoteModel(id: nil, title: "previewNote", content: "take me throw the night fall into the darkside", color: 0xff63546, timeStamp: DateTimeUtil().now()), onDeleteNote: {})
}
