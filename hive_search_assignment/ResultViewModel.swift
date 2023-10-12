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
    var pageIds = [""]

    
    var tableView = UITableView()

    
    func callRequest(searchString: String, completion: @escaping (Bool) -> ()){
        let session = URLSession(configuration: .default)
        let requestType = "GET"
        let url = "https://en.wikipedia.org/w/api.php"
        var request = URLRequest(url: URL(string: url)!)
        var params : [String : Any] = [:]
        params["format"] = "json"
        params["action"] = "query"
        params["generator"] = "search"
        params["gsrnamespace"] = "0"
        params["gsrsearch"] = searchString
        params["gsrlimit"] =  "10"
        params["prop"] =  "pageimages|extracts"
        params["pilimit"] =  "max"
        params["exintro"] =  "true"
        params["explaintext"] =  "true"
        params["exlimit"] =  "max"
        
        var queryItems = [URLQueryItem]()
        for (key, value) in params{
            queryItems.append(URLQueryItem(name: key, value: value as? String))
            
        }
        request.httpMethod = requestType
            request.url?.append(queryItems: queryItems)
        

        
        
        print(request)
        
        let task = session.dataTask(with: request, completionHandler: { [self]
            data, response, error -> Void in
            
            do{
                if let json = try JSONSerialization.jsonObject(with: data!, options: [] ) as? NSDictionary{
                    print("Response: \(json)")
                    
                }
                
                let result = try? JSONDecoder().decode(ResultModel.self, from: data!)
                self.resultModel = result
                pageIds = []
                for (key, _) in self.resultModel?.query.pages ?? [:]{
                    
                    pageIds.append(key)
                }
                
                debugPrint("pageIds---->", pageIds)
                
                
                completion(true)

                
            }catch {
                print(error)
                completion(false)
                
            }
        })
        
        task.resume()


    }
}

extension ResultviewModel : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
           return pageIds.count

        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            
            let height =  ((self.resultModel?.query.pages[(pageIds[indexPath.row])]?.thumbnail?.height) ?? 0) + 70
            
            return CGFloat(height)
        }else{
             return 70
        }
 
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

      
        let titleView = UILabel(frame: CGRect(origin: CGPoint(x:0 , y:0), size:CGSize(width: self.tableView.frame.width, height: 20) ))
        titleView.text = "Results"
        titleView.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        return titleView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 1 {
            return 20
        }else{
            return 0
        }
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            if let cell = tableView.dequeueReusableCell(withIdentifier: SearchFieldTableViewcell.identifier)as? SearchFieldTableViewcell{
                self.tableView.separatorColor = UIColor.clear
                cell.textchangeClosure = { value in
                    self.pageIds.removeAll()
                    self.callRequest(searchString: value, completion: {
                        result in
                        if(result){
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                       
                    })
                }
                return cell
            }
            
        }else if indexPath.section == 1{
            if let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier) as? ResultTableViewCell{

                cell.titleLabel.text = self.resultModel?.query.pages[(pageIds[indexPath.row])]?.title
                
                cell.descriptionLabel.text = self.resultModel?.query.pages[(pageIds[indexPath.row])]?.extract
                
                if let sourceUrl = self.resultModel?.query.pages[(pageIds[indexPath.row])]?.thumbnail?.source{
                    cell.productImage.isHidden = false

                    let url = URL(string: sourceUrl )!
                    URLSession.shared.dataTask(with: url){
                      data, result, error in
                        guard let imageData = data else{return}
                        
                        DispatchQueue.main.async {
                            cell.productImage.image = UIImage(data: imageData)
                        }
                        
                    }.resume()
                }else{
                    cell.productImage.isHidden = true
                }
                
                

                return cell
            }
        }
            
        
        return UITableViewCell()
        
        

    }
    
    
    
}



