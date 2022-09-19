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
    var small: Image?
    var downsized: Image?
    var preview: Image?
    
    enum CodingKeys: String, CodingKey {
        case original
        case small = "downsized_small"
        case downsized
        case preview = "preview_gif"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        original = try? values.decode(Image.self, forKey: .original)
        small = try? values.decode(Image.self, forKey: .small)
        downsized = try? values.decode(Image.self, forKey: .downsized)
        preview = try? values.decode(Image.self, forKey: .preview)

    }
}

class Image: Decodable {
    var url: String?
    var mp4: String?
    var height: Int?
    var width: Int?
    
    enum CodingKeys: String, CodingKey {
        case url, mp4, height, width
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try? values.decode(String.self, forKey: .url)
        mp4 = try? values.decode(String.self, forKey: .mp4)
        width = try? Int(values.decode(String.self, forKey: .width))
        height = try? Int(values.decode(String.self, forKey: .height))
                         
    }
}
