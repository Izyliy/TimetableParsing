//
//  MediumTimetable.swift
//  TimetableWidgetsExtension
//
//  Created by Павел Грабчак on 26.01.2023.
//

import WidgetKit
import SwiftUI

struct MediumTimetable: View {
    var entry: SimpleEntry
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Spacer()
                
                Text("ПИ2241")
                
//                Spacer()
                
                Text(Date.now, format: .dateTime)
                
                Spacer()
            }
            .padding(8)
            .padding(.top)
            .background(.blue)
            .foregroundColor(.white)
            .clipped()
            .shadow(radius: 5)
            
            ForEach(0..<3) { _ in
                HStack {
                    Rectangle()
                        .frame(width: 10, height: 46, alignment: .leading)
                        .foregroundColor(.yellow)
                        
                    Text("Математический анализ")
                        .font(.system(size: 20))
                    
                    Spacer()
                    
                    Text("14эк")
                }
                .padding(.top, -8)
                .padding(.bottom, -8)
                .padding(.trailing, 4)
            
                Divider()
                    .frame(height: 1)
            }
            
            Spacer()
        }
    }
}

struct MediumTimetable_Previews: PreviewProvider {
    static var previews: some View {
        MediumTimetable(entry: .init(date: .now))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
