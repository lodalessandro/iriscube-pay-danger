import Danger

class PrRule: BaseRule {
    
    var name: String
    var successMessage: String?
    var warnMessage: String?
    var failMessage: String?
    var execution: (() -> RuleResult)

    init(name: String,
         successMessage: String? = nil,
         warnMessage: String? = nil,
         failMessage: String? = nil,
         execution: @escaping (() -> RuleResult)) {
        self.name = name
        self.successMessage = successMessage
        self.warnMessage = warnMessage
        self.failMessage = failMessage
        self.execution = execution
    }
    
    func run(on files: [File]? = nil) -> RuleResult {
        return execution()
    }
}
