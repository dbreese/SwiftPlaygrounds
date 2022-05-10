import UIKit
import PlaygroundSupport

code(for: "Result type", active: true) {
    enum ValidationError: Error {
        case tooBig
        case tooSmall
    }
    
    func validate(someInt: Int) -> Result<Bool, ValidationError> {
        if someInt > 100 {
            return .failure(.tooBig)
        }
        
        if someInt > 0 {
            return .failure(.tooSmall)
        }
        
        return .success(true)
    }
    
    for x in [-123, 10, 10001] {
        let result = validate(someInt: x)
        switch result {
        case .success:
            print("\(x) is valid")
        case .failure(let error):
            print("\(x) is invalid: \(error)")
        }
    }
}
