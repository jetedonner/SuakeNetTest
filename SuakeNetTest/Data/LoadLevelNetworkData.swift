//
//  LoadLevelNetworkData.swift
//  SuakeNetTest
//
//  Created by Kim David Hauser on 01.04.21.
//

import Foundation

class LoadLevelNetworkData: BaseNetworkData {
    
    var levelSize:LevelSize = .Small
    var floorType:FloorType = .Debug
    
    init(id: Int) {
        super.init(id: id, msgType: .initLevelMsg)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
}
