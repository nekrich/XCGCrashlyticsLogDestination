//
//  XCGLogger+NSError.swift
//  XCGCrashlyticsLogDestination
//
//  Created by Vitalii Budnik on 8/9/16.
//  Copyright © 2016 Vitalii Budnik. All rights reserved.
//

import XCGLogger

/**
`NSError` support
*/
public extension XCGLogger {
	
	/**
	Writes log with `Error` level, using `()->NSError?` closure.
	
	- parameter closure: closure, that returns `NSError` or `nil`.
	- parameter functionName: function name. Default value: `#function`.
	- parameter fileName: file name. Default value: `#file`.
	- parameter lineNumber: line number. Default value: `#line`.
	*/
	public func error(
		@autoclosure closure: () -> NSError?,
		functionName: String = #function,
		fileName: String = #file,
		lineNumber: Int = #line)
	{
		self.logNSError(logLevel: .Error,
		                closure: closure,
		                functionName: functionName,
		                fileName: fileName,
		                lineNumber: lineNumber)
	}
	
	/**
	Writes log with `Error` level, using `()->NSError?` closure.
	
	- parameter functionName: function name. Default value: `#function`.
	- parameter fileName: file name. Default value: `#file`.
	- parameter lineNumber: line number. Default value: `#line`.
	- parameter closure: closure, that returns `NSError` or `nil`.
	*/
	public func error(
		functionName: String = #function,
		fileName: String = #file,
		lineNumber: Int = #line,
		@noescape closure: () -> NSError?)
	{
		self.logNSError(logLevel: .Error,
		                closure: closure,
		                functionName: functionName,
		                fileName: fileName,
		                lineNumber: lineNumber)
	}
	
	/**
	Writes log with `Severe` level, using `()->NSError?` closure.
	
	- parameter closure: closure, that returns `NSError` or `nil`.
	- parameter functionName: function name. Default value: `#function`.
	- parameter fileName: file name. Default value: `#file`.
	- parameter lineNumber: line number. Default value: `#line`.
	*/
	public func severe(
		@autoclosure closure: () -> NSError?,
		functionName: String = #function,
		fileName: String = #file,
		lineNumber: Int = #line)
	{
		self.logNSError(logLevel: .Severe,
		                closure: closure,
		                functionName: functionName,
		                fileName: fileName,
		                lineNumber: lineNumber)
	}
	
	/**
	Writes log with `Severe` level, using `()->NSError?` closure.
	
	- parameter functionName: function name. Default value: `#function`.
	- parameter fileName: file name. Default value: `#file`.
	- parameter lineNumber: line number. Default value: `#line`.
	- parameter closure: closure, that returns `NSError` or `nil`.
	*/
	public func severe(
		functionName: String = #function,
		fileName: String = #file,
		lineNumber: Int = #line,
		@noescape closure: () -> NSError?)
	{
		self.logNSError(logLevel: .Severe,
		                closure: closure,
		                functionName: functionName,
		                fileName: fileName,
		                lineNumber: lineNumber)
	}
	
	internal func logNSError(
		logLevel logLevel: XCGLogger.LogLevel,
		@noescape closure: () -> NSError?,
		functionName: String,
		fileName: String,
		lineNumber: Int)
	{
		let a = closure()
		let xcgLoggerClosure: () -> String? = {
			return a?.xcgLoggerString
		}
		self.logln(logLevel,
		           functionName: functionName,
		           fileName: fileName,
		           lineNumber: lineNumber,
		           closure: xcgLoggerClosure)
	}
	
}
