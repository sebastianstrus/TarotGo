//
//  ContentView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ReadingSession.self)
}
