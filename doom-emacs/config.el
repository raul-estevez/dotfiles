;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-homage-black)
;; Specify both a dark and light theme, like so and Doom will choose which one
;; to load based on your system light/dark setting:
;;
;;   (setq doom-theme '(doom-one   . doom-one-light))   ; (DARK . LIGHT)
;;
;; If you want more pro-active theme switching based on OS light/dark mode, look
;; up the `auto-dark' package.

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'visual)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
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

(add-hook 'prog-mode-hook #'subword-mode)

(setq org-directory "~/tfm/"
      org-roam-directory "~/tfm/notes/"
      org-roam-dailies-directory "daily/"
      org-agenda-files '("~/tfm/gtd/")
      citar-bibliography '("~/tfm/bib/library.bib")
      citar-library-paths '("~/Zotero/storage/")
      citar-notes-paths '("~/tfm/notes/literature/")
      org-noter-notes-search-path '("~/tfm/notes/literature/"))
(after! citar
  (setq citar-org-roam-subdir "literature")
  (citar-org-roam-mode))


(setq doom-leader-key ",")
(after! evil
  ;; Use the black hole register for ordinary deletions
  (define-key evil-normal-state-map (kbd "x")
    (lambda ()
      (interactive)
      (let ((evil-this-register ?_))
        (call-interactively #'evil-delete-char))))

  (define-key evil-normal-state-map (kbd "d")
    (lambda ()
      (interactive)
      (let ((evil-this-register ?_))
        (call-interactively #'evil-delete))))

  (define-key evil-visual-state-map (kbd "d")
    (lambda ()
      (interactive)
      (let ((evil-this-register ?_))
        (call-interactively #'evil-delete))))

  (define-key evil-normal-state-map (kbd "D")
    (lambda ()
      (interactive)
      (let ((evil-this-register ?_))
        (call-interactively #'evil-delete-line))))

  ;; Leader d uses the default register
  (map! :leader
        :n "d" #'evil-delete
        :v "d" #'evil-delete))

(after! evil
  ;; Move current line up/down
  (map! :n "C-k" (cmd! (transpose-lines 1)
                       (forward-line -1))
        :n "C-j" (cmd! (forward-line 1)
                       (transpose-lines 1)
                       (forward-line -1)))

  ;; Move selected lines up/down
  (map! :v "C-k" (cmd! (let ((col (current-column)))
                         (evil-normal-state)
                         (transpose-lines 1)
                         (forward-line -2)
                         (evil-visual-restore)))
        :v "C-j" (cmd! (let ((col (current-column)))
                         (evil-normal-state)
                         (forward-line 1)
                         (transpose-lines 1)
                         (evil-visual-restore))))
)

(after! evil
  (map! :n "C-o" (cmd! (evil-open-below 1)
                       (evil-normal-state))))
(after! dired
  (map! :map dired-mode-map
        :n "_" #'dired-create-empty-file))

;; Disable the rendering of \alpha and such
(defun my/disable-latex-prettification ()
  (when (derived-mode-p 'TeX-mode)
    (prettify-symbols-mode -1)))

(add-hook 'after-change-major-mode-hook #'my/disable-latex-prettification 90)

(after! latex
  (setq TeX-fold-auto nil)
  (remove-hook 'LaTeX-mode-hook #'TeX-fold-mode)
  (remove-hook 'TeX-mode-hook #'TeX-fold-mode))
  (setq font-latex-fontify-script nil)


;; Auto pdf and etc 

(after! latex
  (setq +latex-viewers '(pdf-tools)
        TeX-command-default "LatexMk"
        TeX-save-query nil
        TeX-source-correlate-method 'synctex
        TeX-source-correlate-start-server t
        TeX-command-extra-options "-synctex=1")
  (add-hook 'TeX-mode-hook #'TeX-source-correlate-mode)
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
  (add-hook 'LaTeX-mode-hook #'laas-mode))

(defun my/latex-compile-on-save ()
  (when (and buffer-file-name
             (derived-mode-p 'LaTeX-mode))
    (TeX-command-run-all nil)))

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (add-hook 'after-save-hook
            #'my/latex-compile-on-save
            nil t)))

(add-to-list 'display-buffer-alist
             '("\\.pdf\\'"
               (display-buffer-pop-up-window)
               (inhibit-same-window . t)))


;; Trigger inside another snippet and not jump to next placeholder
(defun my/yas (template)
  "Return a command that expands TEMPLATE with yasnippet."
  (lambda () (interactive) (yas-expand-snippet template)))

;; Laas automatic expansion snippets
(after! laas
  (aas-set-snippets 'laas-mode
    :cond (lambda () (not (texmathp)))
    "mk" (my/yas "\\$$1\\$$0")
    :cond #'texmathp
    "inf" "\\infty"
    "iff" "\\iff"
    "imp" "\\implies"
    "ra" "\\rightarrow"
    "la" "\\leftarrow"
    "sq" "^2"
    "tpi" "2\\pi"
    "int" "\\int"
    ;; lowercase
    "aa" "\\alpha"
    "bb" "\\beta"
    "gg" "\\gamma"
    "dd" "\\delta"
    "ee" "\\epsilon"
    "zz" "\\zeta"
    "hh" "\\eta"
    "th" "\\theta"
    "ii" "\\iota"
    "kk" "\\kappa"
    "ll" "\\lambda"
    "mm" "\\mu"
    "nn" "\\nu"
    "xx" "\\xi"
    "pp" "\\pi"
    "rr" "\\rho"
    "ss" "\\sigma"
    "tt" "\\tau"
    "uu" "\\upsilon"
    "ph" "\\phi"
    "cc" "\\chi"
    "ps" "\\psi"
    "oo" "\\omega"
    ;; uppercase
    "GG" "\\Gamma"
    "DD" "\\Delta"
    "TH" "\\Theta"
    "LL" "\\Lambda"
    "XX" "\\Xi"
    "PP" "\\Pi"
    "SS" "\\Sigma"
    "UU" "\\Upsilon"
    "FF" "\\Phi"
    "PS" "\\Psi"
    "WW" "\\Omega"
    ;; Yas queen
    "rt" (my/yas "\\\\sqrt{$1}")
    "ff" (my/yas "\\\\frac{$1}{$2} $0")
    "lim" (my/yas "\\\\lim_{${1:n} \\\\to ${2:\\\\infty}} $0")
    "sum" (my/yas "\\\\sum_{${1:i=1}}^{${2:n}} $0")
    "sub" (my/yas "_{$1} $0")
    "of" (my/yas "($1) $0")
    "td" (my/yas "^{$1} $0")
    "sin" (my/yas "\\\\sin{$1} $0")
    "cos" (my/yas "\\\\cos{$1} $0")
    "ln" (my/yas "\\\\ln{$1} $0")
    "log" (my/yas "\\\\log{$1} $0")
    "tan" (my/yas "\\\\tan{$1} $0")
    "arcsin" (my/yas "\\\\arcsin{$1} $0")
    "arccos" (my/yas "\\\\arccos{$1} $0")
    "atan" (my/yas "\\\\atan{$1} $0")
    "hat" (my/yas "\\\\hat{$1} $0")
    "ee" (my/yas "\\\\mathrm{e}^{$1} $0")
    "pp" (my/yas "\\\\partial_{${1:t}} $0")
    "dint" (my/yas "\\\\int_{$1}^{$2} $0")
))


(after! yasnippet
  (setq yas-triggers-in-field t)
  (map! :map yas-keymap
        "TAB"   #'yas-next-field-or-maybe-expand
        [tab]   #'yas-next-field-or-maybe-expand
        "<tab>" #'yas-next-field-or-maybe-expand))


(add-hook 'LaTeX-mode-hook #'yas-minor-mode)
(add-hook 'laas-mode-hook #'yas-minor-mode)

(add-hook 'snippet-mode-hook
          (lambda () (setq-local require-final-newline nil)))

(after! citar
  (citar-org-roam-mode))

;; Smooth scrolling to pdf-view
;; I've disable it because it does not work well with zoom
;; (add-hook 'pdf-view-mode-hook #'pdf-view-roll-minor-mode)

(use-package! org-pdftools
  :hook (org-mode . org-pdftools-setup-link))

;; This shows hidden files but not ./ and ../ (I guess?)
(after! dired
  (setq dired-listing-switches "-l --almost-all --human-readable"))
