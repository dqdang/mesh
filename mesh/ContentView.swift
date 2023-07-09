//
//  ContentView.swift
//  mesh
//
//  Created by Derek Dang on 8/7/22.
//

import Charts
import Combine
import CoreData
import Foundation
import Model3DView
import SwiftUI
import Vision

struct ContentView: View {
    private let fontRegular = "JetBrainsMonoNL-Regular"
    private let fontBold = "JetBrainsMono-Bold"
    @State private var sizeOfText: CGSize = .zero
    @State private var fontSizeOfText: CGFloat = 20.0
    @State private var goPressed = false
    @State private var cryptoPressed = true
    @State private var aboutPressed = false
    @State private var drawingActivated = false
    @State private var showDrawingResult = false
    @State private var drawingResult = ""

    @ObservedObject private var cryptocurrencies = CryptoMarketTicker()

    @State private var currentDrawing: Drawing = Drawing()
    @State private var drawings: [Drawing] = [Drawing]()
    @State private var rect1: CGRect = .zero
    @State var camera = PerspectiveCamera()
    @State private var degrees = 271.1


    init() {
    }
    
    func handleDrawing(drawing: String) {
        self.drawings.removeAll()
        if drawing == "cat" || drawing == "cut" || drawing  == "(at" {
            self.drawingResult = "https://twitter.com/thurstonwaffles/status/1138952578832707585"
        }
        else if drawing == "dog" || drawing == "dug" || drawing == "dag" {
            self.drawingResult = "https://twitter.com/DailyDogs247/status/994369976936095744"
        }
        else {
            self.drawingResult = "https://letmegooglethat.com/?q=" + drawing
            print(drawing)
        }
        self.drawingActivated = false
        self.showDrawingResult = true
    }

