//
//  ContentView.swift
//  mesh
//
//  Created by Derek Dang on 8/7/22.
//

import Combine
import CoreData
import Foundation
import SwiftUI

struct ContentView: View {
    let fontRegular = "JetBrainsMonoNL-Regular"
    let fontBold = "JetBrainsMono-Bold"
    @State var sizeOfText: CGSize = .zero
    @State var fontSizeOfText: CGFloat = 20.0
    @State private var cryptoPressed = true
    @State private var aboutPressed = false
    @ObservedObject var cryptocurrencies = CryptoMarketTicker()
    
    init() {
        
    }
    
    var body: some View {
        Color("Background").ignoresSafeArea(.all)
            .overlay(
                VStack {
                    Image("logo").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.screenWidth - 30, alignment: .center)
                        .shadow(color: .black, radius: 2, x: 4, y: 4)
                    Rectangle()
                        .frame(width: UIScreen.screenWidth - 30, height: UIScreen.screenHeight - 350, alignment: .center)
                        .foregroundColor(Color("FrameBackground"))
                        .border(Color("FrameBackground"), width:6)
                        .shadow(color: .black, radius: 1, x: 5, y: 5)
                        .overlay(
                            Rectangle().frame(width: UIScreen.screenWidth - 31, height: UIScreen.screenHeight - 350, alignment: .center)
                                .foregroundColor(.white).border(Color("FrameBackground"), width:3)
//                                .shadow(color: .white, radius: 3, x: 1, y: 1)
                                .overlay(
                                    Rectangle().frame(width: UIScreen.screenWidth - 70, height: UIScreen.screenHeight - 400, alignment: .center)
                                        .foregroundColor(.white).border(.black, width:1).opacity(0.3)
                                        .shadow(color: .gray, radius: 2, x: 4, y: 4)
                                        .overlay(
                                            Rectangle().frame(width: UIScreen.screenWidth - 90, height: UIScreen.screenHeight - 405, alignment: .center)
                                                .foregroundColor(.white)
                                                .overlay(
                                                    Text("Cryptocurrencies")
                                                        .font(Font.custom(fontRegular, size:17))
                                                        .frame(height: fontSizeOfText, alignment: .center).background(.white).position(x: UIScreen.screenWidth / 2 - 40, y:-2)
                                                        .overlay(
                                                            ScrollView(.vertical, showsIndicators: false) {
                                                                //                                                                RefreshableView()
                                                                VStack (alignment: .leading) {
                                                                    HStack() {
                                                                        Text("Crypto")
                                                                            .font(Font.custom(fontBold, size:15))
                                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                                        Text("USD")
                                                                            .font(Font.custom(fontBold, size:15))
                                                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                                                    }
                                                                    let cryptoArray = cryptocurrencies.cryptocurrencies
                                                                    
                                                                    ForEach(0 ..< cryptoArray.count, id: \.self) { i in
                                                                        let crypto = cryptoArray[i][0]
                                                                        let price = cryptoArray[i][1]
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
                                                            //                                                                .refreshable {
                                                            //                                                                cryptocurrencies.refresh()
                                                            //                                                            }
                                                        )))))
                    HStack(spacing: 90) {
                        let widthOfAboutButton = "About".widthOfString(usingFont: UIFont.systemFont(ofSize: 17, weight: .bold))
                        let widthOfCryptoButton = "Crypto".widthOfString(usingFont: UIFont.systemFont(ofSize: 17, weight: .bold))
                        Button(action: {
                            self.cryptoPressed = true
                            self.aboutPressed = false
                            self.cryptocurrencies.refresh()
                        }) {
                            (
                                Text("C").foregroundColor(Color("FirstLetterColor"))
                                +
                                Text("rypto").foregroundColor(.white)
                            )
                            .font(.system(size: 17).monospaced())
                            .fontWeight(.bold)
                            .padding()
                            .background(cryptoPressed ?
                                        Rectangle().fill(Color("ButtonBackgroundPressed"))
                                .shadow(color: .gray, radius: 0, x: 0, y: 0)
                                .frame(width: widthOfCryptoButton * 2, height: fontSizeOfText + 5)
                                .border(width:1, edges: [.top, .bottom, .leading, .trailing], color: .black)
                                        : Rectangle().fill(Color("ButtonBackground"))
                                .shadow(color: .gray, radius: 2, x: 4, y: 4)
                                .frame(width: widthOfCryptoButton * 2, height: fontSizeOfText + 5)
                                .border(width:1, edges: [.bottom, .trailing], color: .black)
                            )
                        }
                        Button(action: {
                            self.aboutPressed = true
                            self.cryptoPressed = false
                        }) {
                            (
                                Text("A").foregroundColor(Color("FirstLetterColor"))
                                +
                                Text("bout").foregroundColor(.white)
                            )
                            .font(.system(size: 17).monospaced())
                            .fontWeight(.bold)
                            .padding()
                            .background(aboutPressed ?
                                        Rectangle().fill(Color("ButtonBackgroundPressed"))
                                .shadow(color: .gray, radius: 0, x: 0, y: 0)
                                .frame(width: widthOfAboutButton * 2, height: fontSizeOfText + 5)
                                .border(width:1, edges: [.top, .bottom, .leading, .trailing], color: .black)
                                        : Rectangle().fill(Color("ButtonBackground"))
                                .shadow(color: .gray, radius: 2, x: 4, y: 4)
                                .frame(width: widthOfAboutButton * 2, height: fontSizeOfText + 5)
                                .border(width:1, edges: [.bottom, .trailing], color: .black)
                            )
                        }
                    }.frame(width: UIScreen.screenWidth - 80, alignment: .top)
                }
            ).statusBar(hidden: true)
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

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var name: String
    var price: String
}


class CryptoMarketTicker: ObservableObject {
    @Published var dataIsLoaded: Bool = false
    @Published var cryptocurrencies: [[String]] = []
    private var mapOfCrypto : [String: String] = [:]
    private var orderBasedOnMarketCap : [String] = []
    private var poolOfExistingCrypto : Set<String> = []
    private let url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false"
    
    init() {
        loadJson(url)
    }
    
    func refresh() {
        self.loadJson(url)
    }
    
    func loadJson(_ urlString: String) {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard error == nil else {
                print ("Error: \(error!)")
                return
            }
            
            guard let content = data else {
                print("No data")
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: content, options: []) else { return }
            let jsonobj = json as! [[String:Any]]
            DispatchQueue.main.async {
                for i in 0..<jsonobj.count {
                    let cryptoName = String(describing: jsonobj[i]["name"]!)
                    let longPrice = String(describing: jsonobj[i]["current_price"]!)
                    var currentPrice = longPrice
                    if longPrice.count > 15 {
                        let index = longPrice.index(longPrice.startIndex, offsetBy: 15)
                        currentPrice = String(describing: longPrice[..<index])
                    }
                    if (cryptoName != "" && currentPrice != "") {
                        if !self.poolOfExistingCrypto.contains(cryptoName) {
                            self.orderBasedOnMarketCap.append(cryptoName)
                            self.poolOfExistingCrypto.insert(cryptoName)
                        }
                        self.mapOfCrypto[cryptoName] = currentPrice
                    }
                }
                
                self.cryptocurrencies.removeAll()
                for i in 0..<self.orderBasedOnMarketCap.count {
                    let name = self.orderBasedOnMarketCap[i]
                    let price = self.mapOfCrypto[self.orderBasedOnMarketCap[i]]!
                    self.cryptocurrencies.append([name, price])
                }
                self.dataIsLoaded = true
            }
        }
        task.resume()
    }
}

struct RefreshableView: View {
    @Environment(\.refresh) private var refresh
    
    @State private var isRefreshing = false
    
    var body: some View {
        VStack {
            if isRefreshing {
                ProgressView()
                    .transition(.scale)
            }
        }
        .animation(.default, value: isRefreshing)
        .background(GeometryReader {
            // detect Pull-to-refresh
            Color.clear.preference(key: ViewOffsetKey.self, value: -$0.frame(in: .global).origin.y)
        })
        .onPreferenceChange(ViewOffsetKey.self) {
            if $0 < -80 && !isRefreshing {
                isRefreshing = true
                Task {
                    await refresh?()
                    await MainActor.run {
                        isRefreshing = false
                    }
                }
            }
        }
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
