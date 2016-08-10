//
//  NSErrorFomXCGLogDetailsConstructor.swift
//  XCGCrashlyticsLogDestination
//
//  Created by Vitalii Budnik on 8/9/16.
//  Copyright © 2016 Vitalii Budnik. All rights reserved.
//

import XCGLogger

/**
Constructs `NSError` from `XCGLogDetails`
*/
public protocol NSErrorFomXCGLogDetailsConstructor {
	
	/**
	Converts passed `logDetails` to `NSError` object.
	- Parameter logDetails: `XCGLogDetails` to be converted to a new `NSError` object.
	- Returns: `NSError` object, recieved from passed `logDetails`.
	*/
	static func NSErrorUsing(logDetails logDetails: XCGLogDetails) -> NSError
	
}
