//
//  DefaultNSErrorFomXCGLogDetailsConstructor.swift
//  XCGCrashlyticsLogDestination
//
//  Created by Vitalii Budnik on 8/9/16.
//  Copyright © 2016 Vitalii Budnik. All rights reserved.
//

import XCGLogger

// swiftlint:disable type_name

/// Default implementation of `NSErrorFomXCGLogDetailsConstructor`
public class DefaultNSErrorFomXCGLogDetailsConstructor: NSErrorFomXCGLogDetailsConstructor {
// swiftlint:enable type_name
	
	static var CrashlyticsNSErrorDomain: String = "com.XCGLogger"
	static var CrashlyticsNSErrorCode: Int = 1
	
	public static func NSErrorUsing( // swiftlint:disable:this missing_docs
		logDetails logDetails: XCGLogDetails)
		-> NSError
	{
		
		let error = NSError(domain: CrashlyticsNSErrorDomain,
		                    code: CrashlyticsNSErrorCode,
		                    userInfo: logDetails.errorUserInfo)
		
		return error
		
	}
	
}

private extension XCGLogDetails {
	
	/**
	The userInfo dictionary for the error
	*/
	var errorUserInfo: [NSObject : AnyObject] {
		
		let userInfo: [NSObject : AnyObject] = [
			"date" : date,
			"level" : logLevel.description,
			NSLocalizedDescriptionKey: logMessage,
			NSFilePathErrorKey: String(format: "%@:%d, function: '%@'", fileName, lineNumber, functionName)]
		
		return userInfo
		
	}
	
}
