//
//  ContentView.swift
//  mesh
//
//  Created by Derek Dang on 8/7/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let fontRegular = "JetBrainsMonoNL-Regular"
    let fontBold = "JetBrainsMono-Bold"
    let cryptoList = ["Bitcoin", "Ethereum", "Tether", "USD Coin", "BNB", "XRP", "Cardano", "Binance USD", "Solana", "Polkadot", "Dogecoin", "Avalanche", "Dai", "Polygon", "Shiba Inu", "Uniswap", "TRON", "Wrapped Bitcoin", "Ethereum Classic", "UNUS SED LEO", "Litecoin", "FTX Token", "NEAR Protocol", "Chainlink", "Cronos", "Cosmos", "Stellar", "Flow", "Monero", "Bitcoin Cash", "Algorand"]
    let pricesList = ["23,797.81", "1,772.39", "1.00", "0.99", "324.27", "0.37", "0.53", "1.00", "42.42", "9.152", "0.07305", "28.38", "0.9994", "0.9232", "0.000001", "8.741", "0.0707", "23,853.45", "37.78", "4.778", "62.45", "31.44", "5.407", "8.596", "0.1520", "11.75", "0.1271", "3.022", "167.11", "143.24", "0.3659"]

    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color("Background"))
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.init(name: fontRegular, size: 20)! ], for: .normal)

    }

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
                            ScrollView(.vertical, showsIndicators: false) {
                            VStack (alignment: .leading) {
                                let whiteSpaces = whiteSpaceGenerator(left: "Cryptocurrencies", right: "$", border: 26)
                                Text("Cryptocurrencies \(whiteSpaces) $")
                                    .font(Font.custom(fontBold, size:20))
                                    .frame(width: UIScreen.screenWidth - 77, alignment: .topLeading)
                                ForEach(0 ..< cryptoList.count, id: \.self) {
                                    let whiteSpaces = whiteSpaceGenerator(left: cryptoList[$0], right: pricesList[$0], border: 36)
                                    Text("\(cryptoList[$0]) \(whiteSpaces) \(pricesList[$0])")
                                        .font(Font.custom(fontRegular, size:15))
                                        .frame(width: UIScreen.screenWidth - 77, alignment: .topLeading)
                                }
                            }
                        }
                ))))
                TabView() {
                    Text("").tabItem {
                        Text("Crypto")
                    }
                    Text("").tabItem {
                        Text("Stocks")
                    }
                    Text("").tabItem {
                        Text("About")
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

func whiteSpaceGenerator(left: String, right: String, border: Int) -> String {
    let leftStrLen = left.count
    let righttStrLen = right.count
    let numWhiteSpaces = border - leftStrLen - righttStrLen
    var whiteSpaces = ""
    for _ in 0...numWhiteSpaces {
        whiteSpaces += " "
    }
    return whiteSpaces
}
