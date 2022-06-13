// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 09/06/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import PackagePlugin

@main struct InfomaticPlugin: BuildToolPlugin {
    func createBuildCommands(context: PackagePlugin.PluginContext, target: PackagePlugin.Target) async throws -> [PackagePlugin.Command] {
        print("foo")
        guard let target = target as? SourceModuleTarget else {
            return []
        }
        
        let outputRoot = context.pluginWorkDirectory.appending("GeneratedSources")

        var inputMap: [Path:[Path]] = [:]
        let sources = target.sourceFiles(withSuffix: "info")
        for source in sources {
            print("found source \(source)")
            if let outputName = source.path.stem.split(separator: "-").first {
                let outputPath = outputRoot.appending(subpath: "\(outputName).plist")
                inputMap.append(source.path, forKey: outputPath)
            }
        }
    
        var commands: [PackagePlugin.Command] = []
        for (output, inputs) in inputMap {
            var arguments = [output.string]
            arguments.append(contentsOf: inputs.map(\.string))
            
            commands.append(
                .buildCommand(
                    displayName: "Compiling \(output.stem).plist",
                    executable: try context.tool(named: "InfomaticTool").path,
                    arguments: arguments,
                    inputFiles: inputs,
                    outputFiles: [output]
                )
            )
        }
        
        return commands
    }
}


public extension Dictionary {
    /// Append a new value to the list for a given key.
    /// If there is no list, create one.
    mutating func append<V>(_ value: V, forKey key: Key) where Value == [V] {
        if var existing = self[key] {
            existing.append(value)
            self[key] = existing
        } else {
            self[key] = [value]
        }
    }
}
