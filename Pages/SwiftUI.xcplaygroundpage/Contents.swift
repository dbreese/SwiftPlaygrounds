import SwiftUI
import PlaygroundSupport

//PlaygroundPage.current.needsIndefiniteExecution = true

code(for: "Text Baseline Alignment", active: false) {
    struct ContentView: View {
        var body: some View {
            HStack(alignment: .lastTextBaseline) {
                Text("Live")
                    .font(.caption)
                Text("long")
                Text("and")
                    .font(.title)
                Text("prosper")
                    .font(.largeTitle)
            }        }
    }

    PlaygroundPage.current.setLiveView(ContentView())
}

code(for: "Text Baseline Alignment", active: true) {
    struct ContentView: View {
        var body: some View {
            VStack(alignment: .leading) {
                Text("Hello, world!")        .alignmentGuide(.leading) { d in d[.trailing] }

                Text("This is a longer line of text")
            }
            .background(.red)
            .frame(width: 400, height: 400)
            .background(.blue)
        }
    }
    PlaygroundPage.current.setLiveView(ContentView())
}

