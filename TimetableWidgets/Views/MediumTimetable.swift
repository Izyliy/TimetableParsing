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
                
                Spacer()
                
                Text("Сегодня")
                
                Spacer()
            }
            .padding(4)
            .padding(.top, 6)
            .background(Color("LightGreen"))
            .foregroundColor(.white)
            .clipped()
            .shadow(radius: 5)
            
            ForEach(0..<3) { _ in
                HStack {
                    Rectangle()
                        .frame(width: 10, height: 43, alignment: .leading)
                        .foregroundColor(.orange)
                        
                    Text("Математический анализ и что то ")
//                        .font(.system(size: 16))
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: false)
                    
                    Spacer()
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("11:30-13:00")
                        Text("14эк")
                    }

                }
                .padding(.top, -8)
                .padding(.bottom, -8)
                .padding(.trailing, 4)
            
                Divider()
                    .frame(height: 1)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

struct MediumTimetable_Previews: PreviewProvider {
    static var previews: some View {
        MediumTimetable(entry: .init(date: .now))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13 mini"))
    }
}
