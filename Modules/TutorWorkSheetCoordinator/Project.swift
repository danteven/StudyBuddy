import ProjectDescription

let project = Project(
    name: "TutorWorkSheetCoordinator",
    organizationName: "StuddyBuddy",
    packages: [
        
    ],
    targets: [
        Target(
            name: "TutorWorkSheetCoordinator",
            platform: .iOS,
            product: .staticFramework,
            bundleId: "StudyBuddy.tutorWorksheet",
            deploymentTarget: .iOS(targetVersion: "13.0", devices: .iphone),
            sources: ["Source/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Common", path: "../../Common"),
                
            ]
        )
    ]
)
