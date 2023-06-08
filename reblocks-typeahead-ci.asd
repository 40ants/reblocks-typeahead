(defsystem "reblocks-typeahead-ci"
  :author "Alexander Artemenko <svetlyak.40wt@gmail.com>"
  :license "Unlicense"
  :homepage "https://40ants.com/reblocks-typeahead/"
  :class :package-inferred-system
  :description "Provides CI settings for reblocks-typeahead."
  :source-control (:git "https://github.com/40ants/reblocks-typeahead")
  :bug-tracker "https://github.com/40ants/reblocks-typeahead/issues"
  :pathname "src"
  :depends-on ("40ants-ci"
               "reblocks-typeahead-ci/ci"))
