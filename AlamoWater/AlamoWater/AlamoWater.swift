//
//  AlamoWater.swift
//  AlamoWater
//
//  Created by zaid.pathan on 03/02/17.
//  Copyright © 2017 Solution Analysts Pvt. Ltd. All rights reserved.
//

import UIKit
import Alamofire

public protocol AlamoWaterProtocol {
    func didCallHello()
}

open class AlamoWater: NSObject {
    public static let shared = AlamoWater()
    
    public var delegate:AlamoWaterProtocol?
    
    open func hello(){
        debugPrint("Hello from AlamoWater!")
        AlamoWater.shared.delegate?.didCallHello()
        Alamofire.request("https://apple.com").downloadProgress { (progress) in
            debugPrint(progress)
        }
    }
}
