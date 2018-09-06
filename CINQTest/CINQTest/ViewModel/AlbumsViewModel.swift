//
//  AlbumsViewModel.swift
//  CINQTest
//
//  Created by Davi Pereira Neto on 06/09/2018.
//  Copyright © 2018 Davi Pereira Neto. All rights reserved.
//

import RxSwift
import Alamofire
import RxAlamofire
import RxAlamofire_ObjectMapper

class AlbumsViewModel: NSObject {
    
    var albumsObs: Observable<[Album]> = Observable.never()
    
    override init() {
        let stringUrl = "https://jsonplaceholder.typicode.com/photos"
        guard let url = URL(string: stringUrl) else {return}
        let urlRequest = URLRequest(url: url)
        albumsObs = requestJSON(urlRequest).mappableArray(as: Album.self)
    }
}
