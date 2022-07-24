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
