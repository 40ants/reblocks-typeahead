(uiop:define-package #:reblocks-typeahead
  (:use #:cl)
  (:nicknames #:reblocks-typeahead/core)
  (:import-from #:reblocks/widget
                #:defwidget)
  (:import-from #:reblocks-ui)
  (:import-from #:reblocks-ui/form)
  (:import-from #:reblocks/html
                #:with-html)
  (:import-from #:reblocks-typeahead/css
                #:make-css)
  (:import-from #:reblocks-typeahead/js
                #:make-js)
  (:export #:typeahead-widget
           #:execute-query
           #:typeahead-results
           #:results-items
           #:process-typeahead-choice
           #:focus-in))
(in-package #:reblocks-typeahead)


(defwidget typeahead-results (reblocks-ui:ui-widget)
  ((items :initform nil
          :accessor results-items)))


(defwidget typeahead-widget (reblocks-ui:ui-widget)
  ((results :initform (make-instance 'typeahead-results)
            :reader typeahead-results)))


(defgeneric on-select (item)
  (:documentation "Called when user selected an item in the typeahead results.")
  (:method ((item t))
    (log:error "Item ~A was selected." item)
    (values)))


(defgeneric on-empty-selection (widget query)
  (:documentation "Called when user entered some query but didn't selected any item, just pressed Enter.")
  (:method ((widget typeahead-widget) query)
    (log:error "User entered ~S but didn't choose any item." query)
    (values)))


(defgeneric process-typeahead-choice (widget query selected-item-idx)
  (:method ((widget typeahead-widget) query selected-item-idx)
    (log:error "User entered" query selected-item-idx)
    (cond
      (selected-item-idx
       (let* ((items (results-items (typeahead-results widget)))
              (selected-item (nth selected-item-idx items)))
         (on-select selected-item)))
      (t
       (on-empty-selection widget query)))))


(defgeneric update-results (widget query)
  (:method ((widget typeahead-widget) query)
    (log:info "Updating typeahead results using \"~A\"" query)

    (setf (results-items (typeahead-results widget))
          (execute-query widget query))
    (reblocks/widget:update (typeahead-results widget))
    (values)))


(defgeneric execute-query (widget query)
  (:method ((widget typeahead-results) query)
    (list
     (reblocks/widgets/string-widget:make-string-widget
      (format nil "Please, define REBLOCKS-TYPEAHEAD:EXECUTE-QUERY method to process \"~A\""
              query)))))


(defmethod reblocks/widget:render ((widget typeahead-widget))
  (flet ((on-update (&key query &allow-other-keys)
           (update-results widget query)))
    (let ((action-code (reblocks/actions:make-action #'on-update)))
      (reblocks-ui/form:with-html-form (:POST (lambda (&key query result &allow-other-keys)
                                                (process-typeahead-choice widget
                                                                          query
                                                                          (when result
                                                                            (parse-integer result)))))
        (:input :type "text"
                :name "query"
                :data-action-code action-code
                :class "typeahead-input"
                :autocomplete "off")

        (reblocks/widget:render
         (typeahead-results widget))

        (:script (:raw "initTypeaheads()"))))))


(defmethod reblocks/widget:get-css-classes ((widget typeahead-widget))
  ;; Because this widget will be inherited, we need a stable
  ;; CSS class to initialize frontend element:
  (list* "typeahead-widget"
         (call-next-method)))


(defun focus-in (widget)
  (check-type widget typeahead-widget)
  (reblocks/response:send-script
   (format nil "focusInTypeahead(\"~A\")"
           (reblocks/widgets/dom:dom-id widget))))


(defmethod reblocks/widget:render ((widget typeahead-results))
  (let ((items (results-items widget)))
    (reblocks/html:with-html
      (cond
        (items
         (:ul
          (loop for item in items
                for idx upfrom 0
                do (:li (:input :type "radio"
                                :name "result"
                                :id (format nil "choice-~A" idx)
                                :onchange "this.form.onsubmit()"
                                :value idx)
                        (:label :for (format nil "choice-~A" idx)
                                (reblocks/widget:render item))))))
        (t
         (:p "No results."))))))


(defmethod reblocks/dependencies:get-dependencies ((widget typeahead-widget))
  (list* (make-css)
         (make-js)
         (call-next-method)))
