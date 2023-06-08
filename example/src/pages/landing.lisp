(uiop:define-package #:reblocks-typeahead-example/pages/landing
  (:use #:cl)
  (:import-from #:spinneret/cl-markdown)
  (:import-from #:reblocks/widget
                #:update
                #:render
                #:defwidget)
  (:import-from #:reblocks/dependencies
                #:get-dependencies)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks-ui
                #:ui-widget)
  (:import-from #:serapeum
                #:fmt)
  (:import-from #:reblocks-lass)
  (:import-from #:reblocks-ui/form
                #:with-html-form)
  (:import-from #:reblocks-typeahead-example/widgets/search
                #:make-search-widget))
(in-package #:reblocks-typeahead-example/pages/landing)


(defwidget landing-page (ui-widget)
  ((search :initform (make-search-widget)
           :reader search-widget)))


(defun make-landing-page ()
  (make-instance 'landing-page))


(defmethod render ((widget landing-page))
  (render (search-widget widget)))


(defmethod get-dependencies ((widget landing-page))
  (list*
   (reblocks-lass:make-dependency
     `(.landing-page
       :padding 1rem
       ((:and p :last-child)
        :margin-bottom 0)))
   (call-next-method)))
