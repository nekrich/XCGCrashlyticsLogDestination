#XCGCrashlyticsLogDestination

###CocoaPods
Add pre-install hook:

```
pre_install do |installer|
	def installer.verify_no_static_framework_transitive_dependencies; end
end
```
and

```
pod 'XCGCrashlyticsLogDestination'
```

###What inside
####`XCGCrashlyticsLogDestination`
1. Writes your log into [Crashlytics custom logs](https://docs.fabric.io/apple/crashlytics/enhanced-reports.html#custom-logs).

2. Can automatically convert your `.Severe` log to [Crashlytics non-fatal errors](https://docs.fabric.io/apple/crashlytics/logged-errors.html) (if you wish, ofcourse).

####`XCGLogger` extension
1. `error` and `severe` methods supports `NSError`.
2. `nonFatalError` method, that will pass yours `String` or `NSError` to Crashlytics non-fatal errors, without `XCGCrashlyticsLogDestination`.

###Usage
```swift
let log = XCGLoger(...
```
####`XCGCrashlyticsLogDestination`
Send all `severe` logs to Crashlytics as non-fatal erors, and attach log to all errors, if they are occured:

```swift
let crashlyticsDestination = 
XCGCrashlyticsLogDestination(owner: log, 
	identifier: "crashlyticsDestination", 
	outputToConsole: false,
	recordSevereLogAsNonFalalErrors: true)

log.addLogDestination(crashlyticsDestination)
...
log.info("Yours message")
```

######Note: `XCGCrashlyticsLogDestination` object overwrites `Crashlytics.sharedInstance().delegate` on initialization to get crash report for last execution. It's better to have only one instance of `XCGCrashlyticsLogDestination`.

####`XCGLogger` extension
Log an occured `NSError`, and send it to Crashlytics:

```swift
let error: NSError? = ...
log.nonFatalError(error)
``` 
or 

```swift
log.nonFatalError {
	...
	let error: NSError? = ...
	return error
}
```
or log an error `String`, and send it to Crashlytics:

```swift
log.nonFatalError {
	guard !somethingGood else { return nil }
	return "Holy diver!"
}
```
and ofcourse:

```swift
log.error(`NSError`Object)
```
and

```swift
log.severe {
	...
	return `NSError`Object
}
```


###References

You can find more info on XCGLogger/Crashlytics (documentation and setup) here:

[XCGLogger](https://github.com/DaveWoodCom/XCGLogger)

[Crashlytics](https://docs.fabric.io/apple/crashlytics/overview.html)
