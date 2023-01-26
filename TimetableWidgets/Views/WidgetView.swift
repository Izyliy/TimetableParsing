//
//  WidgetView.swift
//  TimetableWidgetsExtension
//
//  Created by Павел Грабчак on 26.01.2023.
//

import WidgetKit
import SwiftUI

struct TimetableWidgetView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry

    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            SmallTimetable(entry: entry)
        case .systemMedium:
            MediumTimetable(entry: entry)
        default:
            Text("Not implemented")
        }
    }
}
