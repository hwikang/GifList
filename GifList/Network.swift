//
//  Network.swift
//  kakaohairshop
//
//  Created by 슈퍼 on 2022/09/17.
//

import Foundation

import Foundation



class Network {
    
    static func fetchTrends(offset: Int) async throws -> [Gif] {
         print("call fetch")
        guard let url = URL(string: "https://api.giphy.com/v1/gifs/trending?api_key=\(APIKEY)&offset=\(offset)") else {
            throw NetworkError.invalidURL }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
         print("request \(request)")
         
         
         let (data, response) = try await URLSession.shared.data(from: url)
         
         guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
             throw NetworkError.invalidServerResponse
         }
         
         let decoder = JSONDecoder()
         let gif = try decoder.decode(GifData.self, from: data)
         print("gif \(gif.data.count)")
         return gif.data
         
    }
    
}
