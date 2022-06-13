// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 09/06/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

@main struct InfomaticTool {
    static func main() {
        print(CommandLine.arguments)
        
        guard CommandLine.arguments.count > 1 else {
            fatalError("not enough arguments")
        }

        var info: [String:Any] = [:]
        for input in CommandLine.arguments[2...] {
            if let properties = read(source: input) {
                info.merge(properties, uniquingKeysWith: { old, new in new })
            }
        }

        let outputPath = CommandLine.arguments[1]
        let infoData = try? PropertyListSerialization.data(fromPropertyList: info, format: .binary, options: 0)
        let infoURL = URL(fileURLWithPath: outputPath)
        try? infoData?.write(to: infoURL)

    }
    
    static func read(source: String) -> [String:Any]? {
        let url = URL(fileURLWithPath: source)
        
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        var format = PropertyListSerialization.PropertyListFormat.xml
        if let properties = try? PropertyListSerialization.propertyList(from: data, format: &format) {
            return properties as? [String: Any]
        }
        
        if let properties = try? JSONSerialization.jsonObject(with: data) {
            return properties as? [String:Any]
        }
        
        return nil
    }
}
