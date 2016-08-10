//
//  XCGLogger+Crashlytics.swift
//  XCGCrashlyticsLogDestination
//
//  Created by Vitalii Budnik on 8/10/16.
//  Copyright © 2016 Vitalii Budnik. All rights reserved.
//

import XCGLogger
import Crashlytics

/**
Non-fatal `NSError` support
*/
public extension XCGLogger {
	
	/**
	Writes log with `Error` level, using `()->NSError?` closure, and sends resulting string
	to Crashlytics as non-fatal error.
	
	- parameter closure: closure, that returns `NSError` or `nil`.
	- parameter functionName: function name. Default value: `#function`.
	- parameter fileName: file name. Default value: `#file`.
	- parameter lineNumber: line number. Default value: `#line`.
	*/
	func nonFatalError(
		@autoclosure closure: () -> NSError?,
		functionName: String = #function,
		fileName: String = #file,
		lineNumber: Int = #line)
	{
		
		self.logNonFatalError(.Error,
		                      closure: closure,
		                      functionName: functionName,
		                      fileName: fileName,
		                      lineNumber: lineNumber)
		
	}
	
	/**
	Writes log with `Error` level, using `()->NSError?` closure, and sends resulting string
	to Crashlytics as non-fatal error.
	
	- parameter functionName: function name. Default value: `#function`.
	- parameter fileName: file name. Default value: `#file`.
	- parameter lineNumber: line number. Default value: `#line`.
	- parameter closure: closure, that returns `NSError` or `nil`.
	*/
	func nonFatalError(
		functionName: String = #function,
		fileName: String = #file,
		lineNumber: Int = #line,
		@noescape closure: () -> NSError?)
	{
		
		self.logNonFatalError(.Error,
		                      closure: closure,
		                      functionName: functionName,
		                      fileName: fileName,
		                      lineNumber: lineNumber)
		
	}
	
	private func logNonFatalError(
		logLevel: XCGLogger.LogLevel,
		@noescape closure: () -> NSError?,
		functionName: String,
		fileName: String,
		lineNumber: Int)
	{
		
		guard let logError = closure() else { return }
		
		let logDetails = XCGLogDetails(logLevel: logLevel,
		                               date: NSDate(),
		                               logMessage: logError.xcgLoggerString,
		                               functionName: functionName,
		                               fileName: fileName,
		                               lineNumber: lineNumber)
		
		self.logln(logDetails)
		
		Crashlytics.sharedInstance()
			.recordError(XCGLogDetails.NSErrorConstructorType.NSErrorUsing(logDetails: logDetails))
		
	}
}

/**
Non-fatal `String` support
*/
public extension XCGLogger {
	
	/**
	Writes log with `Error` level, using `()->String?` closure, and sends resulting string 
	to Crashlytics as non-fatal error.
	
	- note: Uses constructor, setted in `XCGLogDetails.NSErrorConstructorType`
	
	- parameter closure: closure, that returns `NSError` or `nil`.
	- parameter functionName: function name. Default value: `#function`.
	- parameter fileName: file name. Default value: `#file`.
	- parameter lineNumber: line number. Default value: `#line`.
	*/
	func nonFatalError(
		@autoclosure closure: () -> String?,
		functionName: String = #function,
		fileName: String = #file,
		lineNumber: Int = #line)
	{
		
		self.logNonFatalError(.Error,
		                      closure: closure,
		                      functionName: functionName,
		                      fileName: fileName,
		                      lineNumber: lineNumber)
		
	}
	
	/**
	Writes log with `Error` level, using `()->String?` closure, and sends resulting string 
	to Crashlytics as non-fatal error.
	
	- note: Uses constructor, setted in `XCGLogDetails.NSErrorConstructorType`
	
	- parameter functionName: function name. Default value: `#function`.
	- parameter fileName: file name. Default value: `#file`.
	- parameter lineNumber: line number. Default value: `#line`.
	- parameter closure: closure, that returns `NSError` or `nil`.
	*/
	func nonFatalError(
		functionName: String = #function,
		fileName: String = #file,
		lineNumber: Int = #line,
		@noescape closure: () -> String?)
	{
		
		self.logNonFatalError(.Error,
		                      closure: closure,
		                      functionName: functionName,
		                      fileName: fileName,
		                      lineNumber: lineNumber)
		
	}
	
	private func logNonFatalError(
		logLevel: XCGLogger.LogLevel,
		@noescape closure: () -> String?,
		functionName: String,
		fileName: String,
		lineNumber: Int)
	{
		
		guard let logMessage = closure() else { return }
		
		let logDetails = XCGLogDetails(logLevel: logLevel,
		                               date: NSDate(),
		                               logMessage: logMessage,
		                               functionName: functionName,
		                               fileName: fileName,
		                               lineNumber: lineNumber)
		
		self.logln(logDetails)
		
		Crashlytics.sharedInstance()
			.recordError(XCGLogDetails.NSErrorConstructorType.NSErrorUsing(logDetails: logDetails))
		
	}
	
}

private extension XCGLogger {
	
	func logln(logDetails: XCGLogDetails) {
		for logDestination in self.logDestinations {
			if logDestination.isEnabledForLogLevel(logDetails.logLevel) {
				logDestination.processLogDetails(logDetails)
			}
		}
	}
	
}
