;; with use-package keywords ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; hydra
(meq/up hydra
    :custom (hydra-hint-display-type 'lv)
    :bind (:map hydra-base-map ("~" . hydra--universal-argument))
    :use-package-postconfig (use-package-hydra)
    :upnsd-preconfig (janus :load-path "../../lib/janus")
    :upnsd-postconfig
        (use-package-deino :load-path "../../lib/use-package-deino")
        (deino :load-path "../../lib/deino" :custom (deino-hint-display-type 'lv)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; alloy
(meq/upnsd alloy
    :load-path "../../lib/alloy"
    :upnsd-postconfig
        (lode :load-path "../../lib/lode")
        (prime :load-path "../../lib/prime")
        (uru :load-path "../../lib/uru"
            :config (prime "u u" uru "uru")
                    (prime "u m" minoru "minoru"))
    :use-package-preconfig (command-log-mode)
        ;; Important: https://github.com/noctuid/general.el/issues/53#issuecomment-307262154
        (use-package-chords)
    :config
        (alloy-auto-unbind-keys)
        (alloy-def :keymaps demon-run
            ;; Adapted From:
            ;; Answer: https://stackoverflow.com/a/4557027/10827766
            ;; User: https://stackoverflow.com/users/387076/gilles-so-stop-being-evil
            "\eOA" [up]
            "\e[A" [up]
            "\eOB" [down]
            "\e[B" [down]
            "\eOD" [left]
            "\e[D" [left]
            "\eOC" [right]
            "\e[C" [right]
            "M-x" 'meq/M-x)
    :deino (deino-restart (:color blue) "r"
            ("`" nil "cancel")
            ("l" meq/reload-emacs "reload")
            ("s" restart-emacs "restart"))
    :custom (alloy-implicit-naked t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; cosmoem
(meq/upnsd cosmoem
    :upnsd-postconfig (meta :load-path "../../lib/meta")
    :use-package-preconfig
        (which-key :deino (deino/which-key (:color blue :columns 4) "w"
                    ("`" nil "cancel")
                    ("a" cosmoem-any-popup-showing-p "any popup showing")
                    ("h" meq/which-key--hide-popup "hide-popup")
                    ("s" meq/which-key--show-popup "show-popup")
                    ("r" meq/which-key--refresh-popup "refresh-popup")
                    ("t" meq/toggle-which-key "toggle")
                    ("l" meq/which-key-show-top-level "meq/toplevel")
                    ("L" which-key-show-top-level "toplevel"))
            :gsetq
                (which-key-enable-extended-define-key t)
                (which-key-idle-delay 0.1)
                (which-key-idle-secondary-delay nil)
                (which-key-allow-evil-operators t)

                ;; NOTE: This will cause the which-key maps for the operator states to show up,
                ;; breaking functionality such as `d 13 <arrow-down>', etc.
                ;; (which-key-show-operator-state-maps t)

                ;; TODO: Choose a fun one!
                (which-key-separator " × ")
                ;; (which-key-separator " |-> ")

                (which-key-popup-type 'side-window)
                (which-key-side-window-location '(right bottom left top))

                ;; If this percentage is too small, the keybindings frame will appear at the bottom
                (which-key-side-window-max-width 0.5)

                (which-key-side-window-max-height 0.25))
    :load-path "../../lib/cosmoem"
    :config (prime ", m" map-of-infinity/body "map-of-infinity")
    :which-key-change-ryo ("," "damascus")
    :deino (map-of-infinity nil ", m"
            ("`" nil "cancel")
            ("w" deino/which-key/body "which-key")
            ("h" deino/cosmoem/body "cosmoem")
            ("d" meq/disable-all-modal-modes "disable all modal modes" :color blue)
            ("t" toggles/body "toggles")
            ("k" all-keymaps/body "all keymaps"))
        (deino/cosmoem (:color blue) ", c"
            ("`" nil "cancel")
            ("h" cosmoem-hide-all-modal-modes "hide all modal modes"))
        (toggles (:color blue) ", t" ("`" nil "cancel"))
        (all-keymaps (:color blue) ", k" ("`" nil "cancel")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; sorrow
(meq/upnsd sorrow
    :load-path "../../lib/sorrow"
    :primer+ ("t" "toggles")
    :config ;; From: https://github.com/shadowrylander/sorrow#which-key-integration
        (push '((nil . "sorrow:.*:") . (nil . "")) which-key-replacement-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; startup ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; aiern
(use-package aiern
    :hook (after-init . (lambda nil (interactive)
        (aiern-mode 1)
        (push 'aiern-mode meq/var/ignored-modal-modes)
        (push "aiern" meq/var/ignored-modal-prefixes)))
    :use-package-preconfig (bind-map)
    :straight nil
    :load-path "../../lib/aiern"
    ;; :demon
        ;; TODO
        ;; ((alloy-chord "") 'meq/toggle-aiern-ex-cosmoem)
    :meta-aiern (aiern-normal-state-map) (aiern-insert-state-map)
    :config
        ;; TODO: How do I create a keymap `aiern-ex-keymap' out of the `aiern-ex-commands' alist?

        ;; (cosmoem-def :show-funs #'meq/aiern-ex-cosmoem-show
        ;;     :hide-funs #'meq/aiern-ex-cosmoem-hide
        ;;     :toggle-funs #'meq/aiern-ex-cosmoem-toggle
        ;;     :keymap 'aiern-ex-keymap
        ;;     ;; :transient t
        ;; )

        ;; (defun meq/aiern-ex-cosmoem-toggle nil (interactive))
        ;; (defun meq/aiern-ex-show-top-level nil (interactive)
        ;;     (meq/which-key-show-top-level 'aiern-ex-keymap))

        ;; (defun meq/toggle-aiern-ex (ua) (interactive "p")
        ;;     (if (= ua 4)
        ;;         (funcall 'meq/toggle-inner 'aiern-mode "aiern-ex" (meq/fbatp aiern-mode) 'aiern-ex-keymap nil t)
        ;;         (funcall 'meq/toggle-inner 'aiern-mode "aiern-ex" (meq/fbatp aiern-mode) 'aiern-ex-keymap)))
        ;; (defun meq/toggle-aiern-ex-cosmoem (ua) (interactive "p")
        ;;     (if (= ua 4)
        ;;         (funcall 'meq/toggle-inner 'aiern-mode "aiern-ex" (meq/fbatp aiern-mode) 'aiern-ex-keymap t t)
        ;;         (funcall 'meq/toggle-inner 'aiern-mode "aiern-ex" (meq/fbatp aiern-mode) 'aiern-ex-keymap t)))
    :sorrow ("l" :deino
                '(aiern-exits (:color blue) "e"
                    ;; From: https://github.com/emacs-evil/evil/blob/master/evil-maps.el#L449
                    "A deino for getting the fuck outta' here!"
                    ("`" nil "cancel")
                    ("l" aiern-save-and-quit ":wq")
                    ("p" aiern-quit ":q")
                    ("o" aiern-write ":w")
                    ("O" aiern-write-all ":wa")
                    ;; ("q" (funcall (alloy-simulate-key ":q! <RET>")) ":q!"))
                    ("q" (aiern-quit t) ":q!"))
                :name "aiern exits"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; counsel
(meq/up counsel :use-package-preconfig (smex)
        (ivy :sorrow ("x" :deino '(deino-execute (:color blue) "x" "A deino for launching stuff!"
                ("`" nil "cancel")
                ("e" execute-extended-command "M-x")) :name "execute order 65")
            :gsetq (ivy-use-virtual-buffers t))
    :use-package-postconfig (prescient) (ivy-prescient)
    :hook (after-init . (lambda nil (interactive)
                            (ivy-mode 1)
                            (counsel-mode 1)
                            (ivy-prescient-mode 1)
                            (prescient-persist-mode 1)))
    :deino+ (deino-execute nil ("c" counsel-M-x "counsel"))

    ;; Adapted From: https://www.reddit.com/r/emacs/comments/7o1sjq/exwm_rofidmenu_replacement_for_starting/dt0lvkm?utm_source=share&utm_medium=web2x&context=3
    :config (push (concat (getenv "HOME") "/.local/share/applications/") counsel-linux-apps-directories)
    :config/defun* (meq/counsel-linux-app-format-function (name comment exec)
                        "Default Linux application name formatter.
                    NAME is the name of the application, COMMENT its comment and EXEC
                    the command to launch it."
                        (format "% -45s %s"
                            (propertize name 'face 'font-lock-builtin-face)
                            (or comment "")))
   :gsetq (counsel-linux-app-format-function #'meq/counsel-linux-app-format-function))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; damascus
(meq/upnsd damascus
    :use-package-postconfig (rainbow-mode :config (rainbow-mode 1))
    :alloy (:keymaps demon-run
        "¡" 'ignore "¹" 'ignore "½" 'ignore "⅓" 'ignore "¼" 'ignore "⅛" 'ignore "²" 'ignore "⅜" 'ignore
        "¾" 'ignore "³" 'ignore "⁴" 'ignore "⅚" 'ignore "⁵" 'ignore "⅝" 'ignore "⁶" 'ignore "⅞" 'ignore
        "⁷" 'ignore "⁸" 'ignore "⁹" 'ignore "∅" 'ignore "ⁿ" 'ignore "⁰" 'ignore "·" 'ignore "—" 'ignore
        "∞" 'ignore "≠" 'ignore "≈" 'ignore "ê" 'ignore "é" 'ignore "è" 'ignore "ë" 'ignore "ē" 'ignore
        "ū" 'ignore "ü" 'ignore "ú" 'ignore "û" 'ignore "ù" 'ignore "ì" 'evil-ex "ï" 'ignore "í" 'aiern-ex
        "î" 'ignore "ī" 'ignore "ō" 'ignore "œ" 'ignore "ø" 'ignore "õ" 'ignore "ö" 'ignore "ó" 'ignore
        "ô" 'ignore "ò" 'ignore "à" 'ignore "á" 'ignore "â" 'ignore "ä" 'ignore "æ" 'ignore "ã" 'ignore
        "å" 'ignore "ā" 'ignore "ß" 'ignore "ç" 'ignore "ñ" 'ignore "¿" 'ignore)
    :load-emacs-file-preconfig ("damascus")
    :load-emacs-file-postconfig ("help+20") ("help-fns+")
        ;; (find-file . meq/set-buffer-save-without-query)
    :gsetq
        (indent-tabs-mode nil
            confirm-kill-emacs nil
            echo-keystrokes .1
            column-number-mode t
            size-indicator-mode t)

        ;; Adapted From:
        ;; From: https://emacs.stackexchange.com/a/19507
        ;; User: https://emacs.stackexchange.com/users/50/malabarba
        ;; (byte-compile-warnings (not t))
        ;; (byte-compile warnings (not obsolete))
        
        ;; From: https://emacsredux.com/blog/2014/07/25/configure-the-scratch-buffers-mode/
        ;; (initial-major-mode '.cosmog.-org-mode)

        ;; Follow symlinks
        (vc-follow-symlinks t)

        ;; Use Python Syntax Highlighting for ".xonshrc" files
        ;; (auto-mode-alist 
        ;;       (append '(".*\\.xonshrc\\'" . python-mode)
        ;;               auto-mode-alist))
        ;; (auto-mode-alist 
        ;;       (append '(".*\\.xsh\\'" . python-mode)
        ;;              auto-mode-alist))

        (user-full-name "Jeet Ray"
            user-mail-address "aiern@protonmail.com")
    :config/defun*
        ;; Answer: https://emacs.stackexchange.com/a/51829
        ;; User: https://emacs.stackexchange.com/users/2370/tobias
        (meq/set-buffer-save-without-query nil
            "Set `buffer-save-without-query' to t."
            (unless (variable-binding-locus 'buffer-save-without-query)
                (setq buffer-save-without-query t)))
    :init
        ;; From: https://www.masteringemacs.org/article/speed-up-emacs-libjansson-native-elisp-compilation
        (if (meq/ncp)
            (message "Native compilation is available")
            (message "Native complation is *not* available"))
        (if (meq/fbatp 'json-serialize)
            (message "Native JSON is available")
            (message "Native JSON is *not* available"))

        ;; (add-to-list 'org-src-lang-modes '("nix-repl" . nix-mode))
        ;; (org-babel-do-load-languages 'org-babel-load-languages '((nix-mode . t)))
        ;; (json (if (assoc :json params) (nth (+ (cl-position :json params) 1) params) nil))
        ;; (optargs (if (assoc '-- params) (nthcdr (+ (cl-position '-- params) 1) params) nil))
        ;; (if (or (eq json nil) (<= json 0)) "" "--json")
        ;; (if optargs (format "%s" optargs) "")
        ;; (format "%s" (cdr params))

        ;; This determines the style of line numbers in effect. If set to `nil', line
        ;; numbers are disabled. For relative line numbers, set this to `relative'.
        ;; Adapted From: https://www.reddit.com/r/emacs/comments/8fz6x2/relative_number_with_line_folding/dy7lmh7?utm_source=share&utm_medium=web2x&context=3
        ;; (display-line-numbers-mode 1)
        (setq display-line-numbers-type 'relative)

        ;; Adapted From:
        ;; Answer: https://stackoverflow.com/a/50716229/10827766
        ;; User: https://stackoverflow.com/users/1482346/muro
        (global-display-line-numbers-mode t)

        ;; Adapted From:
        ;; Answer: https://unix.stackexchange.com/a/152151
        ;; User: https://unix.stackexchange.com/users/72170/ole
        ;; No more typing the whole yes or no. Just y or n will do.
        ;; Makes *scratch* empty.
        (setq initial-scratch-message "")

        ;; Removes *scratch* from buffer after the mode has been set.
        (defun meq/remove-scratch-buffer nil (interactive)
            (when (get-buffer "*scratch*") (kill-buffer "*scratch*")))
        (add-hook 'after-change-major-mode-hook 'meq/remove-scratch-buffer)

        ;; Removes *messages* from the buffer.
        ;; (setq-default message-log-max nil)
        ;; (when (get-buffer "*Messages*") (kill-buffer "*Messages*"))

        ;; Removes *Completions* from buffer after you've opened a file.
        (add-hook 'minibuffer-exit-hook
            '(lambda nil
                (let ((buffer "*Completions*"))
                (and (get-buffer buffer)
                        (kill-buffer buffer)))))

        ;; Don't show *Buffer list* when opening multiple files at the same time.
        (setq inhibit-startup-buffer-menu t)

        ;; Show only one active window when opening multiple files at the same time.
        (add-hook 'window-setup-hook 'delete-other-windows)

        (fset 'yes-or-no-p 'y-or-n-p)

        ;; From: https://kundeveloper.com/blog/autorevert/
        ;; Auto revert files when they change
        (global-auto-revert-mode t)
        ;; Also auto refresh dired, but be quiet about it
        (setq global-auto-revert-non-file-buffers t)
        (setq auto-revert-verbose nil)

        ;; From:
        ;; Answer: https://stackoverflow.com/a/54369503/10827766
        ;; User: https://stackoverflow.com/users/9848932/jdc
        (setq auto-revert-use-notify nil)

        ;; The following avoids being ask to allow the file local
        ;; setting of `buffer-save-without-query'.
        ;; IMHO it is not a big risk:
        ;; The malicious code that must not be saved
        ;; should never be allowed to enter Emacs in the first place.
        ;; (put 'buffer-save-without-query 'safe-local-variable #'booleanp)

        ;; (toggle-debug-on-error)
        )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; doom-aiern-modeline
(use-package doom-aiern-modeline
    :straight nil
    :hook (after-init . doom-aiern-modeline-mode)
    :load-path "../../lib/doom-aiern-modeline"
    :use-package-preconfig (all-the-icons) (shrink-path)
            (god-mode :upnsd-postconfig (aiern-god-state :load-path "../../lib/aiern-god-state")
                :use-package-postconfig
                    (evil-god-state :straight (evil-god-state
                        :type git
                        :host github
                        :repo "gridaphobe/evil-god-state"
                        :branch "master"))
                :config (which-key-enable-god-mode-support))
    :gsetq
        ;; How tall the mode-line should be. It's only respected in GUI.
        ;; If the actual char height is larger, it respects the actual height.
        (doom-aiern-modeline-height 25)

        ;; How wide the mode-line bar should be. It's only respected in GUI.
        (doom-aiern-modeline-bar-width 3)

        ;; The limit of the window width.
        ;; If `window-width' is smaller than the limit, some information won't be displayed.
        (doom-aiern-modeline-window-width-limit fill-column)

        ;; How to detect the project root.
        ;; The default priority of detection is `ffip' > `projectile' > `project'.
        ;; nil means to use `default-directory'.
        ;; The project management packages have some issues on detecting project root.
        ;; e.g. `projectile' doesn't handle symlink folders well, while `project' is unable
        ;; to hanle sub-projects.
        ;; You can specify one if you encounter the issue.
        (doom-aiern-modeline-project-detection 'project)

        ;; Determines the style used by `doom-aiern-modeline-buffer-file-name'.
        ;;
        ;; Given ~/Projects/FOSS/emacs/lisp/comint.el
        ;;   auto => emacs/lisp/comint.el (in a project) or comint.el
        ;;   truncate-upto-project => ~/P/F/emacs/lisp/comint.el
        ;;   truncate-from-project => ~/Projects/FOSS/emacs/l/comint.el
        ;;   truncate-with-project => emacs/l/comint.el
        ;;   truncate-except-project => ~/P/F/emacs/l/comint.el
        ;;   truncate-upto-root => ~/P/F/e/lisp/comint.el
        ;;   truncate-all => ~/P/F/e/l/comint.el
        ;;   truncate-nil => ~/Projects/FOSS/emacs/lisp/comint.el
        ;;   relative-from-project => emacs/lisp/comint.el
        ;;   relative-to-project => lisp/comint.el
        ;;   file-name => comint.el
        ;;   buffer-name => comint.el<2> (uniquify buffer name)
        ;;
        ;; If you are experiencing the laggy issue, especially while editing remote files
        ;; with tramp, please try `file-name' style.
        ;; Please refer to https://github.com/bbatsov/projectile/issues/657.
        (doom-aiern-modeline-buffer-file-name-style 'auto)

        ;; Whether display icons in the mode-line.
        ;; While using the server mode in GUI, should set the value explicitly.
        (doom-aiern-modeline-icon (display-graphic-p))

        ;; Whether display the icon for `major-mode'. It respects `doom-aiern-modeline-icon'.
        (doom-aiern-modeline-major-mode-icon t)

        ;; Whether display the colorful icon for `major-mode'.
        ;; It respects `all-the-icons-color-icons'.
        (doom-aiern-modeline-major-mode-color-icon t)

        ;; Whether display the icon for the buffer state. It respects `doom-aiern-modeline-icon'.
        (doom-aiern-modeline-buffer-state-icon t)

        ;; Whether display the modification icon for the buffer.
        ;; It respects `doom-aiern-modeline-icon' and `doom-aiern-modeline-buffer-state-icon'.
        (doom-aiern-modeline-buffer-modification-icon t)

        ;; Whether to use unicode as a fallback (instead of ASCII) when not using icons.
        (doom-aiern-modeline-unicode-fallback nil)

        ;; Whether display the minor modes in the mode-line.
        (doom-aiern-modeline-minor-modes nil)

        ;; If non-nil, a word count will be added to the selection-info modeline segment.
        (doom-aiern-modeline-enable-word-count nil)

        ;; Major modes in which to display word count continuously.
        ;; Also applies to any derived modes. Respects `doom-aiern-modeline-enable-word-count'.
        ;; If it brings the sluggish issue, disable `doom-aiern-modeline-enable-word-count' or
        ;; remove the modes from `doom-aiern-modeline-continuous-word-count-modes'.
        (doom-aiern-modeline-continuous-word-count-modes '(
            markdown-mode
            gfm-mode
            org-mode
            outline-mode))

        ;; Whether display the buffer encoding.
        (doom-aiern-modeline-buffer-encoding t)

        ;; Whether display the indentation information.
        (doom-aiern-modeline-indent-info nil)

        ;; If non-nil, only display one number for checker information if applicable.
        (doom-aiern-modeline-checker-simple-format t)

        ;; The maximum number displayed for notifications.
        (doom-aiern-modeline-number-limit 99)

        ;; The maximum displayed length of the branch name of version control.
        (doom-aiern-modeline-vcs-max-length 12)

        ;; Whether display the workspace name. Non-nil to display in the mode-line.
        (doom-aiern-modeline-workspace-name t)

        ;; Whether display the perspective name. Non-nil to display in the mode-line.
        (doom-aiern-modeline-persp-name t)

        ;; If non nil the default perspective name is displayed in the mode-line.
        (doom-aiern-modeline-display-default-persp-name nil)

        ;; If non nil the perspective name is displayed alongside a folder icon.
        (doom-aiern-modeline-persp-icon t)

        ;; Whether display the `lsp' state. Non-nil to display in the mode-line.
        (doom-aiern-modeline-lsp t)

        ;; Whether display the GitHub notifications. It requires `ghub' package.
        (doom-aiern-modeline-github nil)

        ;; The interval of checking GitHub.
        (doom-aiern-modeline-github-interval (* 30 60))

        ;; Whether display the modal state icon.
        ;; Including `evil', `overwrite', `god', `ryo' and `xah-fly-keys', etc.
        (doom-aiern-modeline-modal-icon t)

        ;; Whether display the mu4e notifications. It requires `mu4e-alert' package.
        (doom-aiern-modeline-mu4e nil)

        ;; Whether display the gnus notifications.
        (doom-aiern-modeline-gnus t)

        ;; Wheter gnus should automatically be updated and how often (set to 0 or smaller than 0 to disable)
        (doom-aiern-modeline-gnus-timer 2)

        ;; Wheter groups should be excludede when gnus automatically being updated.
        (doom-aiern-modeline-gnus-excluded-groups '("dummy.group"))

        ;; Whether display the IRC notifications. It requires `circe' or `erc' package.
        (doom-aiern-modeline-irc t)

        ;; Function to stylize the irc buffer names.
        (doom-aiern-modeline-irc-stylize 'identity)

        ;; Whether display the environment version.
        (doom-aiern-modeline-env-version t)
        ;; Or for individual languages
        (doom-aiern-modeline-env-enable-python t)
        (doom-aiern-modeline-env-enable-ruby t)
        (doom-aiern-modeline-env-enable-perl t)
        (doom-aiern-modeline-env-enable-go t)
        (doom-aiern-modeline-env-enable-elixir t)
        (doom-aiern-modeline-env-enable-rust t)

        ;; Change the executables to use for the language version string
        (doom-aiern-modeline-env-python-executable "python") ; or `python-shell-interpreter'
        (doom-aiern-modeline-env-ruby-executable "ruby")
        (doom-aiern-modeline-env-perl-executable "perl")
        (doom-aiern-modeline-env-go-executable "go")
        (doom-aiern-modeline-env-elixir-executable "iex")
        (doom-aiern-modeline-env-rust-executable "rustc")

        ;; What to dispaly as the version while a new one is being loaded
        (doom-aiern-modeline-env-load-string "...")

        ;; Hooks that run before/after the modeline version string is updated
        (doom-aiern-modeline-before-update-env-hook nil)
        (doom-aiern-modeline-after-update-env-hook nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; exwm
(meq/up exwm
    :init/defun* (post-exwm nil (interactive)
                    (unless (get-buffer "Alacritty") (meq/run "alacritty"))
                    (meq/run "obsidian")
                    (exwm-workspace-switch 0))
    :hook (exwm-init . post-exwm)
    :use-package-postconfig (dmenu)
    :upnsd-preconfig (fringe
                        :load-emacs-file-preconfig ("fringe")
                        :config
                            ;; (fringe-mode (quote (1 . 1)) nil (fringe))
                            (fringe-mode '(3 . 0))
                            (fringe-mode 'none)
                            (fringe-mode 1))
    :config
        (require 'scroll-bar)
        ;; Adapted From: https://github.com/ch11ng/exwm/blob/master/exwm-config.el#L34
        (require 'exwm-config)
        ;; Set the initial workspace number.
        (unless (get 'exwm-workspace-number 'saved-value)
            (setq exwm-workspace-number 4))
        ;; Make class name the buffer name
        (add-hook 'exwm-update-class-hook
                    (lambda ()
                    (exwm-workspace-rename-buffer exwm-class-name)))
        ;; Global keybindings.
        (unless (get 'exwm-input-global-keys 'saved-value)
            (setq exwm-input-global-keys
                `(
                    ;; 's-{p|`|z}': Enter the exwm-global deino
                    ([?\s-p] . uru)
                    ([?\s-`] . uru)
                    ([?\s-z] . uru)

                    ([?\s-q] . (lambda nil (interactive)
                        (unless meq/var/everything-else-initialized (meq/initialize-everything-else))
                        (deino-buffer/body)))

                    ;; 's-N': Switch to certain workspace.
                    ,@(mapcar (lambda (i)
                                `(,(kbd (format "s-%d" i)) .
                                (lambda ()
                                    (interactive)
                                    (exwm-workspace-switch-create ,i))))
                            (number-sequence 0 9)))))
        ;; Line-editing shortcuts
        (unless (get 'exwm-input-simulation-keys 'saved-value)
            (setq exwm-input-simulation-keys
                '(([?\C-b] . [left])
                    ([?\C-f] . [right])
                    ([?\C-p] . [up])
                    ([?\C-n] . [down])
                    ([?\C-a] . [home])
                    ([?\C-e] . [end])
                    ([?\M-v] . [prior])
                    ([?\C-v] . [next])
                    ([?\C-d] . [delete])
                    ([?\C-k] . [S-end delete]))))
        ;; Enable EXWM
        (exwm-enable)
        ;; Configure Ido
        (exwm-config-ido)
        ;; Other configurations
        (exwm-config-misc)

        ;; (exwm-config-default)
        ;; (exwm-enable)

    ;; Adapted From: https://www.reddit.com/r/emacs/comments/8yf6dx/key_chords_in_exwm/
    :gsetq (exwm-input-line-mode-passthrough t)
        (exwm-manage-force-tiling t)

    :demon ((naked "XF86PowerOff") 'deino-exwm/body)
    :deino (deino-exwm nil "e e"
                ("`" nil "cancel")
                ("XF86PowerOff" deino-exwm/power/body "power")
                ("s" deino-exwm/shells/body "shells"))
            (deino-exwm/power (:color blue) "e p"
                ("r" (meq/run "reboot") "reboot")
                ("q" (meq/run "poweroff") "poweroff")
                ("XF86PowerOff" (meq/run "systemctl suspend" "suspend") "suspend"))
            (deino-exwm/shells (:color blue) "e s"
                ("a" (meq/run "alacritty") "alacritty"))
    :uru (exwm-mode deino-exwm-global (:color blue) "e g"
        ("`" nil "cancel")
        ("c" exwm-input-release-keyboard "char mode")
        ("l" exwm-input-grab-keyboard "line mode")
        ("r" exwm-reset "reset")
        ("w" exwm-workspace-switch "workspace switch")
        ("i" meq/run-interactive "run")
        ("b" deino-buffer/body "buffers")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; olivetti
(meq/up olivetti :gsetq (olivetti-body-width 0.60))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; rainbow-identifiers
(meq/up rainbow-identifiers
    ;; Adapted From:
    ;; Answer: https://stackoverflow.com/a/31253253/10827766
    ;; User: https://stackoverflow.com/users/2698552/chillaranand
    ;; :hook ((buffer-list-update window-configuration-change) . (lambda nil (interactive)
    ;;                                                             (rainbow-identifiers-mode 1)))
    ;; :upnsd-preconfig (xxh :load-path "emacs-xxhash")
    )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; vlf
(meq/up vlf :gsetq (vlf-application 'always)
    :straight (vlf :type git :host github :repo "m00natic/vlfi" :branch "master"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; writeroom-mode
(meq/up writeroom-mode
    :disabled t
    :use-package-postconfig (focus
        :disabled t
        :config (focus-mode)
        :gsetq
            (focus-mode-to-thing '(
                ;; (prog-mode . defun)
                (prog-mode . line)
                ;; (text-mode . sentence)
                (text-mode . line)
                (outline-mode . line))))
    :gsetq
        (writeroom-fullscreen-effect t)
        (writeroom-fringes-outside-margins t)
        (writeroom-width 0.75)
        (writeroom-mode-line t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; major-modes ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; dockerfile-mode
(use-package dockerfile-mode :mode ("\\Dockerfile\\'"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; hy-mode
(use-package hy-mode :mode ("\\.hy\\'") :use-package-preconfig (lispy) (sly) (ob-hy))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; markdown-mode

(use-package markdown-mode :mode ("\\.md\\'"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; nix-mode
(use-package nix-mode
    :commands (org-babel-execute:nix)
    :mode ("\\.nix\\'")
    :init/defun*
        ;; Adapted From:
        ;; Answer: https://emacs.stackexchange.com/a/61442
        ;; User: https://emacs.stackexchange.com/users/20061/zeta
        (org-babel-execute:nix (body params)
            "Execute a block of Nix code with org-babel."
            (message "executing Nix source code block")
            (let ((in-file (org-babel-temp-file "n" ".nix"))
                (json (or (cdr (assoc :json params)) nil))
                (opts (or (cdr (assoc :opts params)) nil))
                (args (or (cdr (assoc :args params)) nil))
                (read-write-mode (or (cdr (assoc :read-write-mode params)) nil))
                (eval (or (cdr (assoc :eval params)) nil))
                (show-trace (or (cdr (assoc :show-trace params)) nil)))
            (with-temp-file in-file
                (insert body))
            (org-babel-eval
                (format "nix-instantiate %s %s %s %s %s %s %s"
                    (if (xor (eq json nil) (<= json 0)) "" "--json")
                    (if (xor (eq show-trace nil) (<= show-trace 0)) "" "--show-trace")
                    (if (xor (eq read-write-mode nil) (<= read-write-mode 0)) "" "--read-write-mode")
                    (if (xor (eq eval nil) (<= eval 0)) "" "--eval")
                    (if (eq opts nil) "" opts)
                    (if (eq args nil) "" args)
                    (org-babel-process-file-name in-file))
            ""))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; org-mode
;; Adapted From: https://www.reddit.com/r/emacs/comments/ouzud7/error_usepackage_yankpadcatch_invalid_version/h76b6vo?utm_source=share&utm_medium=web2x&context=3
(meq/up org
    :mode ("\\.org\\'" . org-mode)
    :straight (org :type git :host github :repo "bzg/org-mode" :branch "master")
    :hook (org-cycle . (lambda (state) (interactive) (when (eq state 'children) (setq org-cycle-subtree-status 'subtree))))

    :use-package-postconfig (ox-gfm)
        (ox-pandoc :upnsd-postconfig (riot :if (not (member "--anti-riot" command-line-args)) :load-path "../../lib/riot")
            :deino (deino-ob-export-as (:color blue) "o e a"
                ("`" nil "cancel")
                ("a" org-pandoc-export-as-asciidoc "asciidoc")
                ("g" org-pandoc-export-as-gfm "gfm")
                ("h" org-pandoc-export-as-html5 "html5")
                ("l" org-pandoc-export-as-latex "latex"))
            (deino-ob-export-to (:color blue) "o e t"
                ("`" nil "cancel")
                ("a" org-pandoc-export-to-asciidoc "asciidoc")
                ("d" org-pandoc-export-to-docx "docx")
                ("o" org-pandoc-export-to-odt "odt")
                ("g" org-pandoc-export-to-gfm "gfm")
                ("h" org-pandoc-export-to-html5 "html5")
                ("l" org-pandoc-export-to-latex "latex"))
            (deino-ob-export-and-open (:color blue) "o e o"
                ("`" nil "cancel")
                ("a" org-pandoc-export-to-asciidoc-and-open "asciidoc")
                ("g" org-pandoc-export-to-gfm-and-open "gfm")
                ("h" org-pandoc-export-to-html5-and-open "html5")
                ("l" org-pandoc-export-to-latex-and-open "latex"))
            (deino-ob-export (:color blue) "o e e"
                ("`" nil "cancel")
                ("a" deino-ob-export-as/body "export as")
                ("t" deino-ob-export-to/body "export to")
                ("o" deino-ob-export-and-open/body "export and open")))

        ;; From: https://www.reddit.com/r/orgmode/comments/n56fcv/important_the_contrib_directory_now_lives_outside/gwzz7v5?utm_source=share&utm_medium=web2x&context=3
        (org-contrib :straight (org-contrib
            :type git
            :repo "https://git.sr.ht/~bzg/org-contrib"))
    :config
        (org-babel-do-load-languages 'org-babel-load-languages
            (append org-babel-load-languages
            '((python . t)
            (shell . t))))

        (when (file-exists-p "~/.emacs.d/README.org")
            (org-babel-lob-ingest "~/.emacs.d/README.org"))
        (when (file-exists-p "~/.emacs.d/strange.aiern.org")
            (org-babel-lob-ingest "~/.emacs.d/strange.aiern.org"))
        
        (defun meq/get-header nil (interactive)
            (nth 4 (org-heading-components)))
        (defun meq/tangle-path nil (interactive)
            (string-remove-prefix "/" (concat
                (org-format-outline-path (org-get-outline-path)) "/"
                    (meq/get-header))))
        (defun meq/get-theme-from-header nil (interactive)
            (string-remove-suffix "-theme.el" (meq/get-header)))
    ;; :demon ((naked "backtab") 'evil-close-fold)
    :meta (org-mode-map)
    :meta-rename (org-mode-map "ESC" "org-metadir")
    :minoru (org-src-mode deino-edit-spc (:color blue) "o s"
            ("`" nil "cancel")
            ("i" meq/narrow-or-widen-dwim "narrow")
            ("x" org-edit-special "org edit special")
            ;; From: https://github.com/bzg/org-mode/blob/master/lisp/org-src.el#L667
            ;; And: https://github.com/bzg/org-mode/blob/master/lisp/org-src.el#L674
            ;; And: https://github.com/bzg/org-mode/blob/master/lisp/org-src.el#L1215
            ("s" org-edit-src-save "save")
            ("e" org-edit-src-exit "exit")
            ("a" org-edit-src-abort "abort"))
    :uru (org-mode deino-org (:color blue) "o o"
            "A deino for org-mode!"
            ("`" nil "cancel")
            ("t" org-babel-tangle "tangle")
            ("a" meq/org-babel-tangle-append "tangle append")
            ("F" org-babel-tangle-file "tangle file")
            ("n" meq/narrow-or-widen-dwim "narrow")
            ("s" org-edit-special "org edit special")
            ("e" deino-ob-export/body "export"))
    :gsetq
        ;; I'm using ox-pandoc
        ;; (org-export-backends '(md gfm latex odt org))
        (org-directory "/tmp")
        (org-roam-directory org-directory)
        (org-descriptive-links t)
        (org-startup-folded t)
        (org-src-fontify-natively t)
        ;; (org-src-window-setup 'current-window)
        (org-cycle-emulate-tab 'whitestart)

        ;; From:
        ;; Answer: https://emacs.stackexchange.com/a/60638/31428
        ;; User: https://emacs.stackexchange.com/users/29861/doltes
        (org-edit-src-content-indentation 0))
(delete "--anti-riot" command-line-args)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; vimrc-mode
(use-package vimrc-mode
    :straight (vimrc-mode :type git :host github :repo "mcandre/vimrc-mode" :branch "master")
    :commands
        (org-babel-execute:vimrc
        org-babel-expand-body:vimrc)
    :mode "\\.vim\\(rc\\)?\\'")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; xonsh-mode
(use-package xonsh-mode
    :straight (xonsh-mode :type git :host github :repo "seanfarley/xonsh-mode" :branch "master")
    :commands (org-babel-execute:xonsh org-babel-expand-body:xonsh)
    :mode ("\\.xonshrc\\'" "\\.xsh\\'")
    :init/defun*
        ;; Adapted From:
        ;; Answer: https://emacs.stackexchange.com/a/61442
        ;; User: https://emacs.stackexchange.com/users/20061/zeta
        (org-babel-execute:xonsh (body params)
            "Execute a block of Xonsh code with org-babel."
            (message "executing Xonsh source code block")
            (let ((in-file (org-babel-temp-file "x" ".xsh"))
                (opts (or (cdr (assoc :opts params)) nil))
                (args (or (cdr (assoc :args params)) nil)))
            (with-temp-file in-file
                (insert body))
            (org-babel-eval
                (format "xonsh %s %s %s"
                    (if (eq opts nil) "" opts)
                    (if (eq args nil) "" args)
                    (org-babel-process-file-name in-file))
            ""))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; doc
(use-package doc :straight nil
    :use-package-preconfig (yasnippet)
    :upnsd-preconfig (titan :load-path "../../lib/titan")
    :load-path "../../lib/doc"
    :mode (("\\.doc\\.md\\'" . doc-md-mode)
            ("\\.doc\\.org\\'" . doc-org-mode))
    :uru (doc-org-mode deino-doc-org (:color blue :inherit (deino-org-usually/heads)) "t d o"
            ("d" (meq/insert-snippet "org titan template") "template")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; fell
(use-package fell :straight nil
    :use-package-preconfig (yasnippet)
    :upnsd-preconfig (titan :load-path "../../lib/titan")
    :load-path "../../lib/fell"
    :mode (("\\.fell\\.md\\'" . fell-md-mode)
            ("\\.fell\\.org\\'" . fell-org-mode))
    :uru (fell-org-mode deino-fell-org (:color blue :inherit (deino-org-usually/heads)) "t f o"
            ("f" (meq/insert-snippet "org titan template") "template")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; doom-themes
(meq/up doom-themes
    :deino (deino-themes-light (:color blue) nil "A deino for light themes!" ("`" nil "cancel"))
        (deino-themes-dark (:color blue) nil "A deino for dark themes!" ("`" nil "cancel"))
    :sorrow ("t" :deino '(deino-themes nil "t" "A deino for themes!"
                ("s" meq/switch-theme-mode "switch to light / dark")
                ("l" deino-themes-light/body "light themes")
                ("d" deino-themes-dark/body "dark themes")
                ("`" nil "cancel")))
    :gsetq
        (doom-themes-enable-bold t)
        (doom-themes-enable-italic t)
        (meq/var/default-theme-override nil)
        (meq/var/default-default-theme 'dracula-purple-dark)
    :config
        (doom-themes-neotree-config)
        (doom-themes-org-config)

        (unless (meq/which-theme) (cond
            ((member "--purple" command-line-args)
                (delete "--purple" command-line-args)
                (meq/load-theme 'dracula-purple-dark))
            ((member "--orange" command-line-args)
                (delete "--orange" command-line-args)
                (meq/load-theme 'dracula-orange-dark))
            ((member "--red" command-line-args)
                (delete "--red" command-line-args)
                (meq/load-theme 'exo-ui-red-dark))
            ((member "--flamingo" command-line-args)
                (delete "--flamingo" command-line-args)
                (meq/load-theme 'herschel-flamingo-pink-dark))
            ((member "--blue" command-line-args)
                (delete "--blue" command-line-args)
                (meq/load-theme 'st-giles-blue-dark))
            ((member "--lio" command-line-args)
                (delete "--lio" command-line-args)
                (meq/load-theme 'lio-fotia-dark))
            (meq/var/phone (meq/load-theme 'orange-purple-light))
            (meq/var/default-theme-override (meq/load-theme meq/var/default-theme-override))
            (meq/var/current-theme (meq/load-theme meq/var/current-theme))
            ((meq/exwm-p) (meq/load-theme meq/var/default-default-theme))
            (t (meq/load-theme meq/var/default-default-theme))))

        (mapc #'(lambda (theme) (interactive)
            (let* ((name (symbol-name (car theme)))
                    (prefix (symbol-name (cdr theme)))
                    (light (concat name "-light"))
                    (dark (concat name "-dark")))
                (eval `(defdeino+ deino-themes-light nil
                    (,prefix (funcall #'meq/load-theme ',(intern light)) ,light)))
                (eval `(defdeino+ deino-themes-dark nil
                    (,prefix (funcall #'meq/load-theme ',(intern dark)) ,dark)))))
          '((dracula-purple . p)
            (dracula-orange . o)
            (exo-ui-red . r)
            (herschel-flamingo-pink . f)
            (st-giles-blue . b)
            (lio-fotia . l)
            (orange-purple . C-o)
            (flamingo-pink-purple . C-p))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; postface
(defvar meq/var/everything-else-initialized nil)
(defun meq/initialize-everything-else nil (interactive)

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; windmove
    (meq/up windmove
        :config (winner-mode)
        :deino (deino-wb nil nil ("b" deino-buffer/body "buffer") ("w" deino-window/body "window"))
        :sorrow ("w" :deino '(deino-window (:columns 5) "w"
            ("b" balance-windows "balance-windows")
            ("t" toggle-window-spilt "toggle-window-spilt")
            ("H" shrink-window-horizontally "shrink-window-horizontally")
            ("K" shrink-window "shrink-window")
            ("J" enlarge-window "enlarge-window")
            ("L" enlarge-window-horizontally "enlarge-window-horizontally")
            ("R" reverse-windows "reverse-windows")
            ("h" windmove-left "←")
            ("j" windmove-down "↓")
            ("k" windmove-up "↑")
            ("l" windmove-right "→")
            ("q" deino-move-splitter-left "X←")
            ("w" deino-move-splitter-down "X↓")
            ("e" deino-move-splitter-up "X↑")
            ("r" deino-move-splitter-right "X→")
            ("F" follow-mode "Follow")
            ("v" (lambda nil (interactive) (split-window-right) (windmove-right)) "vertical")
            ("x" (lambda nil (interactive) (split-window-below) (windmove-down)) "horizontal")
            ("S" save-buffer "save-buffer")
            ("d" delete-window "delete")
            ("o" delete-other-windows "only this")
            ("z" (progn (winner-undo) (setq this-command 'winner-undo)) "undo")
            ("Z" winner-redo "reset")
            ("`" nil "cancel"))))

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; ace-window
    (meq/up ace-window
        :deino+ (deino-window (:color red)
            ("a" (lambda nil (interactive) (ace-window 1) (add-hook 'ace-window-end-once-hook
                                                                    'deino-window/body)) "ace 1")
            ("s" (lambda nil (interactive) (ace-window 4) (add-hook 'ace-window-end-once-hook
                                                                    'deino-window/body)) "swap")
            ("D" (lambda nil (interactive) (ace-window 16) (add-hook 'ace-window-end-once-hook
                                                                    'deino-window/body)) "Delete Other")
            ("E" ace-swap-window "ace-swap-window")
            ("W" ace-delete-window "ace-delete-window" :exit t)))

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; alamode
    (meq/upnsd alamode :load-path "../../lib/alamode")

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; buffer
    (sorrow-key "b" :deino '(deino-buffer (:color red :columns 3) "b"
      "
                    Buffers :
      "
      ("`" nil "cancel")
      ("<right>" next-buffer "next")
      ("b" ivy-switch-buffer "switch" :color blue)
      ("B" ibuffer "ibuffer" :color blue)
      ("<left>" previous-buffer "prev")
      ("C-b" buffer-menu "buffer menu" :color blue)
      ("N" evil-buffer-new "new" :color blue)
      ("d" kill-this-buffer "delete")
      ;; don't come back to previous buffer after delete
      ("D" (progn (kill-this-buffer) (next-buffer)) "Delete")
      ("s" save-buffer "save")))

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; cosmog
    (meq/up cosmog
        :straight nil
        :load-path "../../lib/cosmog"
        :prime ("c" deino-cosmog/body "cosmog"))

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; evil
    (meq/up evil
        :use-package-preconfig (bind-map)
        :use-package-postconfig
            ;; Adapted From: https://github.com/mohsenil85/evil-evilified-state and
            ;; https://github.com/syl20bnr/spacemacs
            (evil-evilified-state
                :straight (evil-evilified-state
                    :type git
                    :host github
                    :repo "shadowrylander/evil-evilified-state"
                    :branch "master"))
        :gsetq (evil-escape-key-sequence nil)
        ;; :demon
            ;; TODO
            ;; ((alloy-chord "") 'meq/toggle-evil-ex-cosmoem)
        :leaf (evil :advice
            (:override evil-insert-state (lambda (&optional _) (interactive)
                (meq/disable-all-modal-modes))))
        :config
            ;; From: https://www.reddit.com/r/emacs/comments/lp45zd/help_requested_in_configuring_ryomodal/gp3rfx9?utm_source=share&utm_medium=web2x&context=3
            ;; Kept for documentation porpoises
            ;; (eval
            ;;       `(ryo-modal-keys
            ;;             ("l l" ,(alloy-simulate-key ":wq <RET>") :first '(evil-normal-state) :name "wq")
            ;;             ("l p" ,(alloy-simulate-key ":q <RET>") :first '(evil-normal-state) :name "q")
            ;;             ("l o" ,(alloy-simulate-key ":w <RET>") :first '(evil-normal-state) :name "w")
            ;;             ("l q" ,(alloy-simulate-key ":q! <RET>") :first '(evil-normal-state) :name "q!")))
    
            ;; Use to get command name:
            ;; Eg: (cdr (assoc "q" evil-ex-commands))
            ;; Then "C-x C-e" (eval-last-sexp)
    
            ;; TODO: How do I create a keymap `evil-ex-keymap' out of the `evil-ex-commands' alist?
    
            ;; (cosmoem-def :show-funs #'meq/evil-ex-cosmoem-show
            ;;     :hide-funs #'meq/evil-ex-cosmoem-hide
            ;;     :toggle-funs #'meq/evil-ex-cosmoem-toggle
            ;;     :keymap 'evil-ex-keymap
            ;;     ;; :transient t
            ;; )
    
            ;; (defun meq/evil-ex-cosmoem-toggle nil (interactive))
            ;; (defun meq/evil-ex-show-top-level nil (interactive)
            ;;     (meq/which-key-show-top-level 'evil-ex-keymap))
    
            ;; (defun meq/toggle-evil-ex (ua) (interactive "p")
            ;;     (if (= ua 4)
            ;;         (funcall 'meq/toggle-inner 'evil-mode "evil-ex" (meq/fbatp evil-mode) 'evil-ex-keymap nil t)
            ;;         (funcall 'meq/toggle-inner 'evil-mode "evil-ex" (meq/fbatp evil-mode) 'evil-ex-keymap)))
            ;; (defun meq/toggle-evil-ex-cosmoem (ua) (interactive "p")
            ;;     (if (= ua 4)
            ;;         (funcall 'meq/toggle-inner 'evil-mode "evil-ex" (meq/fbatp evil-mode) 'evil-ex-keymap t t)
            ;;         (funcall 'meq/toggle-inner 'evil-mode "evil-ex" (meq/fbatp evil-mode) 'evil-ex-keymap t)))
        )

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; helm
    (meq/up helm
        ;; :commands (helm-M-x helm-mini helm-mode)
        :deino+ (deino-execute nil
                    ("h" helm-smex-major-mode-commands "helm smex major mode")
                    ("s" helm-smex "helm smex"))
                (deino-window nil ("B" helm-mini "helm-mini")
                    ("f" helm-find-files "helm-find-files"))
        :use-package-postconfig ;; Adapted From: https://github.com/clemera/helm-ido-like-guide
            (helm-smex)
            (helm-flx)
            (helm-swoop)
            (helm-ido-like
                :straight (helm-ido-like
                    :type git
                    :host github
                    :repo "shadowrylander/helm-ido-like-guide"
                    :branch "master")))

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; magit
    (meq/up magit :deino (deino-magit (:color blue :columns 8) "g"
      "It's just like magit!"
      ("s" magit-status "status")
      ("c" magit-checkout "checkout")
      ("b" magit-branch-manager "branch manager")
      ("m" magit-merge "merge")
      ("l" magit-log "log")
      ("c" magit-git-command "command")
      ("p" magit-process "process")
      ("`" nil "cancel")))

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; modalka
    (meq/up modalka)

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; objed
    (meq/up objed)

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; one-on-one
    ;; !!! THE ORDER HERE MATTERS! !!!
    (meq/up oneonone
        :if (not (meq/exwm-p))
        :load-emacs-file-preconfig
            ("fit-frame") ("autofit-frame")
            ;; ("buff-menu+")
            ("compile-") ("compile+") ("grep+") ("dired+") ("dired-details") ("dired-details+")
            ("doremi") ("hexrgb") ("frame-fns") ("faces+") ("doremi-frm") ("eyedropper") ("facemenu+")
            ("frame+") ("help+") ("info+") ("menu-bar+") ("mouse+") ("setup-keys") ("strings")
            ;; ("simple+")
            ("frame-cmds") ("thumb-frm") ("window+") ("zoom-frm") ("oneonone")
        :gsetq
            (1on1-minibuffer-frame-width 10000)
            (1on1-minibuffer-frame-height 10000))

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; projectile
    (meq/up projectile
        :use-package-preconfig (counsel-projectile :config (counsel-projectile-mode 1)) (helm-projectile)
        :sorrow ("p" :deino '(deino-projectile
                    (:color teal :columns 4) "p p"
                    ("a"   counsel-projectile-ag "counsel-projectile-ag")
                    ("g"   counsel-projectile-rg "counsel-projectile-rg")
                    ("c"   counsel-projectile "counsel-projectile")
                    ("b"   counsel-projectile-switch-to-buffer "switch to buffer")
                    ("C"   projectile-invalidate-cache "cache clear")
                    ("d"   counsel-projectile-find-dir "find-dir")
                    ("f"   counsel-projectile-find-file "find-file")
                    ("F"   counsel-projectile-find-file-dwim "find-file-dwim")
                    ("C-f" projectile-find-file-in-directory "find-file-in-dir")
                    ("G"   ggtags-update-tags "update gtags")
                    ("i"   projectile-ibuffer "Ibuffer")
                    ("K"   projectile-kill-buffers "kill all buffers")
                    ("o"   projectile-multi-occur "multi-occur")
                    ("p"   counsel-projectile-switch-project "switch project")
                    ("r"   projectile-recentf "recent file")
                    ("x"   projectile-remove-known-project "remove known project")
                    ("X"   projectile-cleanup-known-projects "cleanup non-existing projects")
                    ("z"   projectile-cache-current-file "cache current file")
                    ("h"   deino-helm-projectile/body "deino-helm-projectile")
                    ("`"   nil "cancel")))
                ("P" :deino '(deino-helm-projectile
                    (:color teal :columns 4) "p h"
                    ("h"   helm-projectile "helm-projectile")
                    ("c"   helm-projectile-switch-project "switch-project")
                    ("f"   helm-projectile-find-file "find-file")
                    ("F"   helm-projectile-find-file-dwim "find-file-dwim")
                    ("d"   helm-projectile-find-dir "find-dir")
                    ("r"   helm-projectile-recentf "recent file")
                    ("b"   helm-projectile-switch-to-buffer "switch to buffer")
                    ("a"   helm-projectile-ag "helm-projectile-ag")
                    ("g"   helm-projectile-rg "helm-projectile-rg")
                    ("C-f" helm-projectile-find-file-in-known-projects "find file in known projects")
                    ("`"   nil "cancel"))))

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; restart-emacs
    (meq/up restart-emacs)

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; ryo modal
    (meq/up ryo-modal
        :straight (ryo-modal :type git :host github :repo "kungsgeten/ryo-modal" :branch "master")
        :config ;; From: https://github.com/Kungsgeten/ryo-modal#which-key-integration
            (push '((nil . "ryo:.*:") . (nil . "")) which-key-replacement-alist))

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; vterm
    (meq/up vterm :use-package-postconfig (multi-vterm)
        :gsetq
            (vterm-shell (meq/ued1 "vterm-start.sh"))
            (vterm-always-compile-module t)
            (vterm-kill-buffer-on-exit t))

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; xah-fly-keys
    (meq/up xah-fly-keys
        :commands xah-fly-keys
        :sorrow ("m" :deino
                    '(modal-modes (:color blue) "m"
                        "A modal deino!"
                        ("`" nil "cancel")
                        ("x" meq/toggle-xah "xah-fly-keys")) :name "modal modes"))

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; yankpad
    (setq meq/var/yankpad-file (meq/ued1 "yankpad.org"))
    (meq/up yankpad
        :if (not (member "--disable-yankpad" command-line-args))
        :init/defun* (meq/yankpad-cosmoem-toggle nil (interactive))
            (meq/remove-default-yankpad-buffer nil
                (let* ((yankpad-file meq/var/yankpad-file)
                        (yankpad-buffer (get-file-buffer yankpad-file)))
                    (when (and
                            (when yankpad-buffer (get-buffer yankpad-buffer))
                            (not (string= (expand-file-name (car (last command-line-args))) yankpad-file)))
                        (kill-buffer yankpad-buffer))))
        :gsetq (yankpad-file meq/var/yankpad-file)
        :config (yankpad-map) (meq/remove-default-yankpad-buffer)
        :cosmoem
            (:show-funs #'meq/yankpad-cosmoem-show
                :hide-funs #'meq/yankpad-cosmoem-hide
                :toggle-funs #'meq/yankpad-cosmoem-toggle
                :keymap 'yankpad-keymap
                ;; :transient t
            ))
    (delete "--disable-yankpad" command-line-args)

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    (setq meq/var/everything-else-initialized t))

(with-eval-after-load 'alloy (mapc #'(lambda (kons) (interactive)
    (let* ((func (meq/inconcat "mec/" (symbol-name (cdr kons)))))
        (eval `(alloy-def
                    :keymaps demon-run
                    (alloy-chord ,(car kons))
                    ',func))
        (eval `(defun ,func nil (interactive)
                    (unless meq/var/everything-else-initialized (meq/initialize-everything-else))
                    (,(cdr kons)))))) '(("  " . universal-argument)
                                        ("''" . aiern-ex)
                                        ("[[" . meq/yankpad-cosmoem-toggle)
                                        ("]]" . yankpad-expand)
                                        ("\"\"" . evil-ex)
                                        ("\\\\" . meq/toggle-which-key)
                                        ("aa" . deino-restart/body)
                                        ("hh" . meq/god-execute-with-current-bindings)
                                        ("ii" . minoru)
                                        ("jj" . meq/aiern-execute-with-current-bindings)
                                        ("KK" . meq/ryo-execute-with-current-bindings)
                                        ("kk" . meq/sorrow-execute-with-current-bindings)
                                        ("uu" . uru)
                                        ("vv" . meq/shell)
                                        ("ww" . deino-wb/body)
                                        ("zz" . meq/after-init))))
(alloy-def :keymaps 'universal-argument-map (alloy-chord "  ") 'universal-argument-more)
(alloy-def :keymaps '(override aiern-insert-state-map evil-insert-state-map)
    (naked "RET") 'newline-and-indent
    (alloy-chord ";'") 'meq/end-of-line-and-indented-new-line)

(run-with-idle-timer 30 nil 'meq/initialize-everything-else)

(when (member "--update" command-line-args) (delete "--update" command-line-args) (meq/straight-upgrade))

(let* ((testing (meq/ued1 "testing.aiern.org"))
        (resting (meq/ued1 "resting.aiern.org"))
        (init (meq/ued1 "init.el"))
        (README (meq/ued1 "README.org"))
        (dInit (meq/ued2 "init.el"))
        (dREADME (meq/ued2 "README.org")))
    (if (= (length command-line-args) 1)
        (setq initial-buffer-choice testing)
        (cond ((member "--fTest" command-line-args)
                    (setq initial-buffer-choice testing)
                    (delete "--fTest" command-line-args))
            ((member "--fInit" command-line-args)
                    (setq initial-buffer-choice init)
                    (delete "--fInit" command-line-args))
            ((member "--fEarly" command-line-args)
                    (setq initial-buffer-choice (meq/ued1 "early-init.el"))
                    (delete "--fEarly" command-line-args))
            ((member "--fREADME" command-line-args)
                    (setq initial-buffer-choice README)
                    (delete "--fREADME" command-line-args))
            ((member "--fdInit" command-line-args)
                    (setq initial-buffer-choice dInit)
                    (delete "--fdInit" command-line-args))
            ((member "--fdEarly" command-line-args)
                    (setq initial-buffer-choice (meq/ued@ "early-init.el"))
                    (delete "--fdEarly" command-line-args))
            ((member "--fdREADME" command-line-args)
                    (setq initial-buffer-choice dREADME)
                    (delete "--fdREADME" command-line-args))
            (t (setq initial-buffer-choice (expand-file-name (car (last command-line-args))))))
    (add-hook 'kill-emacs-hook #'(lambda nil (interactive)
        ;; Adapted From: http://ergoemacs.org/emacs/elisp_file_name_dir_name.html
        (when (get-file-buffer testing)
            (delete-file testing)
            (copy-file resting testing))))
    (add-hook 'after-init-hook #'(lambda nil (interactive) (meq/generate-obdar init README)))))