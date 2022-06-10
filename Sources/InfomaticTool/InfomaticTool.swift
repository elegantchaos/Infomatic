// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 09/06/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

@main struct InfomaticTool {
    static func main() {
        guard CommandLine.arguments.count < 3 else {
            fatalError("not enough arguments: \(CommandLine.arguments)")
        }

        var info: [String:Any] = [:]
        for input in CommandLine.arguments[2...] {
            info[input] = "blah"
        }

        let outputPath = CommandLine.arguments[1]
        let infoData = try? PropertyListSerialization.data(fromPropertyList: info, format: .binary, options: 0)
        let infoURL = URL(fileURLWithPath: outputPath)
        try? infoData?.write(to: infoURL)

    }
}
