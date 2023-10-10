//
//  Encodable+Helpers.swift
//  nativeUIModulesTest
//
//  Created by Dominic Go on 7/6/20.
//

import Foundation

struct JSON {
  static let encoder = JSONEncoder();
};

extension Encodable {
  subscript(key: String) -> Any? {
    return dictionary[key];
  };
  
  var dictionary: [String: Any] {
    return
      (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self)))
        as?  [String: Any] ?? [:];
  };
  
  func jsonData() throws -> Data {
    let encoder = JSON.encoder;
    
    encoder.outputFormatting = .prettyPrinted;
    
    if #available(iOS 10.0, *) {
      encoder.dateEncodingStrategy = .iso8601;
      
    } else {
      encoder.dateEncodingStrategy = .millisecondsSince1970;
    };
    
    return try encoder.encode(self);
  };
};
