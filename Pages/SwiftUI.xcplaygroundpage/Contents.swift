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

code(for: "Text Baseline Alignment", active: false) {
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

code(for: "ActionSheet vs Sheet", active: false) {
    
    struct ContentView: View {
        
        @State var showSheet = false
        @State var showActionSheet = false
        
        let appActionSheet = ActionSheet(title: Text("ActionSheet"), message: Text("I am an ActionSheet"), buttons: [
            .default(Text("some text")),
            .cancel()
        ])
        
        
        var body: some View {
            
            VStack
            {
                
                Button("show sheet") {showSheet.toggle()}.padding()
                
                Button("show actionSheet") {showActionSheet.toggle()}.padding()
                
                
            }.font(Font.title.bold())
                .sheet(isPresented: $showSheet, content: {sheetView()})
                .actionSheet(isPresented: $showActionSheet, content: {appActionSheet})
            
        }
    }
    
    struct sheetView: View {
        var body: some View {
            
            ZStack
            {
                Color.red
                Text("I am sheet view")
            }.ignoresSafeArea()
        }
    }
    PlaygroundPage.current.setLiveView(ContentView())
    
}

code(for: "NavigationView x 2 and Link", active: false) {
    
    struct FinalView: View {
        var body: some View {
            Text("Dustin")
        }
    }
    
    struct DetailView: View {
        @State private var doNavigate2 = false
        var body: some View {
            HStack {
                if doNavigate2 {
                    NavigationLink("lmr view2", destination: FinalView(), isActive: $doNavigate2)
                }
                
                VStack {
                    Text("Secondary View")
                    Button("Push2", action: {
                        print("pressed2")
                        doNavigate2 = true
                    })
                }
            }
        }
    }
    
    struct ContentView: View {
        @State private var doNavigate = false
        
        //        @ViewBuilder
        var body: some View {
            
            NavigationView {
                //                if doNavigate {
                //                    NavigationLink("lmr view1", destination: DetailView(), isActive: $doNavigate)
                //                } else {
                //                    self
                //                }
                
                VStack {
                    Text("Primary View")
                    Button("Push", action: {
                        print("pressed")
                        doNavigate = true
                    })
                }
            }//.navigationViewStyle(.stack)
        }
    }
    PlaygroundPage.current.setLiveView(ContentView())
    
}

code(for: "Simple with action sheet", active: false) {
    struct ContentView: View {
        @State private var actionSheetOpen = false
        @State private var navigationLinkActive = false
        
        var body: some View {
            NavigationView {
                if navigationLinkActive {
                    NavigationLink("", destination: Text("Detail"), isActive: $navigationLinkActive)
                }
                
                Button("Open action sheet") {
                    actionSheetOpen.toggle()
                }
                .actionSheet(isPresented: $actionSheetOpen) {
                    ActionSheet(title: Text("Actions"), message: Text("Choose action"), buttons: [
                        .default(Text("Navigation"), action: {
                            navigationLinkActive = true
                        }),
                        .default(Text("New")),
                        .default(Text("Delete")),
                        .cancel()
                    ])
                }
                
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    PlaygroundPage.current.setLiveView(ContentView())
    
}

code(for: "Show empty view for navigation link", active: false) {
    struct ContentView: View {
        @State private var isShowingDetailView = false
        
        var body: some View {
            NavigationView {
                VStack {
                    NavigationLink(destination: Text("Second View"), isActive: $isShowingDetailView) {
                        // show an empty view so it does not show anything on the screen
                        EmptyView()
                    }
                    Button("Tap to show detail") {
                        self.isShowingDetailView = true
                    }
                }
                .navigationTitle("Navigation")
            }
        }
    }
    
    PlaygroundPage.current.setLiveView(ContentView())
    
}

code(for: "Tabs", active: false) {
    struct ContentView: View {
        @State private var isShowingDetailView = false
        
        var body: some View {
            //            ScrollView {
            TabView {
                
                // Tab 1
                VStack {
                    Text("The top!")
                    Spacer()
                    Text("Tab 1")
                    Spacer()
                    Text("the bottom")
                }
                .frame(maxWidth: .infinity)
                .border(.red, width: 1)
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("First")
                }
                
                // Tab 2
                Text("Tab 2")
                    .badge(10)
                    .border(.red, width: 1)
                
                    .tabItem {
                        Image(systemName: "2.square.fill")
                        Text("Second")
                    }
                
                // Tab 3
                Text("The Last Tab")
                    .border(.red, width: 1)
                
                    .tabItem {
                        Image(systemName: "3.square.fill")
                        Text("Third")
                    }
            }
        }
    }
    PlaygroundPage.current.setLiveView(ContentView())
}

code(for: "Safe areas", active: false) {
    struct ContentView: View {
        var body: some View {
            NavigationView {
                ZStack {
                    LinearGradient(
                        colors: [.red, .yellow],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea(.container, edges: .vertical)
                    .navigationTitle("Hello World")
                }
            }
        }
    }
    
    PlaygroundPage.current.setLiveView(ContentView())
}

code(for: "Badges", active: false) {
    // Only Lists and Tabs support badges
    struct ContentView: View {
        var body: some View {
            List {
                Text("Group 1")
                    .badge(12)
                
                Text("Group 2")
                    .badge(20)
                
                Text("Group 3")
                    .badge(
                        Text("31 \(Image(systemName: "star"))")
                            .foregroundColor(.red)
                            .font(.headline)
                    )
            }
            .border(.red, width: 1)
        }
    }
    
    PlaygroundPage.current.setLiveView(ContentView())
}

code(for: "Sheet View Modal", active: false) {
    struct SheetView: View {
        @Environment(\.dismiss) var dismiss

        var body: some View {
            Button("Press to dismiss") {
                dismiss()
            }
            .font(.title)
            .padding()
            .background(Color.black)
        }
    }

    struct ContentView: View {
        @State private var showingSheet = false

        var body: some View {
            Button("Show Sheet") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                SheetView()
            }
        }
    }
    PlaygroundPage.current.setLiveView(ContentView())
}

code(for: "Zstack examples", active: false) {
    
    struct ContentView: View {
        let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
        
        var body: some View {
            ZStack {
                
                
                Image(systemName: "globe.europe.africa")
                    .font(.system(size: 300, weight: .ultraLight))
                    .zIndex(-100)
                
                Text("~~~~~")
                    .font(.system(size: 50))
                    .offset(x: 30, y: 30)
                    .foregroundColor(.blue)
                    .zIndex(2)
                
                
                Text("Africa")
                    .font(.system(size: 50))
                    .offset(x: 30, y: 30)
                    .foregroundColor(.red)
                    .zIndex(1)
                
            }
            .border(Color.black, width: 1)
        }
    }
    
    PlaygroundPage.current.setLiveView(ContentView())
}

code(for: "Navigation Views with multiple lists", active: false) {
    
    struct SomeOtherView: View {
        var body: some View {
            ZStack {
//                GeometryReader { _ in
//                    EmptyView()
//                }
//                .background(Color.gray.opacity(0.3))
//                .opacity(1.0)//self.isOpen ? 1.0 : 0.0)
//                .animation(.easeIn(duration: 0.25))
//                .onTapGesture {
//                    print("tapped")
//                }
//
                HStack {
                    GeometryReader { geometry in

                    List {
                        NavigationLink(destination: Text("here 3").onAppear(perform: {
                            print("close menu")
                        })
                        ) {
                            Text("Testing 3")
                        }
                        NavigationLink(destination: Text("here 4")) {
                            Text("Testing 4")
                        }
                    }.offset(x: 100, y: 0)
                            
                    }
                }
            }
        }
    }
    
    struct ContentView: View {
        var body: some View {
            NavigationView {
                ZStack {
                    List {
                        NavigationLink(destination: Text("here 1")) {
                            Text("Testing 1")
                        }
                        NavigationLink(destination: Text("here 2")) {
                            Text("Testing 2")
                        }
                    }
                    
                    SomeOtherView()
                        .offset(x: 10, y: 0)
                }
                .navigationBarTitle(Text("SObjects"), displayMode: .inline)
                .toolbar(content: {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button("Open") {
//                            self.openMenu()
                        }
                    }
                })

            }
        }
    }
    
    //    let contentView = getSlideoutMenu(menuContent: AnyView(MenuContent()))
    PlaygroundPage.current.setLiveView(ContentView())
}

code(for: "Animations", active: false) {
    struct ContentView: View {
        @State private var animationAmount = 1.0
        
        var body: some View {
            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
            .animation(.easeInOut(duration: 2), value: animationAmount)
        }
    }
    
    PlaygroundPage.current.setLiveView(ContentView())
}

