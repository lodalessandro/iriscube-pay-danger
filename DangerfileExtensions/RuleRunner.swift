import Danger

typealias RunnableRule = RuleRunner.RunnableRule

class RuleRunner {
    
    let createdFiles: [File]
    let modifiedFiles: [File]
    let deletedFiles: [File]
    
    var debugMessages: [RuleResult : [String]] = [:]
    
    init() {
        createdFiles = danger.git.createdFiles
        modifiedFiles =  danger.git.modifiedFiles
        deletedFiles = danger.git.deletedFiles
    }
    
    func runRule(from runnableRule: RunnableRule) {
        let rule = runnableRule.rule
        rule.run(created: createdFiles, modified: modifiedFiles, deleted: deletedFiles)
        
        guard let result = rule.result else { return }
        
        var resultMessage: String = ""
        
        switch result {
            
        case .success:
            resultMessage = "\(rule.name) success"
            resultMessage = "✅ \(resultMessage)"
            
        case .warn:
            resultMessage = rule.message ?? "\(rule.name) warning"
            warn(resultMessage)
            resultMessage = "⚠️ \(resultMessage)"
            
        case .fail:
            resultMessage = rule.message ?? "\(rule.name) failure"
            fail(resultMessage)
            resultMessage = "❌ \(resultMessage)"
        }
        
        debugMessages[result]?.append(resultMessage)
    }
    
    func runRules(from runnableRules: [RunnableRule]) {
        
        debugMessages[.success] = []
        debugMessages[.warn] = []
        debugMessages[.fail] = []
        
        runnableRules.forEach {
            runRule(from: $0)
        }
    }
    
    func printDebugMessages() {
        debugMessages[.success]?.prettyPrint()
        debugMessages[.warn]?.prettyPrint()
        debugMessages[.fail]?.prettyPrint()
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
        case lockedFiles
        
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
            case .lockedFiles:
                return lockedFilesRule
            }
        }
    }
}
