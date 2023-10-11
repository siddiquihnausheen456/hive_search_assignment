//
//  ResultModel.swift
//  hive_search_assignment
//
//  Created by Nausheen Siddiqui on 10/10/23.
//

import Foundation


struct ResultModel : Decodable{
    var query: Query
}


struct Query : Decodable{
    var pages:   [String: PageData]

}



struct PageData : Decodable{
    var pageid: Int
    var title: String
    var index: Int
    var extract: String
    var thumbnail: Thumbnail?
    
    
    
}


struct Thumbnail: Decodable{
    var source: String
    var width: Int
    var height: Int
}
