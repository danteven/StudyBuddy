import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

/*
                +-------------+
                |             |
                |     App     | Contains StudyBuddy App target and StudyBuddy unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers

let target = Target(
    name: "StudyBuddy",
    platform: .iOS,
    product: .app,
    bundleId: "StudyBuddy",
    deploymentTarget: .iOS(targetVersion: "13.0", devices: .iphone),
    infoPlist: "Info.plist",
    sources: ["StudyBuddy/**"],
    resources: [
        "StudyBuddy/Resources/**",
        "StudyBuddy/**/*.storyboard"
    ],
    dependencies: [
        .project(target: "SignInCoordinator", path: "Modules/SignInCoordinator"),
        .project(target: "Common", path: "Common"),
        .project(target: "TutorWorkSheetCoordinator", path: "Modules/TutorWorkSheetCoordinator"),
        .project(target: "TutorRegistrationModule", path: "Modules/TutorRegistrationModule")
    ]
)

let project = Project(
    name: "StudyBuddy",
    targets: [target]
)
