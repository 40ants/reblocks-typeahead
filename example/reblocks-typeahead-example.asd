#-asdf3.1 (error "reblocks-auth-example requires ASDF 3.1 because for lower versions pathname does not work for package-inferred systems.")
(defsystem "reblocks-typeahead-example"
  :description "A demo site showing how to use reblocks-typeahead system."
  :author "Alexander Artemenko <svetlyak.40wt@gmail.com>"
  :license "Unlicense"
  :class :40ants-asdf-system
  :defsystem-depends-on ("40ants-asdf-system")
  :pathname "src"
  :depends-on ("reblocks"
               "reblocks-typeahead-example/server"))
