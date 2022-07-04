(defpackage :alive/test/session/messages
    (:use :cl)
    (:export :run-all)
    (:local-nicknames (:logger :alive/logger)
                      (:init :alive/lsp/message/initialize)
                      (:utils :alive/test/utils)
                      (:session :alive/session)))

(in-package :alive/test/session/messages)


(defclass test-state (session::state)
        ((send-called :accessor send-called
                      :initform nil
                      :initarg :send-called)))


(defclass init-msg-state (test-state)
        ())


(defclass load-file-state (test-state)
        ())


(defclass completion-state (test-state)
        ())


(defclass hover-state (test-state)
        ())


(defclass top-form-state (test-state)
        ())


(defclass formatting-state (test-state)
        ())


(defclass list-threads-state (test-state)
        ())


(defclass kill-thread-state (test-state)
        ())


(defclass list-pkgs-state (test-state)
        ())


(defclass unexport-state (test-state)
        ())


(defclass eval-state (test-state)
        ())


(defclass get-pkg-state (test-state)
        ())


(defclass remove-pkg-state (test-state)
        ())


(defclass list-asdf-state (test-state)
        ())


(defclass load-asdf-state (test-state)
        ())


(defun create-state (cls)
    (make-instance cls))


(defmethod session::get-input-stream ((obj init-msg-state))
    (let ((content (with-output-to-string (str)
                       (format str "{~A" utils:*end-line*)
                       (format str "  \"jsonrpc\": \"2.0\",~A" utils:*end-line*)
                       (format str "  \"id\": 0,~A" utils:*end-line*)
                       (format str "  \"method\": \"initialize\",~A" utils:*end-line*)
                       (format str "  \"params\": {~A" utils:*end-line*)
                       (format str "    \"clientInfo\": {~A" utils:*end-line*)
                       (format str "      \"name\": \"Visual Studio Code\",~A" utils:*end-line*)
                       (format str "      \"version\": \"1.62.3\"~A" utils:*end-line*)
                       (format str "    }~A" utils:*end-line*)
                       (format str "  }~A" utils:*end-line*)
                       (format str "}~A" utils:*end-line*))))
        (utils:stream-from-string (utils:create-msg content))))


(defmethod session::send-msg ((obj init-msg-state) msg)
    (setf (send-called obj) T))


