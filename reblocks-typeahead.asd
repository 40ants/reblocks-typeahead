#-asdf3.1 (error "reblocks-typeahead requires ASDF 3.1 because for lower versions pathname does not work for package-inferred systems.")
(defsystem "reblocks-typeahead"
  :description "A Reblocks widget implementing typeahead search."
  :author "Alexander Artemenko <svetlyak.40wt@gmail.com>"
  :license "Unlicense"
  :homepage "https://40ants.com/reblocks-typeahead/"
  :source-control (:git "https://github.com/40ants/reblocks-typeahead")
  :bug-tracker "https://github.com/40ants/reblocks-typeahead/issues"
  :class :40ants-asdf-system
  :defsystem-depends-on ("40ants-asdf-system")
  :pathname "src"
  :depends-on ("reblocks-typeahead/core")
  :in-order-to ((test-op (test-op "reblocks-typeahead-tests"))))
