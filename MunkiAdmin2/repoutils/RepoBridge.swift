//
//  MunkiRepoUtil.swift
//  MunkiAdmin2
//
//  Created by Küng, Steve on 28.04.2024.
//

import Foundation

class RepoBridge {
    func shell(launchPath: String, arguments: [String]) -> String {
        let task = Process()
        task.launchPath = launchPath
        task.arguments = arguments

        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: String.Encoding.utf8)!
        if output.count > 0 {
            //remove newline character.
            let lastIndex = output.index(before: output.endIndex)
            return String(output[output.startIndex ..< lastIndex])
        }
        return output
    }
    
    func run(commands: [String]) -> String? {
        if let repobridge = Bundle.main.url(forResource: "repobridge", withExtension: nil)?.path() {
            let output = shell(launchPath: repobridge, arguments: commands)
           // remove everything befor "--- start repo bridge ---"
            if let start = output.range(of: "--- start repo bridge ---\n") {
                return String(output[start.upperBound...])
            } 


            return output
        } else {
            print("error loading repobridge")
            return nil
        }
    }
    
    func listitems(kind: String) -> [String] {
        let output = self.run(commands: ["-k", kind])
        
        if let characterArray = output?.components(separatedBy: ",") {
            return characterArray
        }
        return []
    }
    
    func getPlist(item: String) -> [String:Any] {
        let output = self.run(commands: ["-i", item])
        if let characterArray = output?.data(using: .utf8) {
            do {
                if let plist = try PropertyListSerialization.propertyList(from: characterArray, format: nil)
                as? [String: Any]  {
                return plist
              } else {
                print("Not able to convert plist to dictionary")
              }
            } catch let error {
              print(error)
            }
        }
        return Dictionary()
    }
    
    func savePlist(item: String) -> Bool {
        let output = self.run(commands: ["-s", item])
        
        
        return false
    }
}
