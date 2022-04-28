import SwiftUI

let hr = "---------------------------"

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

