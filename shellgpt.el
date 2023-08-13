(require 'comint)

;;;###autoload
(defgroup shellgpt nil
  "shellgpt package"
  :group 'ai)

;;;###autoload
(defcustom shellgpt:openai-config-file
  "~/.openai"
  "File that stores the OPENAI_API_KEY"
  :type 'string
  :group 'shellgpt)

;;;###autoload
(defcustom shellgpt:executable-path
  (or (executable-find "sgpt")
      (progn
        (warn "shellgpt executable not found in path (searched for '')")
        "sgpt"))
  "Path of the shellgpt executable"
  :type 'list
  :group 'shellgpt)

(defcustom shellgpt:repl-chat-name
  "emacs-repl"
  "Name of the REPL to open"
  :type 'string
  :group 'shellgpt)

;;;###autoload
(defcustom shellgpt:command-line-args
  (list "--repl" shellgpt:repl-chat-name)
  "List of command line arguments passed to the  process"
  :type 'list
  :group 'shellgpt)

;;;###autoload
(defcustom shellgpt:repl-buffer-name
  "*shellgpt*"
  "Name of the buffer that contains the shellgpt process"
  :type 'string
  :group 'shellgpt)

;;;###autoload
(defun shellgpt:fetch-api-key ()
  "Sets the OPENAI_API_KEY environment variable if not defined.

Does this by reading the `'shellgpt:openai-config-file`' which
should be a single line containing the secret key.
"
  (interactive)
  (unless (getenv "OPENAI_API_KEY")
    ;; otherwise read the api key in from the config file
    (message "OPENAI_API_KEY not defined. Attempting to read from file: %s"
             shellgpt:openai-config-file)
    (if (file-exists-p shellgpt:openai-config-file)
        (let ((config-file-sk
               (with-temp-buffer
                 (insert-file-contents shellgpt:openai-config-file)
                 (buffer-string))))
          (setenv "OPENAI_API_KEY" config-file-sk))
      (message "openai config file does not exist. Exiting..."))))

;;;###autoload
(defun shellgpt:start-repl ()
  "Start the shellgpt REPL."
  (interactive)
  (unless (getenv "OPENAI_API_KEY")
    (shellgpt:fetch-api-key))
  (let ((tmpbuf (get-buffer-create shellgpt:repl-buffer-name)))
    (pop-to-buffer tmpbuf)
    (unless (comint-check-proc tmpbuf)
      (let ((proc
             (apply 'make-comint-in-buffer
                    "TEST"
                    tmpbuf
                    shellgpt:executable-path
                    nil
                    shellgpt:command-line-args)))
        (set-process-query-on-exit-flag
         (get-buffer-process tmpbuf)
         nil)))))

(defun shellgpt:send-query-text (text &optional insert-newline)
  "Send query text to a comint buffer.

If insert-newline is non-nil a newline is appended to the text
which will submit the query to the REPL
"
  (if (get-buffer shellgpt:repl-buffer-name)
      (with-current-buffer shellgpt:repl-buffer-name
        (comint-send-string (current-buffer)
                            (if insert-newline
                                (concat text "\n")
                              text)))
    (message "shellgpt buffer %s does not exist! Did you start the REPL?"
             shellgpt:repl-buffer-name)))

;;;###autoload
(defun shellgpt:quick-ask ()
  "Send a query string to the shellgpt repl.

This will start the REPL if it has not been started already.
"
  (interactive)
  (unless (get-buffer shellgpt:repl-buffer-name)
    (shellgpt:start-repl))
  (shellgpt:send-query-text (read-string "ChatGPT query: ") t))

(provide 'shellgpt)
