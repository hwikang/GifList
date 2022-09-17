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
            
            
            let gifs = try await Network.fetchTrends()
//            print(gifs)
            
            trendList.accept(gifs)
        }

    }
}
