(uiop:define-package #:reblocks-typeahead-docs/changelog
  (:use #:cl)
  (:import-from #:40ants-doc/changelog
                #:defchangelog))
(in-package #:reblocks-typeahead-docs/changelog)


(defchangelog (:ignore-words ("SLY"
                              "ASDF"
                              "REPL"
                              "HTTP"))
  (0.2.0 2023-06-08
         "## Changes

          * Generic-function REBLOCKS-TYPEAHEAD:ON-SELECT now accepts two arguments and the first one is a typeahead widget.
          * Default methods REBLOCKS-TYPEAHEAD:ON-SELECT and REBLOCKS-TYPEAHEAD:ON-EMPTY-SELECTION now close search results.")
  
  (0.1.0 2023-02-05
         "* Initial version."))