(defun init-msg ()
    (let ((state (create-state 'init-msg-state)))
        (clue:test "Initialize Message"
            (session::handle-msg state
                                 (session::read-message state))
            (clue:check-equal :expected T
                              :actual (send-called state)))))


(defmethod session::get-input-stream ((obj load-file-state))
    (let ((content (with-output-to-string (str)
                       (format str "{~A" utils:*end-line*)
                       (format str "  \"jsonrpc\": \"2.0\",~A" utils:*end-line*)
                       (format str "  \"id\": 0,~A" utils:*end-line*)
                       (format str "  \"method\": \"$/alive/loadFile\",~A" utils:*end-line*)
                       (format str "  \"params\": {~A" utils:*end-line*)
                       (format str "    \"path\": \"test/files/compile/foo.lisp\",~A" utils:*end-line*)
                       (format str "    \"showStdout\": false~A" utils:*end-line*)
                       (format str "  }~A" utils:*end-line*)
                       (format str "}~A" utils:*end-line*))))
        (utils:stream-from-string (utils:create-msg content))))


(defmethod session::send-msg ((obj load-file-state) msg)
    (setf (send-called obj) T))


(defun load-file-msg ()
    (let ((state (create-state 'load-file-state)))
        (clue:test "Load File Message"
            (session::handle-msg state
                                 (session::read-message state))
            (clue:check-equal :expected t
                              :actual (send-called state)))))


(defmethod session::get-input-stream ((obj completion-state))
    (let ((content (with-output-to-string (str)
                       (format str "{~A" utils:*end-line*)
                       (format str "  \"jsonrpc\": \"2.0\",~A" utils:*end-line*)
                       (format str "  \"id\": 5,~A" utils:*end-line*)
                       (format str "  \"method\": \"textdocument/completion\",~A" utils:*end-line*)
                       (format str "  \"params\": {~A" utils:*end-line*)
                       (format str "    \"textDocument\": {~A" utils:*end-line*)
                       (format str "      \"uri\":\"file:///some/file.txt\"~A" utils:*end-line*)
                       (format str "    },~A" utils:*end-line*)
                       (format str "    \"position\": {~A" utils:*end-line*)
                       (format str "      \"line\": 3,~A" utils:*end-line*)
                       (format str "      \"character\": 11~A" utils:*end-line*)
                       (format str "    },~A" utils:*end-line*)
                       (format str "    \"context\": {~A" utils:*end-line*)
                       (format str "      \"triggerKind\": 1~A" utils:*end-line*)
                       (format str "    }~A" utils:*end-line*)
                       (format str "  }~A" utils:*end-line*)
                       (format str "}~A" utils:*end-line*))))
        (utils:stream-from-string (utils:create-msg content))))


(defmethod session::send-msg ((obj completion-state) msg)
    (setf (send-called obj) T))


(defun completion-msg ()
    (let ((state (create-state 'completion-state)))
        (clue:test "Completion Message"
            (session::handle-msg state
                                 (session::read-message state))
            (clue:check-equal :expected t
                              :actual (send-called state)))))


(defmethod session::get-input-stream ((obj hover-state))
    (let ((content (with-output-to-string (str)
                       (format str "{~A" utils:*end-line*)
                       (format str "  \"jsonrpc\": \"2.0\",~A" utils:*end-line*)
                       (format str "  \"id\": 5,~A" utils:*end-line*)
                       (format str "  \"method\": \"textdocument/hover\",~A" utils:*end-line*)
                       (format str "  \"params\": {~A" utils:*end-line*)
                       (format str "    \"textDocument\": {~A" utils:*end-line*)
                       (format str "      \"uri\":\"file:///some/file.txt\"~A" utils:*end-line*)
                       (format str "    },~A" utils:*end-line*)
                       (format str "    \"position\": {~A" utils:*end-line*)
                       (format str "      \"line\": 3,~A" utils:*end-line*)
                       (format str "      \"character\": 11~A" utils:*end-line*)
                       (format str "    }~A" utils:*end-line*)
                       (format str "  }~A" utils:*end-line*)
                       (format str "}~A" utils:*end-line*))))
        (utils:stream-from-string (utils:create-msg content))))


(defmethod session::send-msg ((obj hover-state) msg)
    (setf (send-called obj) T))


(defun hover-msg ()
    (let ((state (create-state 'hover-state)))
        (clue:test "Hover Message"
            (session::handle-msg state
                                 (session::read-message state))
            (clue:check-equal :expected t
                              :actual (send-called state)))))


(defmethod session::get-input-stream ((obj top-form-state))
    (let ((content (with-output-to-string (str)
                       (format str "{~A" utils:*end-line*)
                       (format str "  \"jsonrpc\": \"2.0\",~A" utils:*end-line*)
                       (format str "  \"id\": 5,~A" utils:*end-line*)
                       (format str "  \"method\": \"$/alive/topFormBounds\",~A" utils:*end-line*)
                       (format str "  \"params\": {~A" utils:*end-line*)
                       (format str "    \"textDocument\": {~A" utils:*end-line*)
                       (format str "      \"uri\":\"file:///some/file.txt\"~A" utils:*end-line*)
                       (format str "    },~A" utils:*end-line*)
                       (format str "    \"position\": {~A" utils:*end-line*)
                       (format str "      \"line\": 3,~A" utils:*end-line*)
                       (format str "      \"character\": 11~A" utils:*end-line*)
                       (format str "    }~A" utils:*end-line*)
                       (format str "  }~A" utils:*end-line*)
                       (format str "}~A" utils:*end-line*))))
        (utils:stream-from-string (utils:create-msg content))))


(defmethod session::send-msg ((obj top-form-state) msg)
    (setf (send-called obj) T))


(defun top-form-msg ()
    (let ((state (create-state 'top-form-state)))
        (clue:test "Top Form Message"
            (session::handle-msg state
                                 (session::read-message state))
            (clue:check-equal :expected t
                              :actual (send-called state)))))


(defmethod session::get-input-stream ((obj formatting-state))
    (let ((content (with-output-to-string (str)
                       (format str "{~A" utils:*end-line*)
                       (format str "  \"jsonrpc\": \"2.0\",~A" utils:*end-line*)
                       (format str "  \"id\": 5,~A" utils:*end-line*)
                       (format str "  \"method\": \"textdocument/rangeformatting\",~A" utils:*end-line*)
                       (format str "  \"params\": {~A" utils:*end-line*)
                       (format str "    \"textDocument\": {~A" utils:*end-line*)
                       (format str "      \"uri\":\"file:///some/file.txt\"~A" utils:*end-line*)
                       (format str "    },~A" utils:*end-line*)
                       (format str "    \"range\": {~A" utils:*end-line*)
                       (format str "      \"start\": {~A" utils:*end-line*)
                       (format str "        \"line\": 0,~A" utils:*end-line*)
                       (format str "        \"character\": 0~A" utils:*end-line*)
                       (format str "      },~A" utils:*end-line*)
                       (format str "      \"end\": {~A" utils:*end-line*)
                       (format str "        \"line\": 10,~A" utils:*end-line*)
                       (format str "        \"character\": 10~A" utils:*end-line*)
                       (format str "      }~A" utils:*end-line*)
                       (format str "    },~A" utils:*end-line*)
                       (format str "    \"options\": {~A" utils:*end-line*)
                       (format str "      \"tabSize\": 4,~A" utils:*end-line*)
                       (format str "      \"insertSpaces\": true~A" utils:*end-line*)
                       (format str "    }~A" utils:*end-line*)
                       (format str "  }~A" utils:*end-line*)
                       (format str "}~A" utils:*end-line*))))
        (utils:stream-from-string (utils:create-msg content))))


(defmethod session::send-msg ((obj formatting-state) msg)
    (setf (send-called obj) T))


(defun formatting-msg ()
    (let ((state (create-state 'formatting-state)))
        (clue:test "Range Format Message"
            (session::handle-msg state
                                 (session::read-message state))
            (clue:check-equal :expected t
                              :actual (send-called state)))))


(defmethod session::get-input-stream ((obj list-threads-state))
    (let ((content (with-output-to-string (str)
                       (format str "{~A" utils:*end-line*)
                       (format str "  \"jsonrpc\": \"2.0\",~A" utils:*end-line*)
                       (format str "  \"id\": 5,~A" utils:*end-line*)
                       (format str "  \"method\": \"$/alive/listThreads\"~A" utils:*end-line*)
                       (format str "}~A" utils:*end-line*))))
        (utils:stream-from-string (utils:create-msg content))))


(defmethod session::send-msg ((obj list-threads-state) msg)
    (setf (send-called obj) T))


(defun list-threads-msg ()
    (let ((state (create-state 'list-threads-state)))
        (clue:test "List Threads Message"
            (session::handle-msg state
                                 (session::read-message state))
            (clue:check-equal :expected t
                              :actual (send-called state)))))


(defmethod session::get-input-stream ((obj kill-thread-state))
    (let ((content (with-output-to-string (str)
                       (format str "{~A" utils:*end-line*)
                       (format str "  \"jsonrpc\": \"2.0\",~A" utils:*end-line*)
                       (format str "  \"id\": 5,~A" utils:*end-line*)
                       (format str "  \"method\": \"$/alive/killThread\",~A" utils:*end-line*)
                       (format str "  \"params\": {~A" utils:*end-line*)
                       (format str "    \"id\": 10~A" utils:*end-line*)
                       (format str "  }~A" utils:*end-line*)
                       (format str "}~A" utils:*end-line*))))
        (utils:stream-from-string (utils:create-msg content))))


(defmethod session::send-msg ((obj kill-thread-state) msg)
    (setf (send-called obj) T))


(defun kill-thread-msg ()
    (let ((state (create-state 'kill-thread-state)))
        (clue:test "Kill Thread Message"
            (session::handle-msg state
                                 (session::read-message state))
            (clue:check-equal :expected t
                              :actual (send-called state)))))


(defmethod session::get-input-stream ((obj list-pkgs-state))
    (let ((content (with-output-to-string (str)
                       (format str "{~A" utils:*end-line*)
                       (format str "  \"jsonrpc\": \"2.0\",~A" utils:*end-line*)
                       (format str "  \"id\": 5,~A" utils:*end-line*)
                       (format str "  \"method\": \"$/alive/listPackages\"~A" utils:*end-line*)
                       (format str "}~A" utils:*end-line*))))
        (utils:stream-from-string (utils:create-msg content))))


(defmethod session::send-msg ((obj list-pkgs-state) msg)
    (setf (send-called obj) T))


(defun list-pkgs-msg ()
    (let ((state (create-state 'list-pkgs-state)))
        (clue:test "List Packages Message"
            (session::handle-msg state
                                 (session::read-message state))
            (clue:check-equal :expected t
                              :actual (send-called state)))))


(defmethod session::get-input-stream ((obj unexport-state))
    (let ((content (with-output-to-string (str)
                       (format str "{~A" utils:*end-line*)
                       (format str "  \"jsonrpc\": \"2.0\",~A" utils:*end-line*)
                       (format str "  \"id\": 5,~A" utils:*end-line*)
                       (format str "  \"method\": \"$/alive/unexportSymbol\",~A" utils:*end-line*)
                       (format str "  \"params\": {~A" utils:*end-line*)
                       (format str "    \"symbol\": \"foo\",~A" utils:*end-line*)
                       (format str "    \"package\": \"bar\"~A" utils:*end-line*)
                       (format str "  }~A" utils:*end-line*)
                       (format str "}~A" utils:*end-line*))))
        (utils:stream-from-string (utils:create-msg content))))


(defmethod session::send-msg ((obj unexport-state) msg)
    (setf (send-called obj) T))


(defun unexport-symbol-msg ()
    (let ((state (create-state 'unexport-state)))
        (clue:test "Unexport Symbol Message"
            (session::handle-msg state
                                 (session::read-message state))
            (clue:check-equal :expected t
                              :actual (send-called state)))))


(defmethod session::get-input-stream ((obj eval-state))
    (let ((content (with-output-to-string (str)
                       (format str "{~A" utils:*end-line*)
                       (format str "  \"jsonrpc\": \"2.0\",~A" utils:*end-line*)
                       (format str "  \"id\": 5,~A" utils:*end-line*)
                       (format str "  \"method\": \"$/alive/eval\",~A" utils:*end-line*)
                       (format str "  \"params\": {~A" utils:*end-line*)
                       (format str "    \"package\": \"foo\",~A" utils:*end-line*)
                       (format str "    \"text\": \"(+ 1 2)\"~A" utils:*end-line*)
                       (format str "  }~A" utils:*end-line*)
                       (format str "}~A" utils:*end-line*))))
        (utils:stream-from-string (utils:create-msg content))))


(defmethod session::send-msg ((obj eval-state) msg)
    (setf (send-called obj) T))


(defun eval-msg ()
    (let ((state (create-state 'eval-state)))
        (clue:test "Eval Message"
            (session::handle-msg state
                                 (session::read-message state))
            (clue:check-equal :expected t
                              :actual (send-called state)))))


(defmethod session::get-input-stream ((obj get-pkg-state))
    (let ((content (with-output-to-string (str)
                       (format str "{~A" utils:*end-line*)
                       (format str "  \"jsonrpc\": \"2.0\",~A" utils:*end-line*)
                       (format str "  \"id\": 5,~A" utils:*end-line*)
                       (format str "  \"method\": \"$/alive/getPackageForPosition\",~A" utils:*end-line*)
                       (format str "  \"params\": {~A" utils:*end-line*)
                       (format str "    \"textDocument\": {~A" utils:*end-line*)
                       (format str "      \"uri\":\"file:///some/file.txt\"~A" utils:*end-line*)
                       (format str "    },~A" utils:*end-line*)
                       (format str "    \"position\": {~A" utils:*end-line*)
                       (format str "      \"line\": 5,~A" utils:*end-line*)
                       (format str "      \"character\": 10~A" utils:*end-line*)
                       (format str "    }~A" utils:*end-line*)
                       (format str "  }~A" utils:*end-line*)
                       (format str "}~A" utils:*end-line*))))
        (utils:stream-from-string (utils:create-msg content))))


(defmethod session::send-msg ((obj get-pkg-state) msg)
    (setf (send-called obj) T))


(defun get-pkg-msg ()
    (let ((state (create-state 'get-pkg-state)))
        (clue:test "Get Package Message"
            (session::handle-msg state
                                 (session::read-message state))
            (clue:check-equal :expected t
                              :actual (send-called state)))))


(defmethod session::get-input-stream ((obj remove-pkg-state))
    (let ((content (with-output-to-string (str)
                       (format str "{~A" utils:*end-line*)
                       (format str "  \"jsonrpc\": \"2.0\",~A" utils:*end-line*)
                       (format str "  \"id\": 5,~A" utils:*end-line*)
                       (format str "  \"method\": \"$/alive/removePackage\",~A" utils:*end-line*)
                       (format str "  \"params\": {~A" utils:*end-line*)
                       (format str "    \"name\": \"foo\"~A" utils:*end-line*)
                       (format str "  }~A" utils:*end-line*)
                       (format str "}~A" utils:*end-line*))))
        (utils:stream-from-string (utils:create-msg content))))


(defmethod session::send-msg ((obj remove-pkg-state) msg)
    (setf (send-called obj) T))


(defun remove-pkg-msg ()
    (let ((state (create-state 'remove-pkg-state)))
        (clue:test "Remove Package Message"
            (session::handle-msg state
                                 (session::read-message state))
            (clue:check-equal :expected t
                              :actual (send-called state)))))


(defmethod session::get-input-stream ((obj list-asdf-state))
    (let ((content (with-output-to-string (str)
                       (format str "{~A" utils:*end-line*)
                       (format str "  \"jsonrpc\": \"2.0\",~A" utils:*end-line*)
                       (format str "  \"id\": 5,~A" utils:*end-line*)
                       (format str "  \"method\": \"$/alive/listAsdfSystems\"~A" utils:*end-line*)
                       (format str "}~A" utils:*end-line*))))
        (utils:stream-from-string (utils:create-msg content))))


(defmethod session::send-msg ((obj list-asdf-state) msg)
    (setf (send-called obj) T))


(defun list-asdf-msg ()
    (let ((state (create-state 'list-asdf-state)))
        (clue:test "List ASDF Systems Message"
            (session::handle-msg state
                                 (session::read-message state))
            (clue:check-equal :expected t
                              :actual (send-called state)))))


(defmethod session::get-input-stream ((obj load-asdf-state))
    (let ((content (with-output-to-string (str)
                       (format str "{~A" utils:*end-line*)
                       (format str "  \"jsonrpc\": \"2.0\",~A" utils:*end-line*)
                       (format str "  \"id\": 5,~A" utils:*end-line*)
                       (format str "  \"method\": \"$/alive/loadAsdfSystem\",~A" utils:*end-line*)
                       (format str "  \"params\": {~A" utils:*end-line*)
                       (format str "    \"name\": \"foo\"~A" utils:*end-line*)
                       (format str "  }~A" utils:*end-line*)
                       (format str "}~A" utils:*end-line*))))
        (utils:stream-from-string (utils:create-msg content))))


(defmethod session::send-msg ((obj load-asdf-state) msg)
    (setf (send-called obj) T))


(defun load-asdf-msg ()
    (let ((state (create-state 'load-asdf-state)))
        (clue:test "Load ASDF System Message"
            (session::handle-msg state
                                 (session::read-message state))
            (clue:check-equal :expected t
                              :actual (send-called state)))))


(defun run-all ()
    (clue:suite "Session Message Tests"
        (init-msg)
        ;    (load-file-msg)
        (completion-msg)
        (top-form-msg)
        (formatting-msg)
        (list-threads-msg)
        (kill-thread-msg)
        (list-pkgs-msg)
        (unexport-symbol-msg)
        (get-pkg-msg)
        (list-asdf-msg)
        (hover-msg)))