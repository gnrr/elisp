;; Filename: my-backup.el
;; Last modified: Thu Jul 27 2006 11:22:03 JST
;; Author: gnrr
;;
;; description:
;;      �J�����g�o�b�t�@�̃o�b�N�A�b�v�t�@�C�����쐬����
;;      �f�t�H���g�t�@�C������ *.bakXX (XX��00����n�܂�T�t�B�b�N�X�ԍ�)
;;      ���łɓ����t�@�C�������݂���ꍇ�� *.bak01, *.bak02....�ƂȂ�
;;
;;
;; requirements:
;;      (none)
;;
;;
;; usage:
;;      �o�b�N�A�b�v�t�@�C���쐬
;;      M-x bak           �f�t�H���g�g���q���g�p
;;      C-u M-x bak       �I���W�i���g���q���g�p
;;      C-u C-u M-x bak   �g�p����g���q�������˂�
;;
;;      �o�b�N�A�b�v�t�@�C���̈ꗗ��dired�ŉ{��
;;      M-x bak-list
;;
;;
;; install:
;;      add into your dot.emacs.
;;
;;      (require 'my-backup)
;;
;;
;; customize: (in your ".emacs")
;;
;;      ;; �f�t�H���g�̊g���q(�O�u�h�b�g�s�v)
;;      ;; �J�X�^�}�C�Y���Ȃ��ꍇ��"bak"
;;      (setq my-backup-default-ext "backup")
;;
;;      ;; �I���W�i���̊g���q(�O�u�h�b�g�s�v)
;;      ;; �J�X�^�}�C�Y���Ȃ��ꍇ��"orig"
;;      (setq my-backup-original-ext "original")
;;
;;      ;; �o�b�N�A�b�v�t�@�C���쐬��̃f�B���N�g��
;;      ;; nil�̏ꍇ�͕ҏW���̃t�@�C���Ɠ����ꏊ�Ƃ݂Ȃ��B
;;      ;; �J�X�^�}�C�Y���Ȃ��ꍇ�� nil
;;      (setq my-backup-directory "~/backup_files")
;;
;;

(defvar my-backup-default-ext "bak"
  "�f�t�H���g�̊g���q�B�O�u�h�b�g�͕s�v�B")

(defvar my-backup-original-ext "orig"
  "�I���W�i���̊g���q�B�O�u�h�b�g�͕s�v�B")

