//
//  CrashlyticsHandler.swift
//  XCGCrashlyticsLogDestination
//
//  Created by Vitalii Budnik on 8/8/16.
//  Copyright © 2016 Vitalii Budnik. All rights reserved.
//

import Crashlytics
import XCGLogger

internal let kLastExecutionErrorPrefix = "Last execution error:\n"

internal class CrashlyticsHandler: NSObject {
	
	internal private (set) static var sharedInstance = CrashlyticsHandler()
	
	private override init() {
		super.init()
		Crashlytics.sharedInstance().delegate = self
	}
	
	private var logger: XCGLogger? = .None
	private convenience init(logger: XCGLogger) {
		self.init()
		self.logger = logger
	}
	
	static var logger: XCGLogger? = .None {
		didSet {
			guard let logger = logger else {
				return
			}
			sharedInstance = CrashlyticsHandler(logger: logger)
		}
	}
	
}

extension CrashlyticsHandler: CrashlyticsDelegate {
	
	internal func crashlyticsCanUseBackgroundSessions(crashlytics: Crashlytics) -> Bool {
		return true
	}
	
	internal func crashlyticsDidDetectReportForLastExecution(
		report: CLSReport,
		completionHandler: (Bool) -> Void)
	{
		logger?.severe(kLastExecutionErrorPrefix.stringByAppendingString(report.logDescription))
		completionHandler(true)
	}
	
}
