import Danger

//MARK: Big pull request --------------------------------------------------------------------------
var bigPr: () -> RuleResult = {
    let bigPRThreshold = 300
    
    guard let addition = danger.github.pullRequest.additions,
          let deletions = danger.github.pullRequest.deletions else {
              return .success
          }
    
    if addition + deletions > bigPRThreshold {
        return .warn
    }
    
    return .success
}

let bigPrRule: PrRule = .init(name: "Big pull request",
                              message: "Please avoid pull request with too many additions or deletions",
                              execution: bigPr)


//MARK: Pull request has assignee -----------------------------------------------------------------
var prAssignee: () -> RuleResult = {
    guard let _ = danger.github.pullRequest.assignee else {
        return .warn
    }
    
    return .success
}

let prAssigneeRule: PrRule = .init(name: "Pull request has assignee",
                                   message: "Please assign someone to merge this PR",
                                   execution: prAssignee)


//MARK: Pull request has too much commit ----------------------------------------------------------

var prHasTooManyCommits: () -> RuleResult = {
    guard let commitCount = danger.github.pullRequest.commitCount,
          commitCount < 10
    else {
        return .warn
    }
    
    return .success
}

let prHasTooManyCommitsRule: PrRule = .init(name: "Pull request has too many commits",
                                            message: "Please avoid pull request with large amount of commits",
                                            execution: prHasTooManyCommits)


//MARK: Pull request has message ------------------------------------------------------------------

var prHasDescription: () -> RuleResult = {
    guard let bodySize = danger.github.pullRequest.body?.count else {
        return .warn
    }
    
    return bodySize > 10 ? .success : .warn
}

let prHasDescriptionRule: PrRule = .init(name: "Pull request has description",
                                         message: "Please provide a summary in the Pull Request description",
                                         execution: prHasDescription)


//MARK: Force unwrapped optional ------------------------------------------------------------------
let forceUnwrapRule: RegexRule = .init(name: "Force unwrapped optional",
                                       message: "Found one or more force unwrapped optional values, please review your code",
                                       regex: "([A-z]+[A-Za-z0-9]*![.,:)\n\t\r ])",
                                       regexMatchResult: .fail)


//MARK: class Protocol rule -----------------------------------------------------------------------
let classProtocolRule: RegexRule = .init(name: "class protocol rule",
                                         message: "Using 'class' keyword to define a class-constrained protocol is deprecated; use 'AnyObject' instead",
                                         regex: "protocol .+: +class",
                                         regexMatchResult: .warn)


//MARK: big file ----------------------------------------------------------------------------------
let bigFile: ([File]) -> RuleResult = {
    var result: RuleResult = .success
    
    $0.forEach { file in
        let fileString = danger.utils.readFile(file)
        if fileString.numberOfLines() > 100 {
            result = .warn
            return
        }
    }
    
    return result
}

let bigFileRule: FileRule = .init(name: "big file rule",
                                  message: "Files should contains less then 100 lines of code",
                                  execution: bigFile)


// MARK: todo mark --------------------------------------------------------------------------------
let todoMarkRule: RegexRule = .init(name: "todo mark rule",
                                    message: "Found todo mark, please check it",
                                    regex: #"\/\/ TODO: .*"#,
                                    regexMatchResult: .warn)


// MARK: xCode project not updated ----------------------------------------------------------------
let xCodeProjectNotUpdated: () -> RuleResult = {
    let addedSources = danger.git.createdFiles.contains { $0.fileType == .swift }
    let deletedSources = danger.git.deletedFiles.contains { $0.fileType == .swift }
    let isXcodeProjectUpdated = danger.git.modifiedFiles.contains { $0.contains(".xcodeproj") }
    
    return (addedSources || deletedSources) && !isXcodeProjectUpdated ? .fail : .success
}

let xCodeProjectNotUpdatedRule: PrRule = .init(name: "Xcode project not updated rule",
                                               message: "If source files are added or deleted the Xcode project needs to be updated.",
                                               execution: xCodeProjectNotUpdated)

// MARK: locked files edited ----------------------------------------------------------------------
let lockedFiles: ([File]) -> RuleResult = { files in
    var result: RuleResult = .success
    
    let lockedFolders = danger.utils.readFile("DangerLockedFolders.txt").toArray(separatedBy: "\n")
    
    return files.contains { file in
        lockedFolders.contains { lockedFolder in
        file.contains(lockedFolder)
    }
        
    } ? .fail : .success
}

let lockedFilesRule: FileRule = .init(name: "locked file rule",
                                      message: "Those files are locked and cannot be modified or deleted",
                                      execution: lockedFiles)


