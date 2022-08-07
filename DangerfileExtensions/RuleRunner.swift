import Danger

typealias RunnableRule = RuleRunner.RunnableRule

class RuleRunner {
    
    
    let allSourceFiles: [File]
    let createdFiles: [File]
    let modifiedFiles: [File]
    
    init() {
        createdFiles = danger.git.createdFiles
        modifiedFiles =  danger.git.modifiedFiles
        allSourceFiles = createdFiles + modifiedFiles
    }
    
    func runRule(from runnableRule: RunnableRule) {
        let rule = runnableRule.rule
        rule.run(on: allSourceFiles)
        
        guard let result = rule.result else { return }
        
        switch result {
            
        case .success:
            let resultMessage = "\(rule.name) success"
            message("✓ \(resultMessage)")
        case .warn:
            let resultMessage = rule.message ?? "\(rule.name) warning"
            warn("⚠ \(resultMessage)")
        case .fail:
            let resultMessage = rule.message ?? "\(rule.name) failure"
            fail("ⓧ \(resultMessage)")
        }
    }
    
    func runRules(from runnableRules: [RunnableRule]) {
        runnableRules.forEach {
            runRule(from: $0)
        }
    }
}


extension RuleRunner {
    enum RunnableRule {
        case bigPullRequest
        case forceUnwrappedOptional
        case prHasAssignee
        case prHasDescription
        case classProtocol
        case prHasTooManyCommits
        
        var rule: BaseRule {
            switch self {
            case .bigPullRequest:
                return bigPrRule
            case .forceUnwrappedOptional:
                return forceUnwrapRule
            case .prHasAssignee:
                return prAssigneeRule
            case .prHasDescription:
                return prHasDescriptionRule
            case .classProtocol:
                return classProtocolRule
            case .prHasTooManyCommits:
                return prHasTooManyCommitsRule
            }
        }
    }
}
