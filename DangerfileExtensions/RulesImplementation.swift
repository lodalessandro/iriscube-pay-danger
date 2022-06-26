//MARK: Big pull request
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

let bigPrRule: PrRule = .init(name: "Big pull request", execution: bigPr)


//MARK: Pull request has assignee
var prAssignee: () -> RuleResult = {
    if (danger.github.pullRequest.assignee == nil) {
        return .warn
    }
    return .success
}

let prAssigneeRule: PrRule = .init(name: "Pull request has assignee",
                                   warnMessage: "Please assign someone to merge this PR",
                                   execution: prAssignee)


//MARK: Force unwrapped optional
let forceUnwrapRule: RegexRule = .init(name: "Force unwrapped optional",
                                       failMessage: "Found one or more force unwrapped optional values, please review your code",
                                       regex: "([A-z]+[A-Za-z0-9]*![.,:)\n\t\r ])")
