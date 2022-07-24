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
        var resultMessage: String = ""
        
        switch result {
            
        case .success:
            resultMessage = "\(rule.name) success"
            message("✓ \(resultMessage)")
        case .warn:
            resultMessage = rule.message ?? "\(rule.name) warning"
            warn("⚠ \(resultMessage)")
        case .fail:
            resultMessage = rule.message ?? "\(rule.name) failure"
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
            }
        }
    }
}
