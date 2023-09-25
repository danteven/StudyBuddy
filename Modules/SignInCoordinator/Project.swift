import ProjectDescription

let project = Project(
    name: "SignInCoordinator",
    organizationName: "OneGo",
    packages: [
        .package(url: "https://github.com/marmelroy/PhoneNumberKit.git", .upToNextMajor(from: "3.5.0"))
    ],
    targets: [
        Target(
            name: "SignInCoordinator",
            platform: .iOS,
            product: .staticFramework,
            bundleId: "io.tuist.StudyBuddy.signIn",
            deploymentTarget: .iOS(targetVersion: "13.0", devices: .iphone),
            sources: ["Source/**"],
            resources: ["Resources/**"],
            dependencies: [
                .package(product: "PhoneNumberKit"),
                .project(target: "Common", path: "../../Common"),
                
            ]
        )
    ]
)
