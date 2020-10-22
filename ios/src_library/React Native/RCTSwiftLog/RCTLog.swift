//
//  RCTLog.swift
//  nativeUIModulesTest
//
//  Created by Dominic Go on 6/27/20.
//

import Foundation

public func RCTLogError(_ message: String, _ file: String=#file, _ line: UInt=#line) {
  RCTSwiftLog.error(message, file: file, line: line)
}

public func RCTLogWarn(_ message: String, _ file: String=#file, _ line: UInt=#line) {
  RCTSwiftLog.warn(message, file: file, line: line)
}

public func RCTLogInfo(_ message: String, _ file: String=#file, _ line: UInt=#line) {
  RCTSwiftLog.info(message, file: file, line: line)
}

public func RCTLog(_ message: String, _ file: String=#file, _ line: UInt=#line) {
  RCTSwiftLog.log(message, file: file, line: line)
}

public func RCTLogTrace(_ message: String, _ file: String=#file, _ line: UInt=#line) {
  RCTSwiftLog.trace(message, file: file, line: line)
}

