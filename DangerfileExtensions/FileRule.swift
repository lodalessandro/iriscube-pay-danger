import Danger

class FileRule: BaseRule {
    
    var execution: (([File], [File], [File]) -> RuleResult)

    init(name: String,
         message: String? = nil,
         execution: @escaping (([File], [File], [File]) -> RuleResult)) {
        
        self.execution = execution
        super.init(name: name, message: message)
    }
    
    override func run(created: [File]?,
                      modified: [File]?,
                      deleted: [File]?) {
        
        guard let created = created,
              let modified = modified,
              let deleted = deleted else {
            return
        }
        
        result = execution(created, modified, deleted)
    }
}

