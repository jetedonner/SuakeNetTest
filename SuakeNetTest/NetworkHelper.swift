//
//  NetworkHelper.swift
//  Suake3D
//
//  Created by Kim David Hauser on 30.03.21.
//

import Foundation
import GameKit


extension Notification.Name {
  static let presentGame = Notification.Name(rawValue: "presentGame")
  static let authenticationChanged = Notification.Name(rawValue: "authenticationChanged")
}

class NetworkHelper: NSObject, GKLocalPlayerListener {
    
    var testData:BaseNetworkData!
    var testDataTurn:TurnNetworkData!
    
    func authenticate(){
        print("TRYING 2 GameCenter authenticate!")
        GKLocalPlayer.local.authenticateHandler = { gcAuthVC, error in
            print("TRYING 2 GameCenter authenticate => RETURNED!")
          NotificationCenter.default.post(name: Notification.Name.authenticationChanged, object: GKLocalPlayer.local.isAuthenticated)

          if GKLocalPlayer.local.isAuthenticated {
//            print("Authenticated to Game Center!")
            GKLocalPlayer.local.register(self)
            print("GameCenter authenticated!")
//            GKAccessPoint.shared.parentWindow = self.viewController?.view.window
//            GKAccessPoint.shared.location = .bottomLeading
//            GKAccessPoint.shared.showHighlights = true
//            GKAccessPoint.shared.isActive = GKLocalPlayer.local.isAuthenticated
          } else if let vc = gcAuthVC {
//            self.viewController?.presentAsModalWindow(vc)//(vc, animator: NSViewControllerPresentationAnimator).present(vc, animated: true)
          }
          else {
            print("Error authentication to GameCenter: \(error?.localizedDescription ?? "none")")
          }
        }
    }
    
    override init() {
        super.init()
        print("\n ===== NetTest START ===== ")
        self.testData = BaseNetworkData(id: 1, msgType: .initMsg)
        self.encodeAndSend()
        
        self.testDataTurn = TurnNetworkData(id: 2)
        self.encodeAndSend2()
        
//        self.authenticate()
        print("\n =====  NetTest END  ===== \n")
    }
    
    func encodeAndSend2(){
        print(" ----- ENCODED ----- ")
        do{
            let encoder:JSONEncoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted // TODO Debug
            let encData:Data = try encoder.encode(self.testDataTurn)
            print(String(data: encData, encoding: .utf8)!)
            
            self.receiveAndDecoder2(data: encData)
        }catch{
            print("Could not encode testData!")
        }
    }
    
    func encodeAndSend(){
        print(" ----- ENCODED ----- ")
        do{
            let encoder:JSONEncoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted // TODO Debug
            let encData:Data = try encoder.encode(self.testData)
            print(String(data: encData, encoding: .utf8)!)
            
            self.receiveAndDecoder(data: encData)
        }catch{
            print("Could not encode testData!")
        }
    }
    
    func receiveAndDecoder2(data:Data){
        print("\n ----- DECODED ----- ")
        let decoder:JSONDecoder = JSONDecoder()
        let newObject:TurnNetworkData = try! decoder.decode(TurnNetworkData.self, from: data)//{
        
        print("newObject.id: \(newObject.id)")
        print("newObject.msgType: \(newObject.msgType)")
        print("newObject.turnDir: \(newObject.turnDir)")
    }
    
    func receiveAndDecoder(data:Data){
        print("\n ----- DECODED ----- ")
        let decoder:JSONDecoder = JSONDecoder()
        let newObject:BaseNetworkData = try! decoder.decode(BaseNetworkData.self, from: data)//{
        
        print("newObject.id: \(newObject.id)")
        print("newObject.msgType: \(newObject.msgType)")
            
    }
}
