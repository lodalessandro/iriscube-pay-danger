import Danger

let danger = Danger()

let allSourceFiles = danger.git.modifiedFiles + danger.git.createdFiles
let createdFiles = danger.git.createdFiles
let modifiedFiles = danger.git.modifiedFiles

if !createdFiles.isEmpty {
    print("Added files:")
    createdFiles.forEach {
        message("- \($0.name)")
    }
}

if !modifiedFiles.isEmpty {
    print("Edited files:")
    modifiedFiles.forEach {
        print("- \($0.name)")
    }
}

let forceUnwrapRegex = "([A-z]+[A-Za-z0-9]*![.,:)\n\t\r ])"

allSourceFiles.forEach {
    let result = danger.utils.readFile($0).range(of: forceUnwrapRegex,
                                                 options: .regularExpression) != nil
    if result {
        fail("Found force unwrapped optional value")
    }
}

