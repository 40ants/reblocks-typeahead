(uiop:define-package #:reblocks-typeahead/css
  (:use #:cl)
  (:import-from #:reblocks-lass))
(in-package #:reblocks-typeahead/css)


(defun make-css ()
  (reblocks-lass:make-dependency
    '(body
      (.typeahead-widget
      
       ((.typeahead-results > ul)
        :list-style-type none
        :margin 0
        :padding 0)
      
       ((.typeahead-results > ul > li > label)
        :font-size 1.5rem)
      
       ((.typeahead-results > ul > li > input)
        :display none)
      
       ((.typeahead-results > ul > li.active)
        :background-color "#1779ba")
      
       ((.typeahead-results > ul > li.active > label)
        :color "#fefefe")))))
