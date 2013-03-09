;;
;; Filename: tags-file-create-recursive.el
;; Last modified: Fri Mar 03 2006 13:51:45 LMT
;; Author: gnrr
;;
;; description:
;;      �w��̃f�B���N�g���z���ɁA�ҏW���̃t�@�C���Ɏ�����TAGS�t�@�C����
;;      �ċA�I�ɍ쐬����
;;
;; requirements:
;;      find, xargs, (etags)
;;
;; usage:
;;      M-x tags-file-create-recursive
;;
;;
;; install:
;;      add into your dot.emacs.
;;
;;      (require 'tags-file-create-recursive)
;;
;;
;; customize:
;;       �Ⴆ�Ίg���q *.asm �̃A�Z���u���\�[�X�Ŏg�p����ꍇ�ȉ��̂悤�ɂ���
;;
;;      (append  '(("^[^\\.]+[\\.]asm$" . "*.asm"))
;;               tags-file-create-recursive-lang-alist)
;;

(defvar tags-file-create-recursive-lang-alist
  '(("^[^\\.]+[\\.][HhCc]$" . "*.[CcHh]")       ; C����v���W�F�N�g
    ("^[^\\.]+[\\.]cpp$" . "*.cpp")             ; C++�v���W�F�N�g
    ("^.+[\\.]el$" . "*.el"))                   ; elisp�v���W�F�N�g
  "TAGS�t�@�C�������쐬�p����ALIST (�\�[�X�t�@�C�������ʗp . find�p)")

(defun process-each-sub-directories (DIR PROC &optional DOT-PAIR)
  "�w�肵���f�B���N�g�� DIR �ȉ��ɑ΂��A�f�B���N�g�����ɂP��Â� PROC �����s��
��ėp�f�B���N�g�������֐��BPATTERN ��nil�̏ꍇ�͖������Ƀf�B���N�g�����ɂP��
�Â� PROC �����s����邪�Anil�ȊO�̏ꍇ�� PATTERN �� car �ɍ��v�����t�@�C����
�����̃f�B���N�g���Ɋ܂܂��ꍇ�̂ݎ��s�����B"
  (let ((files (directory-files DIR))
        (processed nil)                 ; nil: ���������s
        (dir (directory-file-name DIR))
        filename path type)
    (while files
      (setq filename (car files))
      (setq path (concat dir "/" filename))
      (if (and (file-directory-p path)
               (not (string-match "^[\.]+$" filename))) ; "." �� ".." �̓f�B���N�g���Ƃ��Ăł͂Ȃ��t�@�C���Ƃ��Ĉ���
          ; �f�B���N�g��
          (process-each-sub-directories path PROC DOT-PAIR) ; �ċA
        ; �t�@�C��
        (unless processed               ; PROC�����s�̏ꍇ
          (when (or (not DOT-PAIR)      ; �t�@�C�������w�肪�Ȃ� ��������
                    (and DOT-PAIR       ; �t�@�C�����w�肪������ ���� ���̃t�@�C���𔭌������ꍇ�̂�
                         (string-match (car DOT-PAIR) filename)))
            (funcall PROC dir (cdr DOT-PAIR))           ; �f�B���N�g�����̏��������s
            (setq processed t))))       ; t: �����s
      (setq files (cdr files)))))


(defun process-each-tags-file-create (dir pattern)
  "�f�B���N�g�����Ƃ�TAGS�t�@�C���쐬�֐�"
  (let* ((rel (directory-file-name (file-relative-name top-dir)))
         ; top-dir ��create-tags-file-recursive�ő������ꂽ���̂��Q��
         (cmd (concat "cd " (expand-file-name dir)
                      "; find " rel " -type f -name \"" pattern
                      "\" -print | xargs etags")))
         ; �T�u�f�B���N�g���Ɉ�U����āA�������� top-dir �ւ̏�������΃p�X
         ; ���� find ����
    (shell-command cmd "aaaa")))


(defun tags-file-create-recursive (top-dir)
  "�w��̃f�B���N�g���z���ɁA�ҏW���̃t�@�C���Ɏ�����TAGS�t�@�C�����ċA�I��
�쐬����"
  (interactive "Dtop dir: ")
  (let ((lang tags-file-create-recursive-lang-alist)
         (filename (file-name-nondirectory (buffer-file-name))))
    (while lang
      (when (string-match (caar lang) filename)
        ; �J�����g�o�b�t�@�̃t�@�C�������炩�̃\�[�X�t�@�C���Ɣ��ʂł���
        ; �ꍇ�̂�TAGS�t�@�C�����쐬����
        (message "creating TAGS files now...")
        (process-each-sub-directories top-dir
                                      'process-each-tags-file-create
                                      (car lang))
        (message "created TAGS files.")
        (setq lang ()))
      (setq lang (cdr lang)))))


;; for autoload
(provide 'tags-file-create-recursive)

;; tags-file-create-recursive.el ends here
