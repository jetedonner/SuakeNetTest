//
//  NetworkHelper.swift
//  Suake3D
//
//  Created by Kim David Hauser on 30.03.21.
//

import Foundation
import GameKit
import NetTestFW

extension Notification.Name {
  static let presentGame =              Notification.Name(rawValue: "presentGame")
  static let authenticationChanged =    Notification.Name(rawValue: "authenticationChanged")
}

public class NetworkHelper: NSObject, GKLocalPlayerListener {
    
    let dbgMode:Bool = false
    
    var testData:BaseNetworkData!
    var testDataTurn:TurnNetworkData!
    var testDataInitLevel:LoadLevelNetworkData!
    
    var testDataEndMatch:EndMatchNetworkData!
    
    override init() {
        super.init()
        NetTestFWClass.sayHello()
        print("\n ===== NetTest START ===== ")
        self.testData = BaseNetworkData(id: 1, msgType: .initMsg)
        self.receiveAndDecode(data: self.encodeAndSend(netData: self.testData)!)
        
        self.testDataTurn = TurnNetworkData(id: 2)
        self.receiveAndDecode(data: self.encodeAndSend(netData: self.testDataTurn)!)
        
        self.testDataInitLevel = LoadLevelNetworkData(id: 3)
        self.receiveAndDecode(data: self.encodeAndSend(netData: self.testDataInitLevel)!)
        
        self.testDataEndMatch = EndMatchNetworkData(id: 4)
        self.receiveAndDecode(data: self.encodeAndSend(netData: self.testDataEndMatch)!)

        print("\n =====  NetTest END  ===== \n")
    }
    
    func receiveAndDecode(data:Data){
        print("\n ----- DECODED ----- ")
        let decoder:JSONDecoder = JSONDecoder()
        let newObjectSuper:BaseNetworkData = try! decoder.decode(BaseNetworkData.self, from: data)
        print("newObjectSuper.id: \(newObjectSuper.id)")
        print("newObjectSuper.msgType: \(newObjectSuper.msgType)")
        
        if(newObjectSuper.msgType == .initLevelMsg){
            let newObject:LoadLevelNetworkData = try! decoder.decode(LoadLevelNetworkData.self, from: data)
            
            print("newObject.environment.levelSize: \(newObject.levelConfig.levelEnv.levelSize.toString())")
            print("newObject.environment.floorType: \(newObject.levelConfig.levelEnv.floorType.toString())")
            print("newObject.environment.skyBoxType: \(newObject.levelConfig.levelEnv.skyBoxType.toString())")
            print("newObject.environment.matchDuration: \(newObject.levelConfig.levelEnv.matchDuration.toString())")
            
        }else if(newObjectSuper.msgType == .turnMsg){
            let newObject:TurnNetworkData = try! decoder.decode(TurnNetworkData.self, from: data)
            print("newObject.turnDir: \(newObject.turnDir)")
            print("newObject.position: \(newObject.position)")
            
        }else if(newObjectSuper.msgType == .initMsg){
            let newObject:BaseNetworkData = try! decoder.decode(BaseNetworkData.self, from: data)
            print("newObject.id: \(newObject.id)")
            print("newObject.msgType: \(newObject.msgType)")
        }else if(newObjectSuper.msgType == .endMatchMsg){
            let newObject:EndMatchNetworkData = try! decoder.decode(EndMatchNetworkData.self, from: data)
            print("newObject.id: \(newObject.id)")
            print("newObject.msgType: \(newObject.msgType)")
        }
    }
}
