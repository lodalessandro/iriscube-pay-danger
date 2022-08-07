import Danger

class FileRule: BaseRule {
    
    var execution: (([File]) -> RuleResult)

    init(name: String,
         message: String? = nil,
         execution: @escaping (([File]) -> RuleResult)) {
        
        self.execution = execution
        super.init(name: name, message: message)
    }
    
    override func run(on files: [File]? = nil) {
        guard let files = files else { return }
        result = execution(files)
    }
}

