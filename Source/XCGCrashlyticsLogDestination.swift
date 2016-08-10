//
//  XCGCrashlyticsLogDestination.swift
//  XCGCrashlyticsLogDestination
//
//  Created by Vitalii Budnik on 8/3/16.
//  Copyright © 2016 Vitalii Budnik. All rights reserved.
//

import Foundation
import XCGLogger
import Crashlytics

/**
Crashlytics log destination for XCGLogger.

- Note: default value for `showDate` is `false`.
*/
public class XCGCrashlyticsLogDestination: XCGBaseLogDestination {
	
	/**
	`dispatch_queue_t` for output to Crashlytics log.
	
	Default value: `nil`.
	*/
	public var logQueue: dispatch_queue_t? = .None
	
	/**
	Extra `dispatch_queue_t` for expensive recording non-fatal errors in Crashlytics.
	
	Default value: `nil`.
	*/
	public var errorLogQueue: dispatch_queue_t? = .None
	
	/**
	Flag to use Crashlytics logger to output to console.
	`true` - let Crashlytics logger to output to console, `false` - otherwise.
	
	Default value: `false`.
	*/
	public var outputToConsole: Bool = false
	
	/**
	Flag to use Crashlytics as non-fatal errors logger for `severe` logs.
	`true` - use Crashlytics as non-fatal errors logger for `severe` logs, `false` - otherwise.
	
	Default value: `false`.
	
	- Note:
	Better to set non-`nil` `errorLogQueue`, if you plan to record non-fatal errors with Crashlytics.
	From Crashlytics documentation:
	- Recording errors in Crashlytics can be expensive. Also, the total number of
	NSErrors that can be recorded during your app's life-cycle is limited by a fixed-size circular
	buffer. If the buffer is overrun, the oldest data is dropped. Errors are relayed to Crashlytics
	on a subsequent launch of your application.
	
	*/
	public var recordSevereLogAsNonFalalErrors: Bool = false
	
	public override init(owner: XCGLogger, identifier: String) {
		super.init(owner: owner, identifier: identifier)
		CrashlyticsHandler.logger = owner
		showDate = false
	}
	
	/**
	Returns `XCGCrashlyticsLogDestination` struct.
	
	- parameter owner:	An instance of `XCGLogger`.
	- parameter identifier:	log destination unique identifier.
	- parameter outputToConsole: Flag to use Crashlytics logger to output to console.
	`true` - let Crashlytics logger to output to console, `false` - otherwise.
	
	- parameter recordSevereLogAsNonFalalErrors:
	Flag to use Crashlytics as non-fatal errors logger for `severe` logs.
	`true` - use Crashlytics as non-fatal errors logger for `severe` logs, `false` - otherwise.
	Default value: `false`.
	
	- parameter errorLogQueue: 
	Extra `dispatch_queue_t` for expensive recording non-fatal errors in Crashlytics.
	Default value: `nil`.
	
	- returns: `XCGCrashlyticsLogDestination` struct.
	*/
	public convenience init( //swiftlint:disable:this valid_docs
		owner: XCGLogger,
		identifier: String,
		outputToConsole: Bool,
		recordSevereLogAsNonFalalErrors: Bool = false,
		errorLogQueue: dispatch_queue_t? = .None)
	{
		self.init(owner: owner, identifier: identifier)
		self.outputToConsole = outputToConsole
		self.recordSevereLogAsNonFalalErrors = recordSevereLogAsNonFalalErrors
		self.errorLogQueue = errorLogQueue
	}
	
	/**
	Outputs passed `logDetails`.
	
	- parameter logDetails: `XCGLogDetails` to output.
	- parameter text: description of passed `logDetails`.
	*/
	public override func output(logDetails: XCGLogDetails, text: String) {
		
		if text.containsString(kLastExecutionErrorPrefix) {
			return
		}
		
		switch logDetails.logLevel {
		case .None:
			return
		default:
			break
		}
		
		let outputToConsole = self.outputToConsole
		
		let outputClosure: () -> Void = {
			
			if outputToConsole {
				CLSNSLogv("%@", getVaList([text]))
			} else {
				CLSLogv("%@", getVaList([text]))
			}
			
		}
		
		if let logQueue = logQueue {
			dispatch_async(logQueue, outputClosure)
		} else {
			outputClosure()
		}
		
		recordError(logDetails, text: text)
		
	}
	
	private func recordError(logDetails: XCGLogDetails, text: String) {
		
		guard
			recordSevereLogAsNonFalalErrors
				&& logDetails.logLevel >= .Severe
				&& logDetails.logLevel != .None
			else {
				return
		}
		
		let logErrorClosure: () -> Void = {
			Crashlytics.sharedInstance()
				.recordError(logDetails.crashlyticsError(),
				             withAdditionalUserInfo: ["text" : text])
		}
		
		if let errorLogQueue = errorLogQueue {
			dispatch_async(errorLogQueue, logErrorClosure)
		} else {
			logErrorClosure()
		}
		
	}
	
}
