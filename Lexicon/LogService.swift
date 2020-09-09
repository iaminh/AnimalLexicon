import Foundation

let log: LogService = {
    
    let logService = LogService.sharedService
    
    logService.logLevel = .debug
    
    return logService
}()


public typealias ExternalLogAction = (_ text: String) -> Void

open class LogService {
    
    public static let sharedService = LogService()
    
    public enum GeneralLogLevel {
        
        case debug
        case production
        case productionWithCrashlogs
    }
    
    
    // We use this because of nice readible syntax :
    //  log.message("Test remote")(.RemoteLogging)
    //  log.message("Text local")
    
    public enum ExternalLogActions {
        
        case remoteLogging
        case none
    }
    
    
    open var crashLogAction:     ExternalLogAction? = nil
    open var messageLogAction:   ExternalLogAction? = nil
    open var errorLogAction:     ExternalLogAction? = nil
    
    open var logLevel : GeneralLogLevel = .debug
    
    
    typealias Message = (String) -> String
    
    fileprivate func detailedMessage(_ file: String = #file, _ function: String = #function, _ line: Int = #line) -> Message {
        
        return { text -> String in
            
            let filename = NSURL(string: file)?.deletingPathExtension?.lastPathComponent
            
            let messageText = "\n===============" + " \(filename).\(function)[\(line)]: \n " + text + "\n==============="
            
            return messageText
        }
    }
    
    
    open func message(_ text: String, _ file: String = #file, _ function: String = #function, _ line: Int = #line) -> ((ExternalLogActions) -> Void)! {
        
        let message = detailedMessage(file, function, line)
        
        
        if logLevel == .debug {
            
            print(message(text))
        }
        
        
        if logLevel == .productionWithCrashlogs {
            
            crashLogAction?(message(text))
        }
        
        
        return { externalLogAction -> Void in
            
            if externalLogAction == .remoteLogging { self.messageLogAction?(message(text)) }
        }
    }
    
    open func printMessage(_ object: AnyObject) {
        if (logLevel == .debug) {
            print(object)
        }
    }
    
    
    open func error(_ text: String, error: NSError?, _ file: String = #file, _ function: String = #function, _ line: Int = #line) -> ((ExternalLogActions) -> Void)! {
        
        let errorText = error?.description ?? "No NSError object"
        
        let messageText = "ERROR! \n Message: \(text) \n Error object: \(errorText)"
        
        message(messageText, file, function, line)
        
        return { externalLogAction -> Void in
            
            if externalLogAction == .remoteLogging { self.errorLogAction?(self.detailedMessage(file, function, line)(messageText)) }
        }
    }
}
