(uiop:define-package #:reblocks-typeahead-example/app
  (:use #:cl)
  (:import-from #:reblocks)
  (:import-from #:reblocks-auth)
  (:import-from #:reblocks-navigation-widget
                #:defroutes)
  (:import-from #:reblocks-prometheus
                #:prometheus-app-mixin)
  (:import-from #:reblocks/app
                #:defapp)
  (:import-from #:reblocks-typeahead-example/pages/landing
                #:make-landing-page)
  (:import-from #:reblocks/page
                #:init-page)
  (:import-from #:reblocks-typeahead-example/widgets/frame
                #:make-page-frame))
(in-package #:reblocks-typeahead-example/app)


(defapp app
  :subclasses (prometheus-app-mixin)
  :prefix "/")


(defroutes routes
    ("/" (make-page-frame
          (make-landing-page)))
  ("/login"
   (make-page-frame
    (reblocks-auth:make-login-processor)))
  ("/logout"
   (make-page-frame
    (reblocks-auth:make-logout-processor))))


(defmethod init-page ((app app) url-path expire-at)
  (make-routes))

