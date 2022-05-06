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

code(for: "Slideout Menu", active: true) {
    struct MenuContent: View {
        var body: some View {
            List {
                Text("My Profile").onTapGesture {
                    print("My Profile")
                }
                Text("Posts").onTapGesture {
                    print("Posts")
                }
                Text("Logout").onTapGesture {
                    print("Logout")
                }
            }
        }
    }
    
    struct SideMenu: View {
        let width: CGFloat
        let isOpen: Bool
        let menuClose: () -> Void
        
        var body: some View {
            NavigationView {
                ZStack {
                    GeometryReader { _ in
                        EmptyView()
                    }
                    .background(Color.gray.opacity(0.3))
                    .opacity(self.isOpen ? 1.0 : 0.0)
                    .animation(Animation.easeIn.delay(0.25))
                    .onTapGesture {
                        self.menuClose()
                    }
                    
                    HStack {
                        MenuContent()
                            .frame(width: self.width)
                            .background(Color.red)
                            .offset(x: self.isOpen ? 0 : -self.width)
                            .animation(.default)
                        
                        Spacer()
                    }
                }
            }
        }
    }
    
    struct ContentView: View {
        @State var menuOpen: Bool = false
        
        var body: some View {
            ZStack {
                if !self.menuOpen {
                    Button(action: {
                        self.openMenu()
                    }, label: {
                        Text("Open")
                    })
                }
                
                SideMenu(width: 270,
                         isOpen: self.menuOpen,
                         menuClose: self.openMenu)
            }
        }
        
        func openMenu() {
            self.menuOpen.toggle()
        }
    }
    
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
