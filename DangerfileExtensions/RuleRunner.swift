import Danger

typealias RunnableRule = RuleRunner.RunnableRule

class RuleRunner {
    
    let allSourceFiles: [File]
    let createdFiles: [File]
    let modifiedFiles: [File]
    
    var resultMessages: [RuleResult : [String]] = [:]
    
    init() {
        createdFiles = danger.git.createdFiles
        modifiedFiles =  danger.git.modifiedFiles
        allSourceFiles = createdFiles + modifiedFiles
    }
    
    func runRule(from runnableRule: RunnableRule) {
        let rule = runnableRule.rule
        rule.run(on: allSourceFiles)
        
        guard let result = rule.result else { return }
        
        var resultMessage: String = ""
        
        switch result {
            
        case .success:
            resultMessage = "\(rule.name) success"
            resultMessage = "✅ \(resultMessage)"
            
        case .warn:
            resultMessage = rule.message ?? "\(rule.name) warning"
            resultMessage = "⚠️ \(resultMessage)"
            
        case .fail:
            resultMessage = rule.message ?? "\(rule.name) failure"
            resultMessage = "❌ \(resultMessage)"
        }
        
        resultMessages[result]?.append(resultMessage)
    }
    
    func runRules(from runnableRules: [RunnableRule]) {
        
        resultMessages = [:]
        
        runnableRules.forEach {
            runRule(from: $0)
        }
    }
    
    func printMessages() {
        resultMessages[.success]?.prettyPrint()
        resultMessages[.warn]?.prettyPrint()
        resultMessages[.fail]?.prettyPrint()

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
        case bigFile
        case todoMark
        case xCodeProjectNotUpdated
        
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
            case .bigFile:
                return bigFileRule
            case .todoMark:
                return todoMarkRule
            case .xCodeProjectNotUpdated:
                return xCodeProjectNotUpdatedRule
            }
        }
    }
}
