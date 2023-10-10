//
//  ResultViewModel.swift
//  hive_search_assignment
//
//  Created by Nausheen Siddiqui on 10/10/23.
//

import Foundation
import UIKit

class ResultviewModel : NSObject{
    var resultModel : ResultModel?
    var viewController = ViewController()
    
    var tableView = UITableView()

    
    func callRequest(completion: @escaping (Bool) -> ()){
        let session = URLSession(configuration: .default)
        let requestType = "GET"
        let url = "https://en.wikipedia.org/w/api.php"
        var request = URLRequest(url: URL(string: url)!)
        var params : [String : Any] = [:]
        params["format"] = "json"
        params["action"] = "query"
        params["generator"] = "search"
        params["gsrnamespace"] = "0"
        params["gsrsearch"] = "apple"
        params["gsrlimit"] =  "10"
        params["prop"] =  ""
//        params["pilimit"] =  "max"
//        params["exintro"] =  ""
//        params["explaintext"] =  ""
//        params["exlimit"] =  "max"
        
        var queryItems = [URLQueryItem]()
        for (key, value) in params{
            queryItems.append(URLQueryItem(name: key, value: value as? String))
            
        }
        request.httpMethod = requestType
            request.url?.append(queryItems: queryItems)
        

        
        
        print(request)
        
        let task = session.dataTask(with: request, completionHandler: {
            data, response, error -> Void in
            
            do{
                if let json = try JSONSerialization.jsonObject(with: data!, options: [] ) as? NSDictionary{
                    print("Response: \(json)")
                    
                }
                
                let result = try? JSONDecoder().decode(ResultModel.self, from: data!)
                var pageId = [String]()
                
                for id in result?.query.pages.pageId ?? [:]{
                    pageId.append(id.value.title)
                    
                    print(pageId)

                }
                
                
                completion(true)

                
            }catch {
                print(error)
                
            }
        })
        
        task.resume()


    }
}

extension ResultviewModel : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        resultModel?.query.pages.pageId.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier) as? ResultTableViewCell{
             resultModel?.query.pages.pageId.forEach{
                (id, pageData) in
                 cell.titleLabel.text = resultModel?.query.pages.pageId[id]?.title
                 print(resultModel?.query.pages.pageId[id]?.title)
            }
            
            return cell
        }else{
            return UITableViewCell()
        }

    }
    
}
