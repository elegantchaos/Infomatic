// swift-tools-version: 5.7

// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 09/06/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import PackageDescription

let package = Package(
    name: "Infomatic",
    platforms: [
        .macOS(.v10_13)
    ],

    products: [
        .plugin(
            name: "InfomaticPlugin",
            targets: [
                "InfomaticPlugin"
            ]
        ),
        
        .executable(
            name: "Infomatic",
            targets: [
                "InfomaticTool"
            ]
        )
    ],
    
    dependencies: [
    ],
    
    targets: [
        .plugin(
            name: "InfomaticPlugin",
            capability: .buildTool(),
            dependencies: [
                "InfomaticTool",
            ]
        ),

        .executableTarget(
            name: "InfomaticTool",
            dependencies: [
            ]
        ),
        
    ]
)