    var body: some View {
        if self.cryptoPressed {
            Color("Background").ignoresSafeArea(.all)
                .overlay(
                    VStack {
                        Image("logo").resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenWidth - 30, alignment: .center)
                            .shadow(color: .black, radius: 2, x: 4, y: 4)
                            .onLongPressGesture {
                                self.drawingActivated = false
                                self.showDrawingResult = false
                            }
                        Rectangle()
                            .frame(width: UIScreen.screenWidth - 30, height: UIScreen.screenHeight - 350, alignment: .center)
                            .foregroundColor(Color("FrameBackground"))
                            .border(Color("FrameBackground"), width:6)
                            .shadow(color: .black, radius: 1, x: 5, y: 5)
                            .overlay(
                                Rectangle().frame(width: UIScreen.screenWidth - 31, height: UIScreen.screenHeight - 350, alignment: .center)
                                    .foregroundColor(.white).border(Color("FrameBackground"), width:3)
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
                                                            .frame(height: fontSizeOfText, alignment: .center).background(.white).position(x: UIScreen.screenWidth / 2 - 42, y:-2)
                                                            .overlay(
                                                                ScrollView(.vertical, showsIndicators: false) {
                                                                    RefreshableView(cryptocurrencies:cryptocurrencies)
                                                                }.refreshable {
                                                                    await cryptocurrencies.refresh()
                                                                }
                                                            )))))
                        HStack(spacing: 90) {
                            let widthOfAboutButton = "About".widthOfString(usingFont: UIFont.systemFont(ofSize: 17, weight: .bold))
                            let widthOfCryptoButton = "Crypto".widthOfString(usingFont: UIFont.systemFont(ofSize: 17, weight: .bold))
                            Button(action: {
                                self.cryptoPressed = true
                                self.aboutPressed = false
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
                                if self.showDrawingResult == true {
                                    self.drawingActivated = true
                                    self.showDrawingResult = false
                                }
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
        else {
            Color("Background").ignoresSafeArea(.all)
                .overlay(
                    VStack {
                        Image("logo").resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenWidth - 30, alignment: .center)
                            .shadow(color: .black, radius: 2, x: 4, y: 4)
                            .onLongPressGesture {
                                self.drawingActivated = false
                                self.showDrawingResult = false
                            }
                        Rectangle()
                            .frame(width: UIScreen.screenWidth - 30, height: UIScreen.screenHeight - 350, alignment: .center)
                            .foregroundColor(Color("FrameBackground"))
                            .border(Color("FrameBackground"), width:6)
                            .shadow(color: .black, radius: 1, x: 5, y: 5)
                            .overlay(
                                Rectangle().frame(width: UIScreen.screenWidth - 31, height: UIScreen.screenHeight - 350, alignment: .center)
                                    .foregroundColor(.white).border(Color("FrameBackground"), width:3)
                                    .overlay(
                                        Rectangle().frame(width: UIScreen.screenWidth - 70, height: UIScreen.screenHeight - 400, alignment: .center)
                                            .foregroundColor(.white).border(.black, width:1).opacity(0.3)
                                            .shadow(color: .gray, radius: 2, x: 4, y: 4)
                                            .overlay(
                                                Rectangle().frame(width: UIScreen.screenWidth - 90, height: UIScreen.screenHeight - 405, alignment: .center)
                                                    .foregroundColor(.white)
                                                    .overlay(
                                                        Text("About")
                                                            .font(Font.custom(fontRegular, size:17))
                                                            .frame(height: fontSizeOfText, alignment: .center).background(.white).position(x: UIScreen.screenWidth / 2 - 45, y:-2)
                                                            .overlay(
                                                                VStack {
                                                                    if self.drawingActivated {
                                                                        Spacer()
                                                                        DrawingPad(currentDrawing: $currentDrawing, drawings: $drawings).background(RectGetter(rect: $rect1))
                                                                        
                                                                        let widthOfGoButton = "Go".widthOfString(usingFont: UIFont.systemFont(ofSize: 17, weight: .bold))
                                                                        Button(action: {
                                                                            self.goPressed = !self.goPressed
                                                                            if self.goPressed == true {
                                                                                let keyWindow = UIApplication.shared.connectedScenes
                                                                                    .filter({$0.activationState == .foregroundActive})
                                                                                    .compactMap({$0 as? UIWindowScene})
                                                                                    .first?.windows
                                                                                    .filter({$0.isKeyWindow}).first
                                                                                let uiimage = keyWindow?.asImage(rect: self.rect1)
                                                                                guard let cgImage = uiimage?.cgImage else { return }
                                                                                let requestHandler = VNImageRequestHandler(cgImage: cgImage)
                                                                                let recognizeTextRequest = VNRecognizeTextRequest { (request, error) in
                                                                                    guard let observations = request.results as? [VNRecognizedTextObservation] else {
                                                                                        return
                                                                                    }
                                                                                    let recognizedStrings = observations.compactMap { observation in
                                                                                        observation.topCandidates(1).first?.string
                                                                                    }
                                                                                    DispatchQueue.main.async {
                                                                                        if recognizedStrings.count > 0 {
                                                                                            self.handleDrawing(drawing: recognizedStrings[0].lowercased())
                                                                                        }
                                                                                        else {
                                                                                            self.goPressed = false
                                                                                        }
                                                                                    }
                                                                                }
                                                                                recognizeTextRequest.recognitionLevel = .accurate
                                                                                
                                                                                DispatchQueue.global(qos: .userInitiated).async {
                                                                                    do {
                                                                                        try requestHandler.perform([recognizeTextRequest])
                                                                                    } catch {
                                                                                        print(error)
                                                                                    }
                                                                                }
                                                                                
                                                                            }}) {
                                                                                (
                                                                                    Text("G").foregroundColor(Color("FirstLetterColor"))
                                                                                    +
                                                                                    Text("o").foregroundColor(.white)
                                                                                )
                                                                                .font(.system(size: 17).monospaced())
                                                                                .fontWeight(.bold)
                                                                                .padding()
                                                                                .background(goPressed ?
                                                                                            Rectangle().fill(Color("ButtonBackgroundPressed"))
                                                                                    .shadow(color: .gray, radius: 0, x: 0, y: 0)
                                                                                    .frame(width: widthOfGoButton * 2, height: fontSizeOfText + 5)
                                                                                    .border(width:1, edges: [.top, .bottom, .leading, .trailing], color: .black)
                                                                                            : Rectangle().fill(Color("ButtonBackground"))
                                                                                    .shadow(color: .gray, radius: 2, x: 4, y: 4)
                                                                                    .frame(width: widthOfGoButton * 2, height: fontSizeOfText + 5)
                                                                                    .border(width:1, edges: [.bottom, .trailing], color: .black)
                                                                                )
                                                                            }.position(x:UIScreen.screenWidth / 2 - 40, y:-2)
                                                                    }
                                                                    else if self.showDrawingResult {
                                                                        Link("Link", destination: URL(string: self.drawingResult)!)
                                                                            .font(Font.custom(fontRegular, size:17))
                                                                    }
                                                                    else {
                                                                        Text("Retro Crypto Terminal")
                                                                            .font(Font.custom(fontRegular, size:17))
                                                                            .frame(height: fontSizeOfText, alignment: .center).background(.white).position(x: UIScreen.screenWidth / 2 - 45, y:50)
                                                                        Model3DView(named: "scene.gltf")
                                                                            .transform(
                                                                                rotate: Euler(x: .degrees(self.degrees)),
                                                                                scale: 1
                                                                            )
                                                                            .cameraControls(OrbitControls(
                                                                                    camera: $camera,
                                                                                    sensitivity: 0.8,
                                                                                    friction: 0.1
                                                                                ))
                                                                            .frame(height: UIScreen.screenHeight - 650, alignment: .center).background(.white).position(x: UIScreen.screenWidth / 2 - 45, y:55)

                                                                        Text("Copyright © 2022 Mesh Finance. All rights reserved.").font(Font.custom(fontRegular, size:7))
                                                                            .frame(height: fontSizeOfText, alignment: .center).background(.white).position(x: UIScreen.screenWidth / 2 - 45, y:70)
                                                                            .onLongPressGesture {
                                                                                self.drawingActivated = true
                                                                            }
                                                                    }
                                                                }
                                                            )))))
                        HStack(spacing: 90) {
                            let widthOfAboutButton = "About".widthOfString(usingFont: UIFont.systemFont(ofSize: 17, weight: .bold))
                            let widthOfCryptoButton = "Crypto".widthOfString(usingFont: UIFont.systemFont(ofSize: 17, weight: .bold))
                            Button(action: {
                                self.cryptoPressed = true
                                self.aboutPressed = false
                                self.goPressed = false
                                self.drawings.removeAll()
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
                                if self.showDrawingResult == true {
                                    self.drawingActivated = true
                                    self.showDrawingResult = false
                                }
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
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

extension UIView {
    func asImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
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

class CryptoMarketTicker: ObservableObject {
    @Published var dataIsLoaded: Bool = false
    @Published var cryptocurrencies: [[String]] = []
    @Published var cryptocurrenciesId: [[String]] = []
    private var failed: Bool = false
    private var mapOfCryptoNameToPrices : [String: String] = [:]
    private var mapOfCryptoNameToId : [String: String] = [:]
    private var orderBasedOnMarketCap : [String] = []
    private var poolOfExistingCrypto : Set<String> = []
    private let url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=125&page=1&sparkline=false"
    private let urlBackup = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc"

    init() {
        loadJson(self.url)
    }

    func refresh() async {
        if self.failed {
            return
        }
        self.loadJson(self.url)
    }

    func loadJson(_ urlString: String) {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }

            guard let content = data else {
                print("No data")
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: content, options: []) else {
                print("Error serializing JSON")
                return self.loadJson(self.urlBackup)
            }
            guard let jsonobj = json as? [[String:Any]] else {
                self.failed = true
                print("Failed converting to JSON object")
                return self.loadJson(self.urlBackup)
            }
            DispatchQueue.main.async {
                for i in 0..<jsonobj.count {
                    let cryptoName = String(describing: jsonobj[i]["name"]!)
                    let cryptoId = String(describing: jsonobj[i]["id"]!)
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
                        self.mapOfCryptoNameToPrices[cryptoName] = currentPrice
                        self.mapOfCryptoNameToId[cryptoName] = cryptoId
                    }
                }

                self.cryptocurrencies.removeAll()
                for i in 0..<self.orderBasedOnMarketCap.count {
                    let name = self.orderBasedOnMarketCap[i]
                    let price = self.mapOfCryptoNameToPrices[self.orderBasedOnMarketCap[i]]!
                    let id = self.mapOfCryptoNameToId[self.orderBasedOnMarketCap[i]]!
                    self.cryptocurrencies.append([name, price])
                    self.cryptocurrenciesId.append([name, id])
                }
                self.dataIsLoaded = true
            }
        }
        task.resume()
    }
}

class CryptoGraph: ObservableObject {
    @Published var prices: [[Any]] = []
    private var selectedCrypto = ""
    private var url = ""

    init(selectedCrypto: String) {
        self.selectedCrypto = selectedCrypto
        self.url = "https://api.coingecko.com/api/v3/coins/\(self.selectedCrypto.lowercased())/market_chart?vs_currency=usd&days=7"
        loadJson(self.url)
    }

    func convertDate(dateValue: Int) -> String {
        let truncatedTime = Int(dateValue / 1000)
        let date = Date(timeIntervalSince1970: TimeInterval(truncatedTime))
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyyMMdd"
        return formatter.string(from: date)
    }

    func loadJson(_ urlString: String) {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }

            guard let content = data else {
                print("No data")
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: content, options: []) else { return }
            let jsonobj = json as! [String:Any]
            DispatchQueue.main.async {
                let all_prices = jsonobj["prices"] as! NSArray
                for i in 0..<all_prices.count {
                    let cur_price = all_prices[i] as! NSArray
                    let time = cur_price[0] as! NSInteger
                    let convertedTime = self.convertDate(dateValue: time)
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyyMMdd"
                    let formattedDate = formatter.date(from: convertedTime) ?? Date.distantPast
                    let market_price = cur_price[1] as! Double
                    self.prices.append([formattedDate, market_price])
                }
            }
        }
        task.resume()
    }
}

struct RefreshableView: View {
    @Environment(\.refresh) private var refresh
    private let fontRegular = "JetBrainsMonoNL-Regular"
    private let fontBold = "JetBrainsMono-Bold"
    @State private var sizeOfText: CGSize = .zero
    @State private var fontSizeOfText: CGFloat = 20.0
    @State private var isRefreshing = false
    @State private var isRefreshable = true
    @State private var showPopup = false
    @State private var selectedName = ""
    @State private var selectedId = ""
    @ObservedObject var cryptocurrencies : CryptoMarketTicker

    init(cryptocurrencies : CryptoMarketTicker) {
        self.cryptocurrencies = cryptocurrencies
    }

    var body: some View {
        VStack (alignment: .leading) {
            if $showPopup.wrappedValue {
                ZStack {
                    Color.white
                    VStack {
                        Text(self.selectedName).font(Font.custom(fontRegular, size:15))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        GraphView(selectedCrypto: self.selectedId)
                        Button(action: {
                            self.isRefreshable = true
                            self.showPopup = false
                        }, label: {
                            Text("Close").font(Font.custom(fontRegular, size:15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        })
                    }.padding()
                }
                .frame(width:UIScreen.screenWidth / 2 + 100, height: UIScreen.screenHeight / 5 + 250)
                .border(width:1, edges: [.top, .bottom, .leading, .trailing], color: .black)
                .cornerRadius(0).shadow(color: .black, radius: 2, x: 5, y: 4)
                .position(x:UIScreen.screenWidth / 2 - 45, y: UIScreen.screenHeight / 5 + 70)
            }
            else {
                HStack() {
                    Text("Crypto")
                        .font(Font.custom(fontBold, size:15))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("USD")
                        .font(Font.custom(fontBold, size:15))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                let cryptoArray = cryptocurrencies.cryptocurrencies
                let cryptoIdArray = cryptocurrencies.cryptocurrenciesId

                ForEach(0 ..< cryptoArray.count, id: \.self) { i in
                    let crypto = cryptoArray[i][0]
                    let price = cryptoArray[i][1]
                    let id = cryptoIdArray[i][1]
                    HStack {
                        Button(action: {
                            self.selectedName = "\(crypto)"
                            self.selectedId = "\(id)"
                            self.showPopup = true
                            self.isRefreshable = false
                        }, label: {
                            Text("\(crypto)")
                                .font(Font.custom(fontRegular, size:15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.black)
                        })
                        Button(action: {
                            self.selectedName = "\(crypto)"
                            self.selectedId = "\(id)"
                            self.showPopup = true
                            self.isRefreshable = false
                        }, label: {
                            Text("\(price)")
                                .font(Font.custom(fontRegular, size:15))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .foregroundColor(.black)
                        })
                    }
                }
            }
        }
        .animation(.default, value: isRefreshing)
        .background(GeometryReader {
            Color.clear.preference(key: ViewOffsetKey.self, value: -$0.frame(in: .global).origin.y)
        })
        .onPreferenceChange(ViewOffsetKey.self) {
            if $0 < -80 && !isRefreshing && isRefreshable {
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

struct GraphView: View {
    @ObservedObject var graph : CryptoGraph
    private let fontRegular = "JetBrainsMonoNL-Regular"

    init(selectedCrypto: String) {
        self.graph = CryptoGraph(selectedCrypto: selectedCrypto)
    }

    var body: some View {
        let pricesArray = graph.prices
        VStack {
            if #available(iOS 16.0, *) {
                Chart {
                    ForEach(0 ..< pricesArray.count, id: \.self) { i in
                        let time = pricesArray[i][0] as! Date
                        let price = pricesArray[i][1] as! Double
                        LineMark(
                            x: .value("Time", time, unit: .day),
                            y: .value("Price", price)
                        )
                    }
                }
                .chartYScale(domain: .automatic(includesZero: false))
            } else {
                Text("OS Version does not support charting!")
                    .font(Font.custom(fontRegular, size:17))
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

struct Drawing {
    var points: [CGPoint] = [CGPoint]()
}

struct DrawingPad : View {
    @Binding var currentDrawing: Drawing
    @Binding var drawings: [Drawing]
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for drawing in self.drawings {
                    self.add(drawing: drawing, toPath: &path)
                }
                self.add(drawing: self.currentDrawing, toPath: &path)
            }
            .stroke(.black, lineWidth: 1.3)
            .background(.white)
            .gesture(
                DragGesture(minimumDistance: 0.1)
                    .onChanged({ (value) in
                        let currentPoint = value.location
                        if currentPoint.y >= 0
                            && currentPoint.y < geometry.size.height
                            && currentPoint.x >= 0
                            && currentPoint.x < geometry.size.width {
                            self.currentDrawing.points.append(currentPoint)
                        }
                    })
                    .onEnded({ (value) in
                        self.drawings.append(self.currentDrawing)
                        self.currentDrawing = Drawing()
                    })
            )
        }
        .frame(width: UIScreen.screenWidth - 90, height: UIScreen.screenHeight - 437, alignment: .center)
    }

    private func add(drawing: Drawing, toPath path: inout Path) {
        let points = drawing.points
        if points.count > 1 {
            for i in 0..<points.count-1 {
                let current = points[i]
                let next = points[i+1]
                path.move(to: current)
                path.addLine(to: next)
            }
        }
    }
}

struct RectGetter: View {
    @Binding var rect: CGRect
    
    var body: some View {
        GeometryReader { proxy in
            self.createView(proxy: proxy)
        }
    }

    func createView(proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = proxy.frame(in: .global)
        }

        return Rectangle().fill(Color.clear)
    }
}
