//
//  BlockFetch.swift
//  OneExplorer
//
//  Created by Mohit Garg on 2/14/18.
//  Copyright © 2018 Mohit Garg. All rights reserved.
//

import Foundation

class BlockFetch {
    
    typealias JSONDictionary = [String: Any]
    typealias BlockReturn = (Block?, String)->()
    
    let defaultSession = URLSession(configuration: .default)
    
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    
    var lastBlock: Int?
    
    func getChainInfo(completion: @escaping BlockReturn) {
        
    dataTask?.cancel()
    
        if var urlComponents = URLComponents(string: "http://testnet1.eos.io/v1/chain/get_info") {

        guard let url = urlComponents.url else { return }
        
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
        
            if let error = error {
                self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self.updateChainInfo(data)
                self.getBlockInfo(){block, error in
                    completion(block, error)
                }
            }
        }
        
        dataTask?.resume()
    }
  }
    
    func getBlockInfo(completion: @escaping BlockReturn) {
        var postBody = JSONDictionary()
        var request: URLRequest
        var data: Data
        
        dataTask?.cancel()
        
        if let urlComponents = URLComponents(string: "http://testnet1.eos.io/v1/chain/get_block"){
            
            guard let url = urlComponents.url else { return }
            
            postBody["block_num_or_id"] = lastBlock!
            
            do {
                data = try JSONSerialization.data(withJSONObject: postBody, options: [])
            
                request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.httpBody = data
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
            } catch let parseError as NSError{
                errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
                return
            }
         
            dataTask = defaultSession.dataTask(with: request) {data, response, error in
                
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    self.updateBlockInfo(data) {block, error in
                        completion(block, error)
                    }
                }
                
            }
        }
        
        dataTask?.resume()
    }
    
    fileprivate func updateChainInfo(_ data: Data) {
        var response: JSONDictionary?
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let lastBlock = response!["last_irreversible_block_num"] as? Int else{
            errorMessage += "Dictionary does not contain last irreversible block number"
            return
        }
        
        self.lastBlock = lastBlock
    }
    
    fileprivate func updateBlockInfo(_ data: Data, completion: @escaping BlockReturn) {
        var block: JSONDictionary?
        
        do {
            block = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        if let previewPrevious = block!["previous"] as? String,
            let previewId = block!["id"] as? String,
        let previewNumber = block!["block_num"] as? Int,
            let previewProducer = block!["producer"] as? String,
        let previewSignature = block!["producer_signature"] as? String,
            let previewPrefix = block!["ref_block_prefix"] as? Int
        {
         
            let block = Block(id: previewId, number: previewNumber, previous: previewPrevious,
                              timeStamp: Date(), producer: previewProducer, signature: previewSignature,
                              prefix: previewPrefix)
            
            completion(block, errorMessage)
        }
    }
}

