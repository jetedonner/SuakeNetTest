//
//  MoveNetworkData.swift
//  SuakeNetTest
//
//  Created by Kim David Hauser on 30.03.21.
//

import Foundation


class TurnNetworkData: BaseNetworkData {
    
    var turnDir:TurnDir = .Straight
    
    init(id:Int){
        super.init(id: id, msgType: .turnMsg)
        self.turnDir = .Left
    }
    
    private enum CodingKeys: String, CodingKey {
        case turnDir
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try super.init(from: decoder)

        self.turnDir = try container.decode(TurnDir.self, forKey: .turnDir)
    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.turnDir, forKey: .turnDir)

        try super.encode(to: encoder)
    }
}
