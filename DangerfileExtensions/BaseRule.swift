import Danger

protocol BaseRule {
    
    var name: String { get set }
    var message: String? { get set }
    
    func run(on files: [File]?) -> RuleResult
}
