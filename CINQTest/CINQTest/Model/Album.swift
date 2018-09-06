//
//  Album.swift
//  CINQTest
//
//  Created by Davi Pereira Neto on 05/09/2018.
//  Copyright © 2018 Davi Pereira Neto. All rights reserved.
//

import ObjectMapper

class Album: NSObject, Mappable {
    
    var title: String?
    var picUrl: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        picUrl <- map["url"]
    }
    
    override var description: String {
        return "Title: \(title!) --- PicUrl: \(picUrl!)\n"
    }
    
}
