import ProjectDescription

let project = Project(
    name: "Common",
    organizationName: "StuddyBuddy",
    packages: [
    ],
    targets: [
        Target(
            name: "Common",
            platform: .iOS,
            product: .staticFramework,
            bundleId: "io.tuist.StudyBuddy.common",
            deploymentTarget: .iOS(targetVersion: "13.0", devices: .iphone),
            sources: ["Common/**"],
            resources: ["Common/Resources/**"],
            dependencies: [
                
            ]
        )
    ]
)
