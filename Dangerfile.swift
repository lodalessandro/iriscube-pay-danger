import Danger

// fileImport: DangerfileExtensions/BaseRule.swift
// fileImport: DangerfileExtensions/PrRule.swift
// fileImport: DangerfileExtensions/RegexRule.swift
// fileImport: DangerfileExtensions/FileRule.swift
// fileImport: DangerfileExtensions/RuleResult.swift
// fileImport: DangerfileExtensions/RuleRunner.swift
// fileImport: DangerfileExtensions/RulesImplementation.swift
// fileImport: DangerfileExtensions/Extensions.swift


let danger = Danger()

let rules: [RunnableRule] = [ .bigPullRequest,
                              .prHasAssignee,
                              .prHasDescription,
                              .prHasTooManyCommits,
                              .forceUnwrappedOptional,
                              .classProtocol,
                              .bigFile,
                              .todoMark,
                              .xCodeProjectNotUpdated  ]

let ruleRunner: RuleRunner = .init()
ruleRunner.runRules(from: rules)

SwiftLint.lint(inline: true, configFile: "swiftlint.yml")

