import Danger

class PrRule: BaseRule {
    
    var execution: (() -> RuleResult)

    init(name: String,
         message: String? = nil,
         execution: @escaping (() -> RuleResult)) {
        
        self.execution = execution
        super.init(name: name, message: message)
    }
    
    
    override func run(created: [File]? = nil,
                      modified: [File]? = nil,
                      deleted: [File]? = nil) {
        result = execution()
    }
}
