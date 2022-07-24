import Danger

class PrRule: BaseRule {
    
    var execution: (() -> RuleResult)

    init(name: String,
         message: String? = nil,
         execution: @escaping (() -> RuleResult)) {
        
        self.execution = execution
        super.init(name: name, message: message)
    }
    
    override func run(on files: [File]? = nil) {
        result = execution()
    }
}
