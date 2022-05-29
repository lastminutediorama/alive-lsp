(defpackage :alive/lsp/types/restart-info
    (:use :cl)
    (:export :create-item
             :get-name
             :get-description)

    (:local-nicknames (:types :alive/types)))

(in-package :alive/lsp/types/restart-info)


(defclass restart-info ()
        ((name :accessor name
               :initform nil
               :initarg :name)
         (description :accessor description
                      :initform nil
                      :initarg :description)))


(defmethod print-object ((obj restart-info) out)
    (format out "{name: \"~A; description: ~A\"}"
        (name obj)
        (description obj)))


(defmethod types:deep-equal-p ((a restart-info) b)
    (and (equal (type-of a) (type-of b))
         (types:deep-equal-p (name a) (name b))
         (types:deep-equal-p (description a) (description b))))


(defun create-item (&key name description)
    (make-instance 'restart-info
        :name name
        :description description))


(defun get-name (obj)
    (when obj
          (name obj)))


(defun get-description (obj)
    (when obj
          (description obj)))