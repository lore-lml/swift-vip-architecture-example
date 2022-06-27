//
//  Log.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 27/06/22.
//

import Foundation

public final class Log {
    
    static var refDate : Date?;

    enum LogEvent: String {
        case error = "[❌]" // error
        case info = "[ℹ️]" // info
        case debug = "[🚀]" // debug
        case warning = "[⚠️]" // warning
    }
    
    
    public static func d<T>(_ object: @autoclosure () -> T, filename: String = #file, line: Int = #line, function: String = #function) {
        printLog("\n\(LogEvent.debug.rawValue) ⏱ \(ISO8601DateFormatter.string(from: Date(), timeZone: .current, formatOptions: [.withInternetDateTime])) 👉 \((filename as NSString).lastPathComponent) [\(line) - \(function)]\n\(object())\n")
    }
    
    public static func i<T>(_ object: @autoclosure () -> T, filename: String = #file, line: Int = #line, function: String = #function) {
        printLog("\n\(LogEvent.info.rawValue) ⏱ \(ISO8601DateFormatter.string(from: Date(), timeZone: .current, formatOptions: [.withInternetDateTime])) 👉 \((filename as NSString).lastPathComponent) [\(line) - \(function)]\n\(object())\n")
    }
    
    public static func w<T>(_ object: @autoclosure () -> T, filename: String = #file, line: Int = #line, function: String = #function) {
        printLog("\n\(LogEvent.warning.rawValue) ⏱ \(ISO8601DateFormatter.string(from: Date(), timeZone: .current, formatOptions: [.withInternetDateTime])) 👉 \((filename as NSString).lastPathComponent) [\(line) - \(function)]\n\(object())\n")
    }
    
    public static func e<T>(_ object: @autoclosure () -> T, filename: String = #file, line: Int = #line, function: String = #function) {
        printLog("\n\(LogEvent.error.rawValue) ⏱ \(ISO8601DateFormatter.string(from: Date(), timeZone: .current, formatOptions: [.withInternetDateTime])) 👉 \((filename as NSString).lastPathComponent) [\(line) - \(function)]\n\(object())\n")
    }
    
    
    static private var isLogEnabled: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    
    private static func printLog(_ text: String) {
        guard isLogEnabled else { return }
        
        // console log
        print(text)
    }
    
    
    public class func elapsedTime() -> Double {
        let now = Date();
        let x = now.timeIntervalSince1970 - self.refDate!.timeIntervalSince1970
        self.refDate = Date()
        return x;
        
    }
    
    
    public class func startElaps() {
        self.refDate = Date()
    }
    
}

