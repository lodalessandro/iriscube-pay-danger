import Danger

class PrRule: BaseRule {
    
    var name: String
    var message: String?
    var execution: (() -> RuleResult)

    init(name: String,
         message: String? = nil,
         execution: @escaping (() -> RuleResult)) {
        self.name = name
        self.message = message
        self.execution = execution
    }
    
    func run(on files: [File]? = nil) -> RuleResult {
        return execution()
    }
}
