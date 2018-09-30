//
//  API.swift
//  Wiki-Info
//
//  Created by Sanket on 30/09/18.
//  Copyright © 2018 Developer Sanket. All rights reserved.
//

import Foundation
class SearchApi {
    typealias updateSearchResult = (Query?,String) -> ()

    var resData : Query?
    var errorMessage = ""
    let defaultSession = URLSession(configuration: .default)

    var dataTask: URLSessionDataTask?


    func getSearchResult(searchKeyword:String,completion: @escaping updateSearchResult ) {
        dataTask?.cancel()


        if(searchKeyword == "") {
            print("cannot proceed with empty search keyword : getSearchResult method")
            DispatchQueue.main.async {
                // print(self.resData, "is the result from the getSearchResult method")
                self.errorMessage = "search keyword cannot be null"
                completion(self.resData, self.errorMessage)
            }
            return
        }

        let searchKey = searchKeyword.replacingOccurrences(of: " ", with: "+")
        print(searchKey)
        let url = "https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=\(searchKey)&gpslimit=10"
        guard let Url = URL(string: url) else {print("URL Error"); return}
        var request = URLRequest(url:Url)

        request.httpMethod = "GET"



        dataTask = defaultSession.dataTask(with: request) { data, response, error in
            defer { self.dataTask = nil }
            if let error = error {
                self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                // 6
                print(response)
                print(self.updateSearchResults(data))
                DispatchQueue.main.async {
                    //print(self.resData, "is the result from the getSearchResult method")
                    completion(self.resData, self.errorMessage)
                }
            } else {
                print(error!)
            }
        }
        dataTask?.resume()

    }


    fileprivate func updateSearchResults(_ data: Data) {
        do {
            print(data)
            let fetchedRes = try JSONDecoder().decode(Search_Result.self, from: data)
            resData = (fetchedRes.query)
            print(resData as Any ,"is the fetched result")
        }

        catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            print(errorMessage, " This is the error in data")
        }

    }

}
