//
//  Network.swift
//  kakaohairshop
//
//  Created by 슈퍼 on 2022/09/17.
//

import Foundation

import Foundation

let APIKEY = "ITnII4MdYK5Fn5lKBgOnsk92nY7SYo2g"


class Network {
    
     static func fetchTrends() async throws -> [Gif] {
         print("call fetch")
        guard let url = URL(string: "https://api.giphy.com/v1/gifs/trending?api_key=\(APIKEY)") else {
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
         
//        let dataTask = URLSession.shared.dataTask(with: request) {data, response, error in
////            print("data \(datas)")
////            print("response \(response)")
//            if let error = error {
//                print("Error fetch Trend", error.localizedDescription)
//            }
//
//            if let data = data {
//                do {
//                    let decoder = JSONDecoder()
//                    let gif = try decoder.decode(GifData.self, from: data)
//                    print("gif \(gif.data.count)")
//                } catch let error {
//                    print(error)
//                }
//
//            }
//
//
//        }
//
//         dataTask.resume()
    }
    
}
