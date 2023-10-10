//
//  ResultModel.swift
//  hive_search_assignment
//
//  Created by Nausheen Siddiqui on 10/10/23.
//

import Foundation


struct ResultModel : Codable{
    var batchcomplete: String
    var query: Query
}


struct Query : Codable{
    var pages: Pages
}


struct Pages: Codable{
    var pageId : [String: PageData]
    
//    struct CodingKeys: CodingKey, Hashable {
//            var stringValue: String
//
//            init(stringValue: String) {
//                self.stringValue = stringValue
//            }
//
//            var intValue: Int? {
//                return nil
//            }
//
//            init?(intValue: Int) {
//                return nil
//            }
//        }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let pageIds = container.allKeys
//        var pageData : [PageData] = []
//
//
//    }
    
    
}


struct PageData : Codable{
    var pageid: Int
    var title: String
    var index: Int
    var extract: String
    var thumbnail: Thumbnail
    
    
    
}


struct Thumbnail: Codable{
    var source: String
    var width: Int
    var height: Int
}
