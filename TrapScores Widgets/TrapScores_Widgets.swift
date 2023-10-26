//
//  TrapScores_Widgets.swift
//  TrapScores Widgets
//
//  Created by Doxie Davis on 10/26/23.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider, TimelineProvider {
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

    func recommendations() -> [AppIntentRecommendation<ConfigurationAppIntent>] {
        // Create an array with all the preconfigured widgets to show.
        [AppIntentRecommendation(intent: ConfigurationAppIntent(), description: "Example Widget")]
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct TrapScores_WidgetsEntryView : View {
    
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    
    var body: some View {
        
        switch widgetFamily {
        case .accessoryCorner:
            ComplicationCorner()
        case .accessoryCircular:
            ComplicationCircular()
        case .accessoryRectangular:
            Text("Rectangular")
        case .accessoryInline:
            Text("no widget")
        @unknown default:
            //mandatory as there are more widget families as in lockscreen widgets etc
            Text("Not an implemented widget yet")
        }
    }
    
//    var entry: Provider.Entry
//
//    var body: some View {
//        VStack {
//            HStack {
//                Text("Time:")
//                Text(entry.date, style: .time)
//            }
//        
//            Text("Favorite Emoji:")
//            Text(entry.configuration.favoriteEmoji)
//        }
//    }
}

@main
struct TrapScores_Widgets: Widget {
    
    let kind: String = "com.doxiedavis.TrapScores.Widgetsconfiguration"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TrapScores_WidgetsEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("TrapScores")
        .description("This will launch TrapScores App")
        .supportedFamilies([.accessoryCorner, .accessoryCircular])
    }
    
//    let kind: String = "TrapScores_Widgets"
//
//    var body: some WidgetConfiguration {
//        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
//            TrapScores_WidgetsEntryView(entry: entry)
//                .containerBackground(.fill.tertiary, for: .widget)
//        }
//    }
}

//extension ConfigurationAppIntent {
//    fileprivate static var smiley: ConfigurationAppIntent {
//        let intent = ConfigurationAppIntent()
//        intent.favoriteEmoji = "😀"
//        return intent
//    }
//    
//    fileprivate static var starEyes: ConfigurationAppIntent {
//        let intent = ConfigurationAppIntent()
//        intent.favoriteEmoji = "🤩"
//        return intent
//    }
//}

struct ComplicationCircular: View {
    var body: some View {
        Image("Graphic Circular")
            .widgetAccentable(true)
            .unredacted()
    }
}
struct ComplicationCorner: View {
    var body: some View {
        Image("Graphic Circular")
            .widgetAccentable(true)
            .unredacted()
    }
}

//#Preview(as: .accessoryRectangular) {
//    TrapScores_Widgets()
//} timeline: {
//    SimpleEntry(date: .now, configuration: .smiley)
//    SimpleEntry(date: .now, configuration: .starEyes)
//}    
