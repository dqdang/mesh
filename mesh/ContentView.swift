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
    @State var sizeOfText: CGSize = .zero
    @State var fontSizeOfText: CGFloat = 20.0
    
    init() {
        
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
                                            Rectangle().frame(width: UIScreen.screenWidth - 70, height: UIScreen.screenHeight - 400, alignment: .center)
                                                .foregroundColor(.gray).border(.black, width:1).opacity(0.3)
                                                .overlay(
                                                    Rectangle().frame(width: UIScreen.screenWidth - 90, height: UIScreen.screenHeight - 405, alignment: .center)
                                                        .foregroundColor(.gray)
                                                        .overlay(
                                                            Text("Cryptocurrencies")
                                                                .font(Font.custom(fontRegular, size:17))
                                                                .frame(height: fontSizeOfText, alignment: .center).background(.gray).position(x: UIScreen.screenWidth / 2 - 40, y:-2)
                                                                .overlay(
                                                                    ScrollView(.vertical, showsIndicators: false) {
                                                                        VStack (alignment: .leading) {
                                                                            HStack() {
                                                                                Text("Crypto")
                                                                                    .font(Font.custom(fontBold, size:15))
                                                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                                                Text("$")
                                                                                    .font(Font.custom(fontBold, size:15))
                                                                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                                                            }
                                                                            ForEach(0 ..< cryptoList.count, id: \.self) { i in
                                                                                let crypto = cryptoList[i]
                                                                                let price = pricesList[i]
                                                                                HStack {
                                                                                    Text("\(crypto)")
                                                                                        .font(Font.custom(fontRegular, size:15))
                                                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                                                    Text("\(price)")
                                                                                        .font(Font.custom(fontRegular, size:15))
                                                                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                ))))))
                    HStack(spacing: 90) {
                        let widthOfAboutButton = "About".widthOfString(usingFont: UIFont.systemFont(ofSize: 17, weight: .bold))
                        let widthOfCryptoButton = "Crypto".widthOfString(usingFont: UIFont.systemFont(ofSize: 17, weight: .bold))
                        Button(action: {
                        }) {
                            (
                                Text("C").foregroundColor(Color("FirstLetterColor"))
                                +
                                Text("rypto").foregroundColor(.white)
                            )
                            .font(.system(size: 17).monospaced())
                            .fontWeight(.bold)
                            .padding()
                            .background(Rectangle().fill(Color("ButtonBackground"))
                                .shadow(color: .gray, radius: 2, x: 8, y: 8)
                                .frame(width: widthOfCryptoButton * 2, height: fontSizeOfText + 5)
                                .border(width:1, edges: [.bottom, .trailing], color: .black)
                            )
                        }
                        Button(action: {
                        }) {
                            (
                                Text("A").foregroundColor(Color("FirstLetterColor"))
                                +
                                Text("bout").foregroundColor(.white)
                            )
                            .font(.system(size: 17).monospaced())
                            .fontWeight(.bold)
                            .padding()
                            .background(Rectangle().fill(Color("ButtonBackground"))
                                .shadow(color: .gray, radius: 2, x: 8, y: 8)
                                .frame(width: widthOfAboutButton * 2, height: fontSizeOfText + 5)
                                .border(width:1, edges: [.bottom, .trailing], color: .black)
                            )
                        }
                    }.frame(width: UIScreen.screenWidth - 80, alignment: .top)
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

struct sizeOfView: View {
    @Binding var fontSizeOfText: CGFloat
    @Binding var sizeOfText: CGSize
    
    var body: some View {
        GeometryReader { proxy in
            HStack {}
                .onAppear { sizeOfText = proxy.size }
                .onChange(of: fontSizeOfText) { _ in sizeOfText = proxy.size }
        }
    }
}

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

struct EdgeBorder: Shape {
    
    var width: CGFloat
    var edges: [Edge]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }
            
            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }
            
            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return self.width
                }
            }
            
            var h: CGFloat {
                switch edge {
                case .top, .bottom: return self.width
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}
