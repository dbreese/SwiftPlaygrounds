import UIKit
import PlaygroundSupport

code(for: "Result type", active: false) {
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

code(for: "Enum - simple", active: false) {
    enum CompassPoint {
        case north
        case south
        case east
        case west
    }

    var directionToHead: CompassPoint
    directionToHead = .south
    directionToHead = .north
    switch directionToHead {
    case .north:
        print("Lots of planets have a north")
    case .south:
        print("Watch out for penguins")
    case .east:
        print("Where the sun rises")
    case .west:
        print("Where the skies are blue")
    }
}

code(for: "Enum - CaseIterable", active: false) {
    enum Planet: CaseIterable {
        case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
    }
    
    print("There are \(Planet.allCases.count) planets:")
    for planet in Planet.allCases {
        print("\t\(planet)")
    }
}

code(for: "Enum - Typed raw value", active: true) {
    enum NamedPlanets: String, CaseIterable {
        case mercury = "Mercury"
        case venus = "Venus"
        case earth = "Earth"
        case mars = "Mars"
    }
    
    print("my planet: \(NamedPlanets.earth.rawValue)")

}
