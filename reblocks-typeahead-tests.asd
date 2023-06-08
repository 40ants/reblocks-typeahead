(defsystem "reblocks-typeahead-tests"
  :author "Alexander Artemenko <svetlyak.40wt@gmail.com>"
  :license "Unlicense"
  :homepage "https://40ants.com/reblocks-typeahead/"
  :class :package-inferred-system
  :description "Provides tests for reblocks-typeahead."
  :source-control (:git "https://github.com/40ants/reblocks-typeahead")
  :bug-tracker "https://github.com/40ants/reblocks-typeahead/issues"
  :pathname "t"
  :depends-on ("reblocks-typeahead-tests/core")
  :perform (test-op (op c)
                    (unless (symbol-call :rove :run c)
                      (error "Tests failed"))))
