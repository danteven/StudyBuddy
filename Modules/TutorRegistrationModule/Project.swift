import ProjectDescription

let project = Project(
    name: "TutorRegistrationModule",
    organizationName: "StuddyBuddy",
    packages: [
        
    ],
    targets: [
        Target(
            name: "TutorRegistrationModule",
            platform: .iOS,
            product: .staticFramework,
            bundleId: "StudyBuddy.tutorRegistrationModule",
            deploymentTarget: .iOS(targetVersion: "13.0", devices: .iphone),
            sources: ["Source/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Common", path: "../../Common"),
                
            ]
        )
    ]
)
