//
//  ContentView.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import CocoaLumberjackSwift
import SwiftUI

struct ContentView: View {

    init() {
        initLogger()
    }

    var body: some View {
        TodoList()
    }

    func initLogger() {
        let consoleLogger = DDOSLogger.sharedInstance
        let customFormatter = Logger()
        consoleLogger.logFormatter = customFormatter
        DDLog.add(consoleLogger)
    }
}

#Preview {
    ContentView()
}
