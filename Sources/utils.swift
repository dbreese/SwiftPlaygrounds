import SwiftUI

let hr = "---------------------------"

/*
 Utility method to use in playgrounds that add a header and allow a block to be turned off/on more easily for testing and learning.
 */
public func code(for title:String, active:Bool = true, closure: () throws ->()) -> String? {
    guard active else {
        return title // so it shows up in margin
    }
    print("""
\(hr)
Results for: '\(title)'
\(hr)
""")
    if active {
        do {
            try closure()
        } catch {
            print("EXCEPTION: \(error)")
        }
    }
    return title
}

