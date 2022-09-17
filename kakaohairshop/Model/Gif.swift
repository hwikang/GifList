//
//  Gif.swift
//  kakaohairshop
//
//  Created by 슈퍼 on 2022/09/17.
//

import Foundation

class GifData: Decodable {
    var data: [Gif]
}

class Gif : Decodable {
//    var embedUrl: String?
    var images: Images?
    
//    enum CodingKeys: String, CodingKey {
//        case embedUrl = "embed_url"
//        case image = "images"
//    }
//
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        embedUrl = try? values.decode(String.self, forKey: .embedUrl)
//        image = try? values.decode(Image.self, forKey: .image)
//
//    }
}

class Images: Decodable {
    var original: Image?
}

class Image: Decodable {
    var url: String?
    var height: Int?
    var width: Int?
    
    enum CodingKeys: String, CodingKey {
        case url, height, width
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try? values.decode(String.self, forKey: .url)
        width = try? Int(values.decode(String.self, forKey: .width))
        height = try? Int(values.decode(String.self, forKey: .height))
                         
    }
}
