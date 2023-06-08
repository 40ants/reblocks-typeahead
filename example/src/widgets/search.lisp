(uiop:define-package #:reblocks-typeahead-example/widgets/search
  (:use #:cl)
  (:import-from #:reblocks-typeahead
                #:typeahead-widget)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:alexandria
                #:curry)
  (:import-from #:str
                #:containsp)
  (:import-from #:reblocks/widgets/string-widget
                #:get-content
                #:make-string-widget)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:serapeum
                #:push-end-new))
(in-package #:reblocks-typeahead-example/widgets/search)


(defvar *countries*
  (uiop:read-file-lines
   (asdf:system-relative-pathname "reblocks-typeahead-example"
                                  "src/widgets/countries.txt")))

(defwidget search-widget (typeahead-widget)
  ((selected-countries :initform nil
                       :accessor selected-countries)))


(defun make-search-widget ()
  (make-instance 'search-widget))


(defmethod reblocks/widget:render ((widget search-widget))
  (with-html
    (when (selected-countries widget)
      (:ul :class "countries"
           (loop for name in (selected-countries widget)
                 do (:li name))))
    (call-next-method)))


(defmethod reblocks/dependencies:get-dependencies ((widget search-widget))
  (list*
   (reblocks-lass:make-dependency
     `(.search-widget
       (.countries
        :display flex
        :list-style-type none
        :margin-left 0
        ((> li)
         :margin-left 1rem
         :background orange
         :color "#337"
         :padding 0.2rem 0.5rem 0.2rem 0.5rem
         :border 1px solid dark-orange
         :border-radius 0.5rem)
        ((>
          (:and li
           :first-child))
         :margin-left 0))))
   (call-next-method)))


;; Methods for making typeahead work:

(defmethod reblocks-typeahead:execute-query ((widget search-widget) query)
  (let ((str:*ignore-case* t))
    (mapcar #'make-string-widget
            (remove-if-not (curry #'containsp query)
                           *countries*))))

(defmethod reblocks-typeahead:on-select ((widget search-widget) item)
  (push-end-new (get-content item)
                (selected-countries widget)
                :test #'string-equal)
  (reblocks-typeahead:hide-results widget)
  (reblocks/widget:update widget))
