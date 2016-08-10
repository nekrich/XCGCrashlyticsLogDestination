//
//  CLSCrashReport+LogDescription.swift
//  XCGCrashlyticsLogDestination
//
//  Created by Vitalii Budnik on 8/8/16.
//  Copyright © 2016 Vitalii Budnik. All rights reserved.
//

import Crashlytics

public extension CLSCrashReport {
	
	/// Human description for logging.
	var logDescription: String {
		
		let string: String =
			String(format:
				"OS: %@ (build %@)\nBundle version: %@ (%@)\nIdentifier: %@\nCrash date: %@\nKeys: %@",
			       OSVersion,
			       OSBuildVersion,
			       bundleShortVersionString,
			       bundleVersion,
			       identifier,
			       crashedOnDate,
			       customKeys)
		
		return string
	}
	
}
