//
//  CLSReport+LogDescriptions.swift
//  XCGCrashlyticsLogDestination
//
//  Created by Vitalii Budnik on 8/8/16.
//  Copyright © 2016 Vitalii Budnik. All rights reserved.
//

import Crashlytics

extension CLSReport {
	
	/// Human description for logging.
	public var logDescription: String {
		
		var string: String =
			String(format: "%@\nIs crash: %@\nCreated date:\(dateCreated)",
			       (self as CLSCrashReport).logDescription,
			       isCrash,
			       dateCreated)
		
		if let userIdentifier = userIdentifier {
			string.appendContentsOf("\nUser identifier: \(userIdentifier)")
		}
		
		if let userName = userName {
			string.appendContentsOf("\nUsername: \(userName)")
		}
		
		if let userEmail = userEmail {
			string.appendContentsOf("\nUser email: \(userEmail)")
		}
		
		return string
		
	}
	
}
