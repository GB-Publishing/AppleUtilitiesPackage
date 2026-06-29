import Foundation
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

@_cdecl("_GetTimeZone")
public func GetTimeZone() -> UnsafeMutablePointer<CChar>? {
    return ToPointer(string: TimeZone.current.identifier)
}

@_cdecl("_IOSCanOpenURL")
public func IOSCanOpenUrl(urlString: UnsafePointer<CChar>?) -> Bool {
     let urlString = ToString(pointer: urlString) ?? ""

       guard let url = URL(string: urlString) else {
            print("Invalid URL string")
            return false
        }
        
    #if os(iOS)
    return UIApplication.shared.canOpenURL(url)
    #else
    return NSWorkspace.shared.urlForApplication(toOpen: url) != nil
    #endif
}

public func ToPointer(string: String) -> UnsafeMutablePointer<CChar>? {
    return strdup(string)
}

public func ToString(pointer: UnsafePointer<CChar>?) -> String? {
    guard let pointer = pointer,
          let string = String(validatingCString: pointer)
        else {
            return nil
        }
    
    return string;
}
