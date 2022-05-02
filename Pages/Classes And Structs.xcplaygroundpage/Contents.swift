import Foundation

// TODO: associatedtype

protocol Counter {
    var count: Int { get set }
}

code(for: "Structs pass by reference", active: false) {
    struct DogCounter: Counter {
        var count: Int
    }
    
    let valueFunction = { (counter: Counter) -> Void in
        //                counter.count += 1 // can't do it -- counter is a let constant
    }
    
    let mutatingFunction = { (counter: inout Counter) -> Void in
        counter.count += 1
    }
    
    var dc: Counter = DogCounter(count:0)
    valueFunction(dc)
    mutatingFunction(&dc) // must be a var
    mutatingFunction(&dc) // must be a var
    mutatingFunction(&dc) // must be a var
    print("counter = \(dc)")
}


// from https://www.youtube.com/watch?v=DvHkeUxiwYY
protocol Fighter: Equatable { }
code(for: "Structs referencing Self", active: true) {
    struct XWing: Fighter { }
    struct YWing: Fighter { }

    func launchFighter() -> some Fighter {
        Int.random(in: 0...1) == 0 ? XWing(): XWing()
    }
    
    let fighter1 = launchFighter()
    let fighter2 = launchFighter()
    
    // ERR: == can't be applied to Fighter operands
    //    if (red5_1 == red5_2) {}
//    fighter1 == fighter2
    
    
}


