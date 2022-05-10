//import SwiftUI
//
//struct SliderMenu: View {
//    let width: CGFloat
//    let isOpen: Bool
//    let menuContent: AnyView
//    let menuClose: () -> Void
//
//    var body: some View {
//        ZStack {
//            GeometryReader { _ in
//                EmptyView()
//            }
//            .background(Color.gray.opacity(0.3))
//            .opacity(self.isOpen ? 1.0 : 0.0)
//            .animation(.easeIn(duration: 0.25))
//            .onTapGesture {
//                self.menuClose()
//            }
//            
//            HStack {
//                GeometryReader { geometry in
//                    menuContent
//                        .frame(width: geometry.size.width * 0.75)
//                        .offset(x: self.isOpen ? 0 : -geometry.size.width * 0.75)
//                        .animation(.default)
//                        .onTapGesture {
//                            self.menuClose()
//                        }
//                }
//                
//                Spacer()
//            }
//        }
//    }
//}
//
//
//struct ContentView: View {
//    @State var menuOpen: Bool = false
//    var menuContent: AnyView
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                if !self.menuOpen {
//                    Button(action: {
//                        self.openMenu()
//                    }, label: {
//                        VStack {
//                            Text("Open")
//                            Spacer()
//                        }
//                    })
//                }
//                
//                SliderMenu(width: 270,
//                         isOpen: self.menuOpen,
//                         menuClose: self.openMenu,
//                         menuContent: menuContent)
//            }
//        }
//    }
//    
//    func openMenu() {
//        self.menuOpen.toggle()
//    }
//}
//
//
//public func getSlideoutMenu(menuContent: AnyView) -> some View {
//    return ContentView(menuContent: menuContent)
//}
