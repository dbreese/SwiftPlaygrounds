import SwiftUI
import PlaygroundSupport

// https://www.hackingwithswift.com/quick-start/swiftui/all-swiftui-property-wrappers-explained-and-compared

code(for: "State example", active: false) {
    
    struct ContentView: View {
        // State is local to just this view.
        // It is not propogated to other views.
        // Changing its value just repaints this view.
        @State var counter: Int = 0
        
        var body: some View {
            VStack {
                Text("Counter: \(counter)")
                Spacer()
                Button {
                    counter += 1
                } label: {
                    Text("Increment Counter")
                }
                
            }
        }
    }
    
    PlaygroundPage.current.setLiveView(ContentView())
}


code(for: "Observed Object", active: false) {
    // Demonstrates how to create a custom observable with published properties.
    class Person: ObservableObject {
        @Published var name: String = ""
        @Published var age: Int = 0
        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
    }
    
    struct ContentView: View {
        @ObservedObject var person: Person
        
        var body: some View {
            VStack {
                HStack {
                    Text("Name: \(person.name)")
                    Spacer()
                    Text("\(person.age) years old")
                }
                Spacer()
                Button {
                    person.age += 1
                } label: {
                    Text("Celebrate Birthday")
                }
                
            }
        }
    }
    
    PlaygroundPage.current.setLiveView(
        ContentView(
            person: Person(name: "Dustin", age: 21)))
}

code(for: "StateObject", active: false) {
    // Demonstrates how to create a custom observable with published properties.
    class Person: ObservableObject {
        @Published var name: String = ""
        @Published var age: Int = 0
        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
    }
    
    // This is a contrived example to show who owns and manages the observable
    struct PersonView: View {
        @ObservedObject var person: Person
        var body: some View {
            HStack {
                Text("Name: \(person.name)")
                Spacer()
                Text("\(person.age) years old")
            }
        }
    }
    
    struct BirthdayView: View {
        @ObservedObject var person: Person
        
        var body: some View {
            Button {
                person.age += 1
            } label: {
                Text("Celebrate Birthday")
            }
        }
    }
    
    struct ContentView: View {
        // We are saying that ContentView owns and manages Person
        @StateObject var person: Person
        
        var body: some View {
            VStack {
                PersonView(person: person)
                Spacer()
                BirthdayView(person: person)
            }
        }
    }
    
    PlaygroundPage.current.setLiveView(
        ContentView(
            person: Person(name: "Dustin", age: 21)))
}

code(for: "Environment Object", active: true) {
    class Person: ObservableObject {
        @Published var name: String = ""
        @Published var age: Int = 0
        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
    }
    
    struct ContentView: View {
        @EnvironmentObject var person: Person
        var body: some View {
            Text("Hello, \(person.name)")
        }
    }
    
    PlaygroundPage.current.setLiveView(
        ContentView()
            .environmentObject(Person(name: "Ben", age: 16))
        // Not sure if this is valid -- It seems to run ok, but only shows the first object added of type Person.
            .environmentObject(Person(name: "Ethan", age: 19))
    )
}
