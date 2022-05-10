
import SwiftUI
import PlaygroundSupport



code(for: "SlideoutMenu example", active: false) {
    struct MenuView: View {
        var body: some View {
            List {
                NavigationLink(destination: Text("Console!")) {
                    Text("Lightning Console")
                }
                .buttonStyle(.plain)
                //            .isDetailLink(false)
                
                Text("Posts").onTapGesture {
                    print("Posts")
                }
                Text("Logout").onTapGesture {
                    print("Logout")
                }
            }
        }
    }
    struct SliderMenu: View {
        let width: CGFloat
        let isOpen: Bool
        let menuContent: AnyView
        let menuClose: () -> Void
        
        var body: some View {
            ZStack {
                GeometryReader { _ in
                    EmptyView()
                }
                .background(Color.gray.opacity(0.3))
                .opacity(self.isOpen ? 1.0 : 0.0)
                .animation(.easeIn(duration: 0.25))
                .onTapGesture {
                    self.menuClose()
                }
                
                HStack {
                    GeometryReader { geometry in
                        menuContent
                            .frame(width: geometry.size.width * 0.75)
                            .offset(x: self.isOpen ? 0 : -geometry.size.width * 0.75)
                            .animation(.default)
                            .onTapGesture {
                                self.menuClose()
                            }
                    }
                    
                    Spacer()
                }
            }
        }
    }
    
    struct ContentView: View {
        @State private var animationAmount = 1.0
        var menuOpen = true
        
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
                    
                    SliderMenu(width: 270,
                               isOpen: self.menuOpen,
                               menuContent: AnyView(MenuView()),
                               menuClose: self.openMenu
                    )
                }
            }
        }
        
        func openMenu() {
            //        menuOpen.toggle()
        }
    }
    
    //    let contentView = getSlideoutMenu(menuContent: AnyView(MenuContent()))
    PlaygroundPage.current.setLiveView(ContentView())
}



code(for: "SideBar", active: true) {
    
    struct MenuItems: View {
        
        enum MenuCode {
            case home
            case search
            case folder
            case edit
            case delete
        }
        
        var action: (MenuCode) -> Void
        
        var body: some View {
            List {
                Divider()
                
                Button(action: {self.action(.home)}) {
                    Label("Home", systemImage: "house")
                }
                Button(action: {self.action(.search)}) {
                    Label("Search", systemImage: "magnifyingglass")
                }
                Button(action: {self.action(.folder)}) {
                    Label("Folder", systemImage: "folder")
                }
                Button(action: {self.action(.edit)}) {
                    Label("Edit", systemImage: "pencil")
                }
                
                Divider()
                
                Button(action: {self.action(.delete)}) {
                    Label("Delete", systemImage: "trash")
                }
            }
            .listRowSeparator(.hidden)
            .listStyle(SidebarListStyle())
        }
    }
    
    
    struct Sidebar<Content : View> : View {
        var title: LocalizedStringKey
        var content : Content
        
        init(title: LocalizedStringKey, @ViewBuilder content: () -> Content) {
            self.title = title
            self.content = content()
        }
        
        var body: some View {
            NavigationView {
                content
                    .navigationTitle(title)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    struct MainViewWithSidebar <Sidebar, Content> : View where Sidebar : View, Content : View {
        @Binding var presentSidebar: Bool
        var sidebar : Sidebar
        var content : Content
        
        // 1 - using @ViewBuilder again
        init(presentSidebar: Binding<Bool>,
             sidebar: Sidebar,
             @ViewBuilder content: () -> Content)
        {
            self._presentSidebar = presentSidebar
            self.sidebar = sidebar
            self.content = content()
        }
        
        // use animation to change the presentSidebar value; this way
        // the menu will slide closed.
        
        private func toggleSidebar() {
            withAnimation {
                self.presentSidebar.toggle()
            }
        }
        
        var body: some View {
            ZStack(alignment: .leading) {
                // 2 - the main content of the app
                self.content
                    .zIndex(0)
                    .blur(radius: self.presentSidebar ? 6.0 : 0)
                
                // 3 - show or hide the translucent shield
                if presentSidebar {
                    Color.black
                        .zIndex(1)
                        .opacity(0.25)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.toggleSidebar()
                        }
                }
                
                // 4 - show or hide the sidebar itself
                if presentSidebar {
                    self.sidebar
                        .zIndex(2)
                        .frame(width: 300)
                        .transition(.asymmetric(
                            insertion: .move(edge: .leading),
                            removal: .move(edge: .leading))
                        )
                }
            }
        }
    }
    
    
    struct ContentView: View {
        
        // 1 - boolean to track the visibility of the sidebar
        @State var showSidebar = false
        
    
        // 2 - a way to communicate the sidebar menu choice to the MainView
        @State var selectedMenuItem = MenuItems.MenuCode.home

        func toggleSidebar() {
            withAnimation {
                self.showSidebar.toggle()
            }
        }
        // 3 - a tidy way to present the sidebar
        private var sidebarView: some View {
            Sidebar(title: "Main Menu") {
              MenuItems() { itemNumber in
                self.selectedMenuItem = itemNumber
                self.toggleSidebar()
              }
            }
        }

        var body: some View {
          // 4 - the container
          MainViewWithSidebar(presentSidebar: self.$showSidebar, sidebar: self.sidebarView) {
            NavigationView {
              MainView(menuCode: self.selectedMenuItem)
                // 5 - using .toolbar to add some controls
                  .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                      Button(action: {self.toggleSidebar()}) {
                        Label("Menu", systemImage: "sidebar.left")
                      }
                    }
                  }
            }
          }
        }
    }
    

    PlaygroundPage.current.setLiveView(ContentView())
    
}
