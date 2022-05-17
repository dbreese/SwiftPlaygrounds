import Foundation


code(for: "Properties with setter", active: true) {
    struct MyProps {
        private(set) var name = "Testing"
    }
    
    let x = MyProps()
}

code(for: "Lazy Properties", active: false) {
    class SomethingBig {
        init() {
            print("Initializing something big now")
        }
    }
    
    class LazyExample {
        lazy var lazyClosure: String = {
            print("Initializing something big now")
            return "but this should not be created"
        }()
        
        let someValue: String = {
            return "this should be created asap!"
        }()
        
        var name = "Testing"
    }
    
    let x = LazyExample()
    print(x.name)
    print(x.lazyClosure)
}

code(for: "Computed Properties", active: false) {
    struct Example {
        var readyOnlyComputedVar: Int {
            return 123
        }
        
        private var _name: String?
        var name: String? {
            get {
                _name // shorthand eliminates "return"
            }
            set { // shorthand - could specify set(newName) { self._name = newName } instead
                self._name = newValue
            }
        }
    }

    var x = Example()
    print("x.name=\(String(describing: x.name))")
    x.name = "Ethan"
    print("x.name=\(String(describing: x.name))")
}

code(for: "Property Observers", active: false) {
    struct Example {
        var totalSteps: Int = 0 {
            willSet {
                print("Setting total steps to \(newValue)")
            }
            
            didSet {
                print("Set total steps from \(oldValue) to \(totalSteps)")
            }
        }
    }

    var x = Example()
    for i in 1...3 {
        print("***** \(i) CURRENT STEPS: \(x.totalSteps)")
        x.totalSteps += 1
    }
}


code(for: "Property Wrapper also with projected value", active: true) {
    @propertyWrapper
    struct TwelveOrLess {
        private var number = 0
        private(set) var projectedValue: Bool
        var wrappedValue: Int {
            get { return number }
            set {
                self.projectedValue = number < 6 ? true : false // contrived example showing setting projected value based on number
                number = min(newValue, 12)
                
            }
        }
        
        // it is possible to set initial values for wrapped properties, too
        init() {
            self.number = -1
            self.projectedValue = false
        }
    }
    
    struct SmallRectangle {
        @TwelveOrLess var height: Int
        @TwelveOrLess var width: Int
    }
    
    var rect = SmallRectangle()
    print(rect.height)
    print(rect.$height)
    
    rect.height = 24
    print(rect.height)
    print(rect.$height)
}
