(require 'browse-url)
(require 'thingatpt)
;; w3m-url-encode-string �� rename �� (w3m.el �����ĂȂ�����)
(defun my-url-encode-string (str &optional coding)
  (apply (function concat)
         (mapcar
          (lambda (ch)
            (cond
             ((eq ch ?\n)               ; newline
              "%0D%0A")
             ((string-match "[-a-zA-Z0-9_:/]" (char-to-string ch)) ; xxx?
              (char-to-string ch))      ; printable
             ((char-equal ch ?\x20)     ; space
              "+")
             (t
              (format "%%%02X" ch))))   ; escape
          ;; Coerce a string to a list of chars.
          (append (encode-coding-string (or str "") (or coding 'iso-2022-jp))
                  nil))))

;; google �Ō����B������������ mini-buffer �ŕҏW�ł���B
(defun google (str &optional flag)
  "google �Ō����B������������ mini-buffer �ŕҏW�ł���B"
  (interactive
   (list (cond ((or
                 ;; mouse drag �̌�ŌĂяo���ꂽ�ꍇ
                 (eq last-command 'mouse-drag-region) ; for emacs
                 (and (eq last-command 'mouse-track) ; for xemacs
                      (boundp 'primary-selection-extent)
                      primary-selection-extent)
                 ;; region ������
                 (and (boundp 'transient-mark-mode) transient-mark-mode
                      (boundp 'mark-active) mark-active) ; for emacs
                 (and (fboundp 'region-active-p)
                      (region-active-p)) ; for xemacs
                 ;; point �� mark �����ւ�����
                 (eq last-command 'exchange-point-and-mark))
                (buffer-substring-no-properties
                 (region-beginning) (region-end)))
               (t (thing-at-point 'sexp)))
         current-prefix-arg))
  (if flag
      nil
    (setq str (read-from-minibuffer "Google search: " str)))
  (browse-url
   (concat
    "http://www.google.com/search?q="
    (my-url-encode-string str 'shift_jis)
    "&hl=ja&lr=lang_ja")))
