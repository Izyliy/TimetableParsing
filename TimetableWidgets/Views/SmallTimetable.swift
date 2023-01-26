//
//  SmallTimetable.swift
//  TimetableWidgetsExtension
//
//  Created by Павел Грабчак on 26.01.2023.
//

import WidgetKit
import SwiftUI

struct SmallTimetable: View {
    var entry: SimpleEntry
    
    var body: some View {
        GroupBox {
            HStack {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.secondary)
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("cewcwe")
                        .font(.headline)
                    
                    Text("compl")
                }
                
                Spacer()
            }
            .padding()
        } label: {
            Label("My table", systemImage: "pencil")
        }
    }
}

struct SmallTimetable_Previews: PreviewProvider {
    static var previews: some View {
        SmallTimetable(entry: .init(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
