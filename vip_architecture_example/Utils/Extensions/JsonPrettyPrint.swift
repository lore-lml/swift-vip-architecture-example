//
//  JsonPrettyPrint.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 27/06/22.
//

import Foundation

extension Encodable{
    var jsonString: String?{
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        guard let data = try? encoder.encode(self) else{
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
}

extension Data{
    var jsonString: String?{
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: .utf8) else {
                  return  nil
              }
        
        return prettyPrintedString
    }
}

extension Dictionary where Key == String, Value == Any{
    var jsonString: String?{
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: .utf8) else {
                  return  nil
              }
        
        return prettyPrintedString
    }
}