(defvar my-backup-directory nil
  "�o�b�N�A�b�v�t�@�C���쐬��̃f�B���N�g���B
nil�̏ꍇ�͕ҏW���̃t�@�C���Ɠ����ꏊ�Ƃ݂Ȃ��B")

(defun my-backup-get-suffixed-file-name (src)
  " ��̫�Ă̊g���q�̓K���Ȼ̨������ް��T���A���̃t�@�C������Ԃ��B"
  (let ((ext (concat "." my-backup-default-ext))
	(n 0)
	(nyet t)
	name)
    (while nyet
      (setq name (concat src ext (format "%02d" n)))
      (if (file-exists-p name)
	  ; ���ɓ���̧�ق�����Ύ��̨̻������ް��������
	  (setq n (1+ n))
	; ̧�ق��Ȃ���΂��̨̻������ް���̗p��̧�ٖ������肷��
	(setq nyet nil)))
    name))

(defun my-backup-read-ext-from-minibuffer (body)
  (let ((ext (read-no-blanks-input "extension: "
				  my-backup-original-ext)))
    (unless (string-match "^[.].*" ext)
      (setq ext (concat "." ext)))
  (concat body ext)))

(defun my-backup (arg)
  "���ݕҏW���̃t�@�C���̃o�b�N�A�b�v�R�s�[���쐬����B

�ҏW���̃o�b�t�@���ύX����Ă��邩�ǂ����Ɋւ�炸�A�ŏI�ۑ����̃t�@�C�����R
�s�[���ăo�b�N�A�b�v�t�@�C���Ƃ���B

         M-x bak   �f�t�H���g�g���q(\"bak\"��)���g�p
     C-u M-x bak   �I���W�i���̊g���q(\"orig\"��)���g�p
 C-u C-u M-x bak   �g�p����g���q�������˂�

�f�t�H���g�g���q�̏ꍇ��
  foo.bak01, foo.bak02, foo.bak03....
�Ǝ����I�ɃT�t�B�b�N�X�ԍ����C���N�������g�����B

�I���W�i���̊g���q���w�莞�A���������t�@�C��������ꍇ�͕ۑ����Ȃ��B

�J�X�^�}�C�Y��
;; �f�t�H���g�̊g���q�B\(�O�u�h�b�g�s�v\)
;; �J�X�^�}�C�Y���Ȃ��ꍇ��\"bak\"
\(setq my-backup-default-ext \"backup\"\)

;; �I���W�i���̊g���q�B\(�O�u�h�b�g�s�v\)
;; �J�X�^�}�C�Y���Ȃ��ꍇ��\"orig\"
\(setq my-backup-original-ext \"original\"\)

;; �o�b�N�A�b�v�t�@�C���쐬��̃f�B���N�g���B
;; nil�̏ꍇ�͕ҏW���̃t�@�C���Ɠ����ꏊ�Ƃ݂Ȃ��B
;; �J�X�^�}�C�Y���Ȃ��ꍇ�� nil
\(setq my-backup-directory \"~/backup_files\"\)"
  (interactive "P")
  (let ((ext ".")
	(bak-filename nil)
	(dir nil)
	(filename-body nil))
    ; �ޯ̧��̧�ٖ������邩����
    (if (buffer-file-name)
	(setq filename-body (file-name-nondirectory (buffer-file-name)))
      (message "this buffer has no file."))
    ; ̧�ٖ�������ꍇ�̂ݎ��̏�����
    (when filename-body
      (if my-backup-directory
	  ; ��̫�Ă��ޯ����ߐ悪�w�肳��Ă���ꍇ
	  (let ((d (expand-file-name
		    (file-name-as-directory my-backup-directory))))
	    (if (and (file-directory-p d)
		     (file-writable-p (make-temp-name
				       (concat d "my-backup"))))
		; �ޯ����ߐ悪�������݉\�̏ꍇ
		(setq dir d)
	      ; �ޯ����ߐ悪�������ݕs�̏ꍇ
	      (message (format "Cannot backup to \"%s\"." d))))
	; ��̫�Ă��ޯ����ߐ悪�w�肳��ĂȂ��ꍇ�͕ҏW����̧�قƓ����ꏊ�Ƃ���
	(setq dir (file-name-directory (buffer-file-name)))))
    ; �ޯ����ߐ���ިڸ�؂��m�肵���ꍇ�̂ݎ��̏�����
    (when dir
      (setq bak-filename
	    (cond
	     ((not arg)			;�O�u�����Ȃ��̏ꍇ
	      (my-backup-get-suffixed-file-name (concat dir filename-body)))
	     ((= (car arg) 4)		;�O�u����=1�R�̏ꍇ
	      (concat dir filename-body ext my-backup-original-ext))
	     ((= (car arg) 16)		;�O�u����=2�R�̏ꍇ
	      (my-backup-read-ext-from-minibuffer (concat dir filename-body)))))
      ; �ēx����̧�ق��Ȃ����Ƃ��m�F
      (if (file-exists-p bak-filename)
	  ; ����̧�ق�����ꍇ�ʹװ
	  (message (format "\"%s\" already exists." bak-filename))
	; ����̧�ق��Ȃ��ꍇ�̂��ޯ�����̧�ق��쐬
	; �ޯ�����̧�ق͕ҏW����̧�ق̍ŏI�ۑ���Ԃ̒P�Ȃ��߰�ł���A
	; �����ޯ̧�������o���Ă���킯�ł͂Ȃ��B
	(copy-file (expand-file-name (buffer-file-name)) bak-filename)
	(message (format "backup --> \"%s\""
                     (if my-backup-directory
                          (let ((directory-abbrev-alist `((,(concat "\\`" (getenv "HOME")) . "~"))))
                            (abbreviate-file-name bak-filename))
                       (concat "./" (file-name-nondirectory bak-filename)))))))))


(defun my-backup-dired-list ()
  "���ݕҏW���̃o�b�N�A�b�v�t�@�C���̃��X�g��dired�ŕ\������B"
  (interactive)
  (let ((orig nil)
	(dir nil)
	(wild nil))
    (if (buffer-file-name)
	(setq orig (expand-file-name (buffer-file-name)))
      (message "this buffer has no file."))
    (when orig
      (if my-backup-directory
 	  ; ��̫�Ă��ޯ����ߐ悪�w�肳��Ă���ꍇ
	  (let ((d (file-name-as-directory my-backup-directory)))
	    (if (file-directory-p d)
		(setq dir d)
	      (message "invalid backup directory \"%s\"." d)))
	; ��̫�Ă��ޯ����ߐ悪�w�肳��ĂȂ��ꍇ�͕ҏW����̧�قƓ����ꏊ�Ƃ���
	(setq dir (file-name-directory (buffer-file-name)))))
    (when dir
	(setq wild (concat (file-name-nondirectory orig) "*"))
	(dired (concat dir wild)))))


(defalias 'bak 'my-backup)
(defalias 'bak-list 'my-backup-dired-list)

;; for autoload
(provide 'my-backup)

;; my-backup.el ends here
