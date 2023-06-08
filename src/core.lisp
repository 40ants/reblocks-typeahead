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
           #:focus-in
           #:input-value
           #:placeholder
           #:on-select
           #:on-empty-selection
           #:update-results
           #:hide-results))
(in-package #:reblocks-typeahead)


(defwidget typeahead-results (reblocks-ui:ui-widget)
  ((items :initform nil
          :accessor results-items)))


(defwidget typeahead-widget (reblocks-ui:ui-widget)
  ((results :initform (make-instance 'typeahead-results)
            :reader typeahead-results)
   (placeholder :initform nil
                :initarg :placeholder
                :accessor placeholder)
   (value :initform nil
          :initarg :value
          :accessor input-value))
  (:documentation "Base class for custom typeahead widgets.

                   Define you own widget class based on the TYPEAHEAD-WIDGET
                   and also define methods for following generic-functions.

                   Mandatory:

                   - EXECUTE-QUERY

                   Optional:

                   - ON-SELECT
                   - ON-EMPTY-SELECTION
                   - PROCESS-TYPEAHEAD-CHOICE
                   - UPDATE-RESULTS
                   - HIDE-RESULTS"))


(defgeneric on-select (widget item)
  (:documentation "Called when user selected an item in the typeahead results.")
  (:method ((widget typeahead-widget)
            (item t))
    (log:debug "Item ~A was selected." item)
    (hide-results widget)
    (values)))


(defgeneric on-empty-selection (widget query)
  (:documentation "Called when user entered some query but didn't selected any item, just pressed Enter.")
  (:method ((widget typeahead-widget) query)
    (log:debug "User entered ~S but didn't choose any item." query)
    (hide-results widget)
    (values)))


(defgeneric process-typeahead-choice (widget query selected-item-idx)
  (:documentation "Calls either ON-SELECT or ON-EMPTY-SELECTION depending on if user has choosen an item from the dropdown.")
  (:method ((widget typeahead-widget) query selected-item-idx)
    (log:debug "User entered" query selected-item-idx)
    (cond
      (selected-item-idx
       (let* ((items (results-items (typeahead-results widget)))
              (selected-item (nth selected-item-idx items)))
         (log:debug "Opening selected item" selected-item)
         (on-select widget selected-item)))
      (t
       (log:debug "Opening empty selection")
       (on-empty-selection widget query)))))


(defgeneric update-results (widget query)
  (:documentation "Calls EXECUTE-QUERY generic-function and updates the dropdown widget.")
  (:method ((widget typeahead-widget) query)
    (log:info "Updating typeahead results using \"~A\"" query)

    (setf (results-items (typeahead-results widget))
          (execute-query widget query))
    (reblocks/widget:update (typeahead-results widget))
    (values)))


(defgeneric hide-results (widget)
  (:documentation "Hides dropdown widget. Call this method from a custom ON-SELECT or ON-EMPTY-SELECTION methods.")
  (:method ((widget typeahead-widget))
    (log:info "Hiding typeahead results.")

    (setf (results-items (typeahead-results widget))
          nil)
    (reblocks/widget:update (typeahead-results widget))
    (values)))


(defgeneric execute-query (widget query)
  (:documentation "A method for this generic-function should return a list of widgets to be shown in reponse to the given text query.
                   This method should return a list of widgets.
                   To make simple widgets out of strings, you can use
                   REBLOCKS/WIDGETS/STRING-WIDGET:MAKE-STRING-WIDGET function.")
  (:method ((widget typeahead-widget) query)
    (list
     (reblocks/widgets/string-widget:make-string-widget

      (let ((class-name (class-name (class-of widget))))
        (if (eql class-name 'typeahead-widget)
            (format nil "Please, define a subclass REBLOCKS-TYPEAHEAD:TYPEAHEAD-WIDGET for and a method REBLOCKS-TYPEAHEAD:EXECUTE-QUERY to process \"~A\" query."
                    query)
            (format nil "Please, define REBLOCKS-TYPEAHEAD:EXECUTE-QUERY method to process \"~A\" query on ~A widget."
                    query
                    (class-name (class-of widget)))))))))


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
                :placeholder (placeholder widget)
                :value (input-value widget)
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
      (when items
        (:ul
         (loop with widget-id = (reblocks/widgets/dom:dom-id widget)
               for item in items
               for idx upfrom 0
               for item-id = (format nil "~A-choice-~A"
                                     ;; It is important to generate unique
                                     ;; id for each item even when there is
                                     ;; more than one typeahead widget on a page:
                                     widget-id
                                     idx)
               do (:li (:input :type "radio"
                               :name "result"
                               :id item-id
                               :onchange "this.form.onsubmit()"
                               :value idx)
                       (:label :for item-id
                               (reblocks/widget:render item)))))))))


(defmethod reblocks/dependencies:get-dependencies ((widget typeahead-widget))
  (list* (make-css)
         (make-js)
         (call-next-method)))
