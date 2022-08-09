//
//  ContentView.swift
//  mesh
//
//  Created by Derek Dang on 8/7/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color("Background"))

    }
    let cryptoList = ["Bitcoin", "Ethereum", "Tether", "USD Coin", "BNB"]
    var body: some View {
        Color("Background").ignoresSafeArea(.all)
        .overlay(
            VStack {
                Image("logo").resizable()
                    .aspectRatio(contentMode: .fit)
            Rectangle()
            .frame(width: UIScreen.screenWidth - 7, height: UIScreen.screenHeight - 320, alignment: .center)
            .foregroundColor(.gray)
            .overlay(
                Rectangle()
                .frame(width: UIScreen.screenWidth - 15, height: UIScreen.screenHeight - 330, alignment: .center)
                .foregroundColor(.gray)
                .border(.white, width:6)
                .overlay(
                    Rectangle().frame(width: UIScreen.screenWidth - 31, height: UIScreen.screenHeight - 350, alignment: .center)
                    .foregroundColor(.gray).border(.white, width:6)
                    .overlay(
                        Rectangle().frame(width: UIScreen.screenWidth - 50, height: UIScreen.screenHeight - 380, alignment: .center)
                        .foregroundColor(.gray)
                        .overlay(
                        ScrollView {
                            VStack (alignment: .leading) {
                                Text("Cryptocurrencies")
                                    .font(Font.custom("JetBrainsMono-Bold", size:20))
                                    .frame(width: UIScreen.screenWidth - 77, alignment: .topLeading)
                                ForEach(0 ..< cryptoList.count, id: \.self) {
                                    Text(self.cryptoList[$0])
                                        .font(Font.custom("JetBrainsMonoNL-Regular", size:15))
                                        .frame(width: UIScreen.screenWidth - 77, alignment: .topLeading)
                                }
                            }
                        }
                ))))
                TabView() {
                    Text("").font(Font.custom("JetBrainsMonoNL-Regular", size: 10)).tabItem {
                        Text("Crypto").font(Font.custom("JetBrainsMonoNL-Regular", size: 25))
                    }
                    Text("").font(Font.custom("JetBrainsMonoNL-Regular", size: 10)).tabItem {
                        Text("Stocks").font(Font.custom("JetBrainsMonoNL-Regular", size: 25))
                    }
                    Text("").font(Font.custom("JetBrainsMonoNL-Regular", size: 10)).tabItem {
                        Text("About").font(Font.custom("JetBrainsMonoNL-Regular", size: 25))
                    }
                }.frame(width: UIScreen.screenWidth, height:40, alignment: .bottom)
                    .accentColor(Color("Selected"))
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
