import Foundation

code(for: "Closure testing", active: false) {
    // simple closure
    let sayHelloClosure = { print("hello!") }
    sayHelloClosure()
    
    // with declared type (same as above)
    let sayHelloClosure2: () -> () = { print("hello!") }
    sayHelloClosure2()
    
    // with param specified inside
    let c1 = { (name:String) in
        print("Hello \(name)")
    }
    c1("Dustin")
    
    // with param specified in declaration
    let c2: (String) -> () = { name in
        print("Hello \(name)")
    }
    c2("Dustin")
    
    let sumIt = { (a:Int, b:Int) -> Int in
        a+b
    }
    let sumIt2 = { (a:Int, b:Int) in
        a+b
    }
    
    print("Sum=\(sumIt(33,44))")
    print("Sum=\(sumIt2(33,44))")
}

code(for: "Examples showing closures for funcs", active: false) {
    func sayHello(to name: String, finallySayIt: (String) -> ()) {
        let newName = name.uppercased()
        finallySayIt(newName)
    }
    
    // option 1
    sayHello(to: "Dustin1", finallySayIt: { name in
        print("Hello \(name)")
    })
    
    // option 2 - "trailing closure"
    sayHello(to: "dustin2") { name in
        print("Hello \(name)")
    }
    
    // option 3
    let reallySayIt: (String) -> () = { name in
        print("Hello \(name)")
    }
    sayHello(to: "dustin3", finallySayIt: reallySayIt)
}

code(for: "Escaping Trailing Closure", active: false) {
    func sayHello(to name: String, finallySayIt: @escaping (String) -> ()) {
        let newName = name.uppercased()
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            finallySayIt(newName)
        }
    }
    
    // option 1
    sayHello(to: "Dustin1", finallySayIt: { name in
        print("Hello \(name)")
    })
}

code(for: "Function returning a closure", active: false) {
    func sayIt() -> (String) -> Void {
        return { name in
            print("Hello \(name)")
        }
    }
    
    let c = sayIt()
    c("dustin4")
}

code(for: "Closure capturing values", active: true) {
        // closure that captures a value
    var count = 1

    func counter() -> () -> Void {
        //var count = 1

        return {
            // count is captured by this closure.
            print("The count is \(count)")
            count += 1
        }
    }
    
    let gameCounter = counter()
    gameCounter()
    gameCounter()
    
    let gameCounter2 = counter()
    gameCounter2()
    gameCounter2()
}
