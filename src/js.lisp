(uiop:define-package #:reblocks-typeahead/js
  (:use #:cl)
  (:import-from #:reblocks-parenscript)
  (:import-from #:parenscript
                #:create
                #:@
                #:chain))
(in-package #:reblocks-typeahead/js)


(defun make-js ()
  (reblocks-parenscript:make-dependency

    (defun focus-in-typeahead (element-id)
      (chain console
             (log "Focusing in typeahead" element-id))
      (let* ((typeahead (chain document
                               (get-element-by-id element-id)))
             (input (chain typeahead
                           (query-selector ".typeahead-input"))))
        (chain input
               (focus))))

    (defun update-typeahead-results (autocompletion-input query)
      (initiate-action (@ autocompletion-input dataset action-code)
                       (create :args (create :query query))))
    
    (defun schedule-update (event)
      (let* ((autocompletion-input (@ event target))
             (timer-id (@ autocompletion-input timer-id)))
        (when timer-id
          (clear-timeout timer-id))
        (setf (@ autocompletion-input timer-id)
              (set-timeout (lambda ()
                             (update-typeahead-results
                              autocompletion-input
                              (@ autocompletion-input value)))
                           250))))

    (defun select-previous-item (typeahead)
      (select-next-or-previous-item typeahead nil))

    (defun select-next-item (typeahead)
      (select-next-or-previous-item typeahead t))
    
    (defun select-next-or-previous-item (typeahead down-p)
      (chain console
             (log "Selecting next item" typeahead down-p))
      (let ((current-item (chain typeahead
                                 (query-selector ".typeahead-results > ul > li.active"))))
        (flet ((select (item)
                 (when item
                   (chain item
                          class-list
                          (add "active"))
                   (let ((input (chain item
                                       (query-selector "input"))))
                     (setf (@ input checked) t))))
               (deselect (item)
                 (when item
                   (chain item
                          class-list
                          (remove "active"))
                   (let ((input (chain item
                                       (query-selector "input"))))
                     (setf (@ input checked) nil)))))
          (cond
            (current-item
             (let ((next-item (if down-p
                                  (@ current-item next-sibling)
                                  (@ current-item previous-sibling))))
               (when (and next-item
                          (equal (@ next-item tag-name)
                                 "LI"))
                 (deselect current-item)
                 (select next-item))))
            (t
             (let ((first-item (chain typeahead
                                      (query-selector ".typeahead-results > ul > li"))))
               (select first-item)))))))

    (defun init-typeahead (typeahead)
      (unless (@ typeahead dataset initialized)
        (chain console
               (log "Initializing typeahead"
                    typeahead))
        (let ((input (chain typeahead
                            (query-selector ".typeahead-input"))))
          (chain input
                 (add-event-listener "input"
                                     (lambda (event)
                                       (when (eql (@ event target)
                                                  input)
                                         (schedule-update event)))))
          (chain typeahead
                 (add-event-listener "keydown"
                                     (lambda (event)
                                       ;; (chain console (log "KEY CODE" (@ event target)))
                                       (when (or (eql (@ event target)
                                                      typeahead)
                                                 (eql (@ event target)
                                                      input))
                                         (let ((key-code (@ event key-code)))
                                           ;; (chain console (log "KEY CODE" key-code))
                                           (case key-code
                                             (38
                                              (select-previous-item typeahead)
                                              (chain event (prevent-default)))
                                             (40
                                              (select-next-item typeahead)
                                              (chain event (prevent-default)))))))))
          (setf (@ typeahead dataset initialized)
                t))))

    (defun init-typeaheads ()
      (chain console
             (log "Initializing typeaheads"))
      
      (chain document
             (query-selector-all ".typeahead-widget")
             (for-each init-typeahead)))
    
    (chain window
           (add-event-listener
            "load"
            init-typeaheads))))
