import Danger

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
        let result = rule.run(on: allSourceFiles)
        
        switch result {
        case .success:
            let successMessage = rule.successMessage ?? "\(rule.name) success"
            message("✓ \(successMessage)")
            
        case .warn:
            let warnMessage = rule.warnMessage ?? "\(rule.name) warning"
            warn("⚠ \(warnMessage)")
            
        case .fail:
            let failMessage = rule.failMessage ?? "\(rule.name) failure"
            fail("ⓧ \(failMessage)")
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
        
        var rule: BaseRule {
            switch self {
            case .bigPullRequest:
                return bigPrRule
            case .forceUnwrappedOptional:
                return forceUnwrapRule
            case .prHasAssignee:
                return prAssigneeRule
            }
        }
    }
}
