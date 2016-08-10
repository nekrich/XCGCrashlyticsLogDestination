//
//  XCGLogDetails+CrashlyticsError.swift
//  XCGCrashlyticsLogDestination
//
//  Created by Vitalii Budnik on 8/8/16.
//  Copyright © 2016 Vitalii Budnik. All rights reserved.
//

import XCGLogger

public extension XCGLogDetails {
	
	/**
	Constructor type for creating `NSError` passed to Crashlytics.
	
	Default value: `DefaultNSErrorFomXCGLogDetailsConstructor.self`
	*/
	static var NSErrorConstructorType: NSErrorFomXCGLogDetailsConstructor.Type =
		DefaultNSErrorFomXCGLogDetailsConstructor.self
	
	/**
	Returns `NSError` for Crashlytics, constructed using `XCGLogDetails.NSErrorConstructorType`.
	- Returns: `NSError` for Crashlytics, constructed using `XCGLogDetails.NSErrorConstructorType`.
	*/
	func crashlyticsError() -> NSError {
		
		let error = crashlyticsErrorUsing(constructor: XCGLogDetails.NSErrorConstructorType)
		
		return error
		
	}
	
	/**
	Returns `NSError` for Crashlytics, constructed using passed `constructor`.
	- Parameter constructor: `NSErrorConstructorType` to build an `NSError` object.
	- Returns: `NSError` for Crashlytics, constructed using passed `constructor`.
	*/
	func crashlyticsErrorUsing(
		constructor constructor: NSErrorFomXCGLogDetailsConstructor.Type)
		-> NSError
	{
		
		let error = constructor.NSErrorUsing(logDetails: self)
		
		return error
		
	}
	
}
