//
//  HomeViewModel.swift
//  kakaohairshop
//
//  Created by 슈퍼 on 2022/09/17.
//

import Foundation
import RxSwift
import RxCocoa
class HomeViewModel {
    
    private let trendList = PublishRelay<[Gif]>()
    private var offset = 0
    private var dataSource: [Gif] = []
    struct Input {
        
    }
    
    struct Output {
        var trends: Observable<[Gif]>
    }
    
    func transform(input: Input) -> Output {
        return Output(trends: trendList.asObservable())
    }
    
    func fetchTrends() {
        
        
        Task {
            
            let gifs = try await Network.fetchTrends(offset: offset)
            dataSource.append(contentsOf: gifs)
            print("fetch more \(dataSource.count)")

            trendList.accept(dataSource)
            offset += 1
        }

    }
    
    func getDataCount() -> Int {
        return dataSource.count
    }
    
    func getImageSize(index: Int) -> CGSize {
        guard let image = dataSource[index].images?.preview,
              let width = image.width,
              let height = image.height else { return .zero}
        return CGSize(width: width, height: height)
    }
  
}
