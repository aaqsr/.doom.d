;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Awab Q"
      user-mail-address "awab.qureshi@gmail.com")

;; Utility function to add multiple lists to a list
(defun add-list-to-list (dst src)
  "Similar to `add-to-list', but accepts a list as 2nd argument"
  (set dst
       (append (eval dst) src)))

;; utility function to load other files
;; (defconst user-init-dir
;;   (cond ((boundp 'user-emacs-directory)
;;          user-emacs-directory)
;;         ((boundp 'user-init-directory)
;;          user-init-directory)
;;         (t "~/.doom.d/")))

;; (defun load-user-file (file)
;;   (interactive "f")
;;   "Load a file in current user's configuration directory"
;;   (load-file (expand-file-name file user-init-dir)))

;; loads file with spotify api keys to not expose them to source control
(load-file "~/.doom.d/spotifyKeys.el")
;; This will be a file with two lines:
;; (setq counsel-spotify-client-id "")
;; (setq counsel-spotify-client-secret "")
;; Get keys from the Spotify Dev Console



;; :q should kill the current buffer rather than quitting emacs entirely
(evil-ex-define-cmd "q" 'kill-this-buffer)
;; same behaviour for :wq
(evil-define-command kill-not-quit ()
  (save-buffer)
  (kill-this-buffer)
)
(evil-ex-define-cmd "wq" 'kill-not-quit)
;; Need to type out :quit to close emacs
(evil-ex-define-cmd "quit" 'evil-quit)

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;; (setq doom-font (font-spec :family "Fira Code" :size 14 :weight 'semi-light) ;; Can't decide b/w this and medium
(setq doom-font (font-spec :family "Fira Code" :size 14 :weight 'medium)
      doom-unicode-font (font-spec :family "Fira Code" :size 14 :weight 'semi-light)
      ;; doom-variable-pitch-font (font-spec :family "CMU Serif" :size 14) ;; This break org-mode font : makes it too small
      doom-serif-font (font-spec :family "CMU Serif" :size 14)
      )
;;



(defface doom-dashboard-quote '((t (:family "CMU Serif" :height 200 :width expanded :slant italic) ))
  "Face used for the quote"
)
(defvar doom-dashboard-quote 'doom-dashboard-quote)

;; Removes menu items
;; (defvar +doom-dashboard-menu-custom (car-safe +doom-dashboard-menu-sections))

;; (setq +doom-dashboard-menu-sections (cl-subseq +doom-dashboard-menu-sections 0 3))

;; (add-list-to-list '+doom-dashboard-menu-sections
;;   '(("Open documentation"
;;     :icon (all-the-icons-octicon "book" :face 'doom-dashboard-menu-title)
;;     :action doom/help)
;;     )
;; )

;; (setq +doom-dashboard-menu-sections +doom-dashboard-menu-custom)
;;

;; I gave up on doing that and am just overwriting the menu here
(setq +doom-dashboard-menu-sections
  '(("Reload Last Session"
     :icon (all-the-icons-octicon "history" :face 'doom-dashboard-menu-title)
     :when (cond ((featurep! :ui workspaces)
                  (file-exists-p (expand-file-name persp-auto-save-fname persp-save-dir)))
                 ((require 'desktop nil t)
                  (file-exists-p (desktop-full-file-name))))
     :face (:inherit (doom-dashboard-menu-title bold))
     :action doom/quickload-session)

    ("Recently Opened Files"
     :icon (all-the-icons-octicon "file-text" :face 'doom-dashboard-menu-title)
     :action recentf-open-files)

    ("Search Org Roam Notes"
     :icon (all-the-icons-faicon "book" :face 'doom-dashboard-menu-title)
     :action org-roam-node-find)

    ("Open Org-agenda"
     :icon (all-the-icons-octicon "calendar" :face 'doom-dashboard-menu-title)
     :when (fboundp 'org-agenda)
     :action org-agenda)

    ;; ("Play In Rainbows on Spotify"
    ;;  :icon (all-the-icons-faicon "music" :face 'doom-dashboard-menu-title)
    ;;  :action (counsel-spotify-play-string "Radiohead - In Rainbows"))
  )
)

;; #("Radiohead - In Rainbows" 0 23
;;   (spotify-object #s(counsel-spotify-album "In Rainbows" "spotify:album:5vkqYmiPBYLaalcmjujWxK" "Radiohead")))


(defun doom-dashboard-widget-quote ()
  (insert "\n\n"
   (propertize
    (+doom-dashboard--center 90
     "today has been the most perfect day I have ever seen"
     )
    'face 'doom-dashboard-quote
    )
   "\n")
)

;; Removes the source icon at the bottom (sorry) becs it was clipping at my font size
;; Also adds in my quote widget because y not
(setq +doom-dashboard-functions
      '(doom-dashboard-widget-banner
        doom-dashboard-widget-shortmenu
        doom-dashboard-widget-quote
        doom-dashboard-widget-loaded
        )
)


;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Fixes strange bug with external keyboard where the left option key is reported as the right one
;; This makes it so that emacs does not recognise it as the meta key instead using some dumb apple functionality
;; it just sets the right one to be meta as well cause who cares about whatever apple made the right one do
(setq mac-right-option-modifier 'meta)



;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-agenda-files "~/org/agenda.org")
(after! org
  ;; Makes latex work better on retina https://stackoverflow.com/questions/30151338/org-latex-preview-is-fuzzy-on-retina-displays
  (setq org-preview-latex-default-process 'dvisvgm)

  (setq org-log-done 'time)

  ;; This doesn't work for some reason. But does work if i uncomment the hook line below but
  ;; Fix it.
  (require 'org-bullets)
  (after! org-bullets
    (add-hook 'org-mode-hook ( lambda () (org-bullets-mode 1)))
        ; replace lists starting with - to start with the list dot
    (font-lock-add-keywords 'org-mode
                            '(("^ *\\([-]\\) "
                            (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•")))))))
  ;; but this breaks auto latex preview for some reason
  ;; (add-hook 'org-mode-hook ( lambda () (
  ;;   (setq display-line-numbers-type 't))))

  ;; Org capture template for Exam todo list
  (add-list-to-list 'org-capture-templates '(
        ;; "e" "Exam todo list" entry
        ;;  (file+headline "~/org/examTodo.org" "cie")
        ;;  "** TODO  %^{Todo} %? \n %i %a"
        ;; :prepend t
        ;; :empty-lines 1
        ;; :created t

        ( "e" "Exam todo list" )
        ("ef" "Further Todo" entry
                (file+headline "~/org/examTodo.org" "furth")
                "*** TODO %? %(org-set-tags \"furtherMaths\") \n %i %a"
                :prepend t
                :empty-lines 1
                :created t
        )
        ("ec" "Chem Todo" entry
                (file+headline "~/org/examTodo.org" "chem")
                "*** TODO %? %(org-set-tags \"Chemistry\") \n %i %a"
                :prepend t
                :empty-lines 1
                :created t
        )
        ("ep" "Phys Todo" entry
                (file+headline "~/org/examTodo.org" "phys")
                "*** TODO %? %(org-set-tags \"Physics\") \n %i %a"
                :prepend t
                :empty-lines 1
                :created t
        )
        ("em" "Maths Todo" entry
                (file+headline "~/org/examTodo.org" "math")
                "*** TODO %? %(org-set-tags \"Maths\") \n %i %a"
                :prepend t
                :empty-lines 1
                :created t
        )
  ))

  (setq org-roam-directory (file-truename "~/org/roam"))
  (org-roam-db-autosync-mode)
  (after! org-roam

    ; Make a new property called type that is defined by note directory
    (cl-defmethod org-roam-node-type ((node org-roam-node))
    "Return the TYPE of NODE."
    (condition-case nil
    (file-name-nondirectory
    (directory-file-name
            (file-name-directory
            (file-relative-name (org-roam-node-file node) org-roam-directory))))
    (error "")))

    ; Add this to the list when finding notes
    (setq org-roam-node-display-template
      (concat "${type:15} ${title:*} " (propertize "${tags:10}" 'face 'org-tag)))

    ; capture templates for A levels notes for now
    (setq org-roam-capture-templates
      '(("c" "A levels Chem Note" plain
         "%?"
         :if-new (file+head "alevels/chem/${slug}.org"
                            "#+title: ${title}\n")
         ;; :immediate-finish t
         :unnarrowed t)
        ("p" "A levels Phys Note" plain
              "%?"
              :if-new (file+head "alevels/phys/${slug}.org"
                              "#+title: ${title}\n")
              ;; :immediate-finish
              :unnarrowed t)
        ("f" "A levels Further Note" plain
              "%?"
              :if-new (file+head "alevels/furth/${slug}.org"
                              "#+title: ${title}\n")
              ;; :immediate-finish
              :unnarrowed t)

       )
    )
  )
  ;; configuring Org to look prettier acc to https://zzamboni.org/post/beautifying-org-mode-in-emacs/
  (setq org-hide-emphasis-markers t) ; hide the emphasis markup

  ;; (require 'org-bullets)
  ;; (add-hook 'org-mode-hook ( lambda () (org-bullets-mode 1)))

  ;; ; replace lists starting with - to start with the list dot
  ;;  (font-lock-add-keywords 'org-mode
  ;;                         '(("^ *\\([-]\\) "
  ;;                            (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

   ; setting theme
   ;; (defun org-mode-theme-setter ()
   ;;      (face-remap-add-relative 'default
   ;;              ;; :background "lightgrey"
   ;;              ;; :foreground "white"
   ;;              (setq doom-theme 'doom-nord-light)
   ;;      ))

   ;; (add-hook 'org-mode-hook #'org-mode-theme-setter)


   ; setting fonts
   (let* ((variable-tuple
          (cond ((x-list-fonts "ETBembo")         '(:font "ETBembo"))
                ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
                ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
                ((x-list-fonts "Verdana")         '(:font "Verdana"))
                ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
                (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
         ;; (base-font-color     (face-foreground 'default nil 'default))
          (headline           `(:inherit default :weight bold
                                ;; :foreground ,base-font-color
                                )))

    (custom-theme-set-faces
     'user
     `(org-level-8 ((t (,@headline ,@variable-tuple))))
     `(org-level-7 ((t (,@headline ,@variable-tuple))))
     `(org-level-6 ((t (,@headline ,@variable-tuple))))
     `(org-level-5 ((t (,@headline ,@variable-tuple))))
     `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
     `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.2))))
     `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.3))))
     `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.4))))
     `(org-document-title ((t (,@headline ,@variable-tuple :height 1.5
                                          :underline nil
                                          ))))))

   (custom-theme-set-faces
   'user
   '(variable-pitch ((t (:family "CMU Serif" :height 170))))
   '(fixed-pitch ((t ( :family "Fira Code" :height 165)))))
   (add-hook 'org-mode-hook 'variable-pitch-mode)
    (add-hook 'org-mode-hook 'visual-line-mode)
     (custom-theme-set-faces
   'user
   '(org-block ((t (:inherit fixed-pitch))))
   '(org-code ((t (:inherit (shadow fixed-pitch)))))
   '(org-document-info ((t (:foreground "dark orange"))))
   '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
   '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
   '(org-link ((t (:foreground "royal blue" :underline t))))
   '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-property-value ((t (:inherit fixed-pitch))) t)
   '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
   '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
   '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))




)




;; (server-start)

;; Suggesting autocompletion for coding -- rebind if it breaks anything else
;; https://www.youtube.com/watch?v=QRmKpqDP5yE mapping tutorial
;; (map! :leader
;; ;;    (:prefix ("<somekey>" . "<Some description>")
;;       :desc "<some desc.>"
;;       "<some key>" #'<some function>
;; )

;Insert image from clipboard
(map! ; :map org-mode-map
      :leader
      (:prefix "i"
      (:prefix ("i" . "Images")
       :desc "Insert image from clipboard into org-file"
       "p" #'org-download-clipboard
)))

(map!
 :leader
 (:prefix "n"
  (:prefix ("r" . "Roam")
   :desc "Find Node / Create Node"
   "f" #'org-roam-node-find
)))


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; Package init
(use-package! lsp-grammarly
  :ensure t
  :hook (text-mode . (lambda ()
                       (require 'lsp-grammarly)
                       (lsp))))

(add-hook 'org-mode-hook 'org-fragtog-mode)
(use-package! laas
  :hook (LaTeX-mode . laas-mode)
  :hook (org-mode . laas-mode)
  :config ; do whatever here
  (aas-set-snippets 'laas-mode
                    ;; set condition!
                    :cond #'texmathp ; expand only while in math
                    "supp" "\\supp"
                    "On" "O(n)"
                    "O1" "O(1)"
                    "Olog" "O(\\log n)"
                    "Olon" "O(n \\log n)"
                    ;; bind to functions!
                    "Sum" (lambda () (interactive)
                            (yas-expand-snippet "\\sum_{$1}^{$2} $0"))
                    "Span" (lambda () (interactive)
                             (yas-expand-snippet "\\Span($1)$0"))
                    ;; add accent snippets
                    :cond #'laas-object-on-left-condition
                    "qq" (lambda () (interactive) (laas-wrap-previous-object "sqrt"))))

(require 'org-download)
(after! org-download
  ;; Drag-and-drop to `dired`
  (add-hook 'dired-mode-hook 'org-download-enable)
)
