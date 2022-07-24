import Danger

class BaseRule {
    var name: String
    var message: String?
    var result: RuleResult?
    
    init(name: String,
         message: String? = nil) {
        self.name = name
        self.message = message
    }
    
    func run(on files: [File]?) {}
}
