//
//  TodotifyApp.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import CocoaLumberjackSwift
import SwiftUI

@main
struct TodotifyApp: App {
//    @StateObject private var networkService = DefaultNetworkingService.shared

    init() {
        initLogger()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environmentObject(networkService)
        }
    }

    func initLogger() {
        let consoleLogger = DDOSLogger.sharedInstance
        let customFormatter = Logger()
        consoleLogger.logFormatter = customFormatter
        DDLog.add(consoleLogger)

        let fileLogger: DDFileLogger = DDFileLogger()
        fileLogger.rollingFrequency = 60 * 60 * 24
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }
}
