(uiop:define-package #:reblocks-typeahead-docs/index
  (:use #:cl)
  (:import-from #:pythonic-string-reader
                #:pythonic-string-syntax)
  #+quicklisp
  (:import-from #:quicklisp)
  (:import-from #:named-readtables
                #:in-readtable)
  (:import-from #:40ants-doc
                #:defsection
                #:defsection-copy)
  (:import-from #:reblocks-typeahead-docs/changelog
                #:@changelog)
  (:import-from #:docs-config
                #:docs-config)
  (:import-from #:40ants-doc/autodoc
                #:defautodoc)
  (:export #:@index
           #:@readme
           #:@changelog))
(in-package #:reblocks-typeahead-docs/index)

(in-readtable pythonic-string-syntax)


(defmethod docs-config ((system (eql (asdf:find-system "reblocks-typeahead-docs"))))
  ;; 40ANTS-DOC-THEME-40ANTS system will bring
  ;; as dependency a full 40ANTS-DOC but we don't want
  ;; unnecessary dependencies here:
  #+quicklisp
  (ql:quickload "40ants-doc-theme-40ants")
  #-quicklisp
  (asdf:load-system "40ants-doc-theme-40ants")
  
  (list :theme
        (find-symbol "40ANTS-THEME"
                     (find-package "40ANTS-DOC-THEME-40ANTS"))))


(defsection @index (:title "reblocks-typeahead - A Reblocks widget implementing typeahead search."
                    :ignore-words ("JSON"
                                   "HTTP"
                                   "TODO"
                                   "Unlicense"
                                   "REPL"
                                   "GIT")
                    :external-docs
                    ("https://40ants.com/reblocks/"))
  (reblocks-typeahead system)
  "
[![](https://github-actions.40ants.com/40ants/reblocks-typeahead/matrix.svg?only=ci.run-tests)](https://github.com/40ants/reblocks-typeahead/actions)

![Quicklisp](http://quickdocs.org/badge/reblocks-typeahead.svg)
"
  (@installation section)
  (@usage section)
  (@api section))


(defsection-copy @readme @index)


(defsection @installation (:title "Installation")
  """
You can install this library from Quicklisp, but you want to receive updates quickly, then install it from Ultralisp.org:

```
(ql-dist:install-dist "http://dist.ultralisp.org/"
                      :prompt nil)
(ql:quickload :reblocks-typeahead)
```
""")


(defsection @usage (:title "Usage"
                    :ignore-words ("ASDF:PACKAGE-INFERRED-SYSTEM"
                                   "ASDF"
                                   "40A"))
  "
![](https://storage.yandexcloud.net/40ants-blog-images/reblocks-typeahead-example.gif)

To use this library, you need to inherit your widget from REBLOCKS-TYPEAHEAD:TYPEAHEAD-WIDGET
and to provide at least two methods:

- REBLOCKS-TYPEAHEAD:EXECUTE-QUERY which will respond with data for dropdown
- REBLOCKS-TYPEAHEAD:ON-SELECT which will be executed when user has choosen an item from dropdown menu.

See [this example application's code](https://github.com/40ants/reblocks-typeahead/tree/master/example)
to learn how these methods can be implemented.
")


(defautodoc @api (:system "reblocks-typeahead"))
