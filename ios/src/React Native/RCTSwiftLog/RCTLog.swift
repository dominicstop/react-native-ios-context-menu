//
//  RCTLog.swift
//  nativeUIModulesTest
//
//  Created by Dominic Go on 6/27/20.
//

import Foundation

internal class RCTSwiftLog {
  func error(_ message: String, _ file: String=#file, _ line: UInt=#line) {
    RCTContextMenuSwiftLog.error(message, file: file, line: line);
  };

  func warn(_ message: String, _ file: String=#file, _ line: UInt=#line) {
    RCTContextMenuSwiftLog.warn(message, file: file, line: line);
  };

  func info(_ message: String, _ file: String=#file, _ line: UInt=#line) {
    RCTContextMenuSwiftLog.info(message, file: file, line: line);
  };

  func log(_ message: String, _ file: String=#file, _ line: UInt=#line) {
    RCTContextMenuSwiftLog.log(message, file: file, line: line);
  };

  func trace(_ message: String, _ file: String=#file, _ line: UInt=#line) {
    RCTContextMenuSwiftLog.trace(message, file: file, line: line);
  };
};



