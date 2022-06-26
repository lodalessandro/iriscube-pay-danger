import Danger

protocol BaseRule {
    
    var name: String { get set }
    var successMessage: String? { get set }
    var warnMessage: String? { get set }
    var failMessage: String? { get set }
    
    func run(on files: [File]?) -> RuleResult
}
