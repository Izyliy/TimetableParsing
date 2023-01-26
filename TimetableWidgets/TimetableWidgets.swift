//
//  TimetableWidgets.swift
//  TimetableWidgets
//
//  Created by Павел Грабчак on 26.01.2023.
//

import WidgetKit
import SwiftUI

struct TimetableWidget: Widget {
    let kind: String = "TimetableWidgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TimetableWidgetView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("Расписание")
        .description("Избранное расписание, выбранное в приложении")
    }
}

struct TimetableWidgets_Previews: PreviewProvider {
    static var previews: some View {
        TimetableWidgetView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
