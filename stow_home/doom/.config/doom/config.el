(setq doom-theme 'doom-one)

(setq doom-font (font-spec :family "JetBrains Mono" :size 15)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 15)
      ;;doom-variable-pitch-font (font-spec :family "Ubuntu" :size 15)
      doom-big-font (font-spec :family "JetBrains Mono" :size 24))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq display-line-numbers-type t)
(map! :leader
      :desc "Comment or uncomment lines" "TAB TAB" #'comment-line
      (:prefix ("t" . "toggle")
       :desc "Toggle line numbers" "l" #'doom/toggle-line-numbers
       :desc "Toggle line highlight in frame" "h" #'hl-line-mode
       :desc "Toggle line highlight globally" "H" #'global-hl-line-mode
       :desc "Toggle truncate lines" "t" #'toggle-truncate-lines))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(setq lsp-lens-enable t)
(setq lsp-lens-place-position 'above-line)

(after! rustic
  (setq rustic-lsp-server 'rust-analyzer)
  (setq rustic-format-on-save t)
  (setq lsp-rust-analyzer-cargo-watch-command "clippy")
  (setq lsp-rust-analyzer-cargo-load-out-dirs-from-check t)
  (setq lsp-rust-analyzer-proc-macro-enable t)
  (setq lsp-rust-analyzer-display-chaining-hints t)
  (setq lsp-rust-analyzer-display-parameter-hints t)
  (setq lsp-rust-analyzer-server-display-inlay-hints t)
  (setq lsp-rust-all-features t)
  (setq lsp-rust-full-docs t))

;; Disable file watchers
(setq lsp-enable-file-watchers nil)
;; Disable sideline
(setq lsp-ui-sideline-enable nil)

;;(use-package! lsp-rust
;;  :config
;;  (setq! lsp-rust-analyzer-cargo-watch-enable t
;;         lsp-rust-analyzer-cargo-watch-command "clippy"
;;         lsp-rust-analyzer-proc-macro-enable t
;;         lsp-rust-analyzer-cargo-load-out-dirs-from-check t
;;         lsp-rust-analyzer-inlay-hints-mode t
;;         lsp-rust-analyzer-display-chaining-hints t
;;         lsp-rust-analyzer-display-parameter-hints t))
