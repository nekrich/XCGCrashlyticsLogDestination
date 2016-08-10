//
//  NSError+xcgLoggerString.swift
//  XCGCrashlyticsLogDestination
//
//  Created by Vitalii Budnik on 8/10/16.
//  Copyright © 2016 Vitalii Budnik. All rights reserved.
//

import Foundation

internal extension NSError {
	
	/**
	XGCLogger description of `self`
	*/
	var xcgLoggerString: String {
		var array: [String] = []
		
		var customUserInfo: [NSObject : AnyObject] = userInfo
		
		if !localizedDescription.isEmpty {
			array.append("Description: \(localizedDescription)")
		}
		customUserInfo[NSLocalizedDescriptionKey] = .None
		
		array.append("Code: \(code)")
		array.append("Domain: \(domain)")
		
		// NSString
		if let localizedFailureReason = localizedFailureReason where !localizedFailureReason.isEmpty {
			array.append("Failure reason: \(localizedFailureReason)")
			customUserInfo[NSLocalizedFailureReasonErrorKey] = .None
		}
		
		// NSString
		if let localizedRecoverySuggestion = localizedRecoverySuggestion
			where !localizedRecoverySuggestion.isEmpty
		{
			array.append("Recovery suggestion: \(localizedRecoverySuggestion)")
			customUserInfo[NSLocalizedRecoverySuggestionErrorKey] = .None
		}
		
		// NSArray of NSStrings
		if let localizedRecoveryOptions = localizedRecoveryOptions
			where !localizedRecoveryOptions.isEmpty
		{
			array.append("Recovery options: \(localizedRecoveryOptions.joinWithSeparator("\t\n"))")
			customUserInfo[NSLocalizedRecoveryOptionsErrorKey] = .None
		}
		
		// Instance of a subclass of NSObject that conforms to the NSErrorRecoveryAttempting 
		// informal protocol
		if let recoveryAttempter = recoveryAttempter {
			array.append("Recovery attempter: \(recoveryAttempter)")
			customUserInfo[NSRecoveryAttempterErrorKey] = .None
		}
		
		// NSString containing a help anchor
		if let helpAnchor = helpAnchor {
			array.append("Help anchor: \(helpAnchor)")
			customUserInfo[NSHelpAnchorErrorKey] = .None
		}
		
		// NSNumber containing NSStringEncoding
		if let stringEncoding = customUserInfo[NSStringEncodingErrorKey] {
			array.append("String encoding: \(stringEncoding)")
			customUserInfo[NSStringEncodingErrorKey] = .None
		}
		
		// A recommended standard way to embed NSErrors from underlying calls. 
		// The value of this key should be an NSError.
		if let underlying = customUserInfo[NSUnderlyingErrorKey] as? NSError {
			array.append(
				String(format: "Underlying error: %@",
					underlying.xcgLoggerString.stringByReplacingOccurrencesOfString("\n", withString: "\t\n")))
			customUserInfo[NSUnderlyingErrorKey] = .None
		}
		
		// NSURL
		if let url = customUserInfo[NSURLErrorKey] as? NSURL {
			array.append("URL: \(url.absoluteString)")
			customUserInfo[NSURLErrorKey] = .None
		}
		
		// NSString
		if let filePath = customUserInfo[NSFilePathErrorKey] {
			array.append("URL error: \(filePath)")
			customUserInfo[NSFilePathErrorKey] = .None
		}
		
		if !customUserInfo.isEmpty {
			array.append("User info: \(customUserInfo)")
		}
		
		let errorPresentation = array.joinWithSeparator("\n")
		
		return errorPresentation
		
	}
	
}
