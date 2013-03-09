;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; [�Ȥ���]
;; 
;; M-x load-file RET ~/�ɤä�/tabbed-menu.el
;;
;; -*- Simple settings for .emacs -*-
;;
;; load-path ���̤äƤ����� tabbed-menu.el �Ȥ��ƥե�������֤���
;;
;; (require 'tabbed-menu)
;; (global-set-key [C-tab]   'tabbed-menu-next-buffer)
;; (global-set-key [C-S-tab] 'tabbed-menu-prev-buffer)
;; (global-set-key [f5]      'tabbed-menu-sort-tab)
;; (global-set-key [f6]      'tabbed-menu-change-sort-type)
;; (global-set-key [f7]      'tabbed-menu-shift-left)
;; (global-set-key [f8]      'tabbed-menu-shift-right)
;;
;; ��load-path ��ʬ����ʤ��ͤϡ�1���ܤ�
;;   (load-file "~/�ɤä�/tabbed-menu.el") ��
;;   (require 'tabbed-menu "~/�ɤä�/tabbed-menu.el")
;;   �ʤɤ�Ŭ���ɤ��ؤ��Ʋ�������
;;
;;                                          written by ruins (2003.2.24)
;;                                          e-mail: ruins0000@hotmail.com
;;                                  �ե������֤���:
;;                                  http://ruins-isweb.hp.infoseek.co.jp/
;; 

;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; [����ѹ���] 
;;
;; ver. 0.95 => ver. 0.99
;;  ������ɽ��/��ɽ���ʤɤ�ɽ������������ɲá�
;;  �����ְ�ư���˿������ְ����򻲾Ȥ����ͤˡ� (C-u 3 �� C-5 �ʤ�)
;;  �������Υ���ư��ؿ���Ƴ����
;;  �����饤�ɥ�˥塼�˥ޥ��ʡ���ǽ���ɲá�
;;  ����̯�ʥХ��ե��å�����
;;     (��� 21.x�Ǥ⶯���˥ե��󥯥����ܥ���ư����ͤ��ѹ���)
;;
;; ver. 0.99 => ver. 0.99.1
;;  ��provide����ʬ���򤱤Ƥ����Τ�����
;; ver. 0.99.1 => ver. 0.99.3
;;  ����ä��򤱤Ƥ�����̯�ʥߥ�������
;;    (��ü�ǹ��˱��ؤΥ��饤�ɥܥ��󤬽�³���Ƥ����ꤷ��)
;;  ���ǥե�����ͤ��������ѹ���
;;
;; ver. 0.99 => ver. 1.0a
;;  �����Τ���˥塼�������褵��ʤ���������¿�����ᡢrecenter��Ƥ��ͤˡ�
;;  �������ʽ�ľ����(;ʬ�ʵ�ǽ�κ����keymap�����Ǻ������ʤ�)
;;  �����֤��ɲð��ֻ���/�¤��ؤ���ǽ��Ƴ����
;;  ��window-configuration ������ǽ��Ƴ����
;;  ��next/prev�Ǥο������ְ������Ф�������ѹ���
;;
;; ver. 1.0a => ver. 1.0b
;;  ���ǡ�����¤���ѹ��������ȼ�������Ƚ񤭴�����
;;  ��force-{show/hide}�λ��ͤ��ѹ���
;;  �������ȼ��̤��ɲá�
;;  ���ʰץ��롼�׵�ǽ���ɲá�
;;  �������ֹ�ɽ����Ŭ�����ɲá�
;;

;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; [�������ޥ���]
;;
;; .emacs�Ǥ��Υե��������ɤ�����˥����Ȥ�
;; ��)�򻲹ͤˡ�������(setq .. )�ʤɤ���Ŭ���ͤ����ꤷ�Ʋ�������
;; 

(if (not (featurep 'tabbed-menu))
    (setq

     ;; ��������
     tabbed-menu-item-max     7 ;; ɽ���Хåե����֤κ����
     tabbed-menu-visible-min  2 ;; ξ¦�˺���¤���٤����֤ο�
     tabbed-menu-slide-step   6 ;; ���饤�ɥܥ���ΰ�ư��Υ (0�ǥ�˥塼��)
     tabbed-menu-string-max  10 ;; 1���֤κ���ʸ����
     tabbed-menu-fill-space   t ;; ����ˤ�륿��ʸ����·��


     ;; ���֤�ɽ������
     ;;  0:file 1:dir 2:+system 3:*system* 4:unknown (-1: *Minibuf-?*)
     tabbed-menu-display-type       2 ;; ���ְ͡ʲ��פΥХåե������פ�ɽ��
     tabbed-menu-show-window-buffer t ;; �Ļ�Хåե���ɬ������

     tabbed-menu-force-show nil ;; ����  ɽ�����֤ΰ���
     tabbed-menu-force-hide nil ;; ������ɽ�����֤ΰ���
     tabbed-menu-force-function ;; �嵭������Ŭ�Ѥ���ؿ��λ��� 
     '(lambda (buf x) (member (buffer-name buf) x))
     ;;
     ;; *scratch*�������ɽ�����Ƥ����������
     ;; ��1) tabbed-menu-force-show '("*scratch*")
     ;;
     ;; �ʲ����ͤˤ���С�ɽ��/��ɽ�����֤�����ɽ���ˤ�äƻ������ޤ���
     ;;
     ;; ��1) tabbed-menu-force-show "^ *\\*\\(ftp\\|[mM]ew\\)"
     ;;      tabbed-menu-force-hide "\\~$"
     ;;      tabbed-menu-force-function
     ;;      '(lambda (buf x) (string-match x (buffer-name buf)))
     ;;


     ;; ���֤��ɲ�/�ڤ��ؤ����ν��� (ver 1.0a)
     tabbed-menu-add-pos 'right ;; ���֤��ɲð��֤����
     ;; 
     ;; 'left/'right /'left-most /'right-most/nil (����ξ�˴���������)
     ;;
     ;; �������򤷤ޤ���'left/'right�ϺǸ�˥����ȥ��֤��ä�
     ;; �Хåե�����ˤ��ޤ���
     ;; (���줬¸�ߤ��ʤ����� -most ��Ʊ����Ǥ���)

     tabbed-menu-save-wincfg nil ;; ������ɥ�ʬ����֤��ݻ�
     ;;
     ;; t/'sync/nil
     ;; 
     ;; �������򤷤ޤ�������ˤ��tabbed-menu-{next/prev}-buffer�κݤˡ�
     ;; �ƥХåե��˴ؤ��륦����ɥ���ʬ����֤���������ޤ���
     ;; t��"��ư�����ݤΥ����ȥХåե�"�Τߡ�
     ;; 'sync �� ����ɽ������Ƥ������Ƥ�window-buffer�˴ؤ��Ƶ�Ͽ���ޤ���


     ;; �ʰץ��֥��롼�� (ver 1.0b)
     tabbed-menu-group-list nil
     tabbed-menu-group-function 'tabbed-menu-get-group-label
     ;;
     ;; �ʰץ��֥��롼�פ���ꤷ�ޤ���
     ;; tabbed-menu-group-list �ϥХåե���
     ;; {�ե�����̾/�ǥ��쥯�ȥ�̾/�Хåե�̾}
     ;; ��¸�ߤ����Τ����줫�˥ޥå���������ɽ����
     ;; �ꥹ�ȤȤ���Ϳ�����������ޤ���
     ;;
     ;; ��) tabbed-menu-group-list
     ;;    '("/$" "\\.\\(html\\|txt\\)$" "\\.[ch]\\(pp\\)?$")
     ;;
     ;; ������Ǥ� �ǥ��쥯�ȥ�(/�ǽ�����)��1�֡�.html��.txt��2�֡�
     ;; .cpp��.c .h�ʤɤ�3�֤ˤ��줾�쥰�롼�פȤ���ʬ�व��ޤ���
     ;;
     ;; �ޤ������Ǵؿ������ꤹ���硢�����ȥХåե����Ф���
     ;; ��դ���ޤ륰�롼��ID���֤���Τ����ꤷ�Ʋ�������
     ;;

     tabbed-menu-direct-access t
     ;;
     ;; ���롼�׻��ѻ����������ְ������Ѥ��Ƴƥ��롼�פ˥����פ��ޤ���
     ;; tabbed-menu-group-function ���֤�����(����)��
     ;; �����פ���ݤ˻��ꤹ�륰�롼���ֹ�Ȥʤ�ޤ���
     ;;
     ;; tabbed-menu-get-group-label �Ǥϡ��ꥹ�Ȥ�
     ;; �ޤޤ�ʤ����롼�פ��ֹ��0�ˤʤ�ޤ���
     ;;


     ;; ��ĥ�ܥ���ʤ�
     tabbed-menu-org-menu nil
     ;;
     ;; ʸ����/t/nil
     ;;
     ;; �������򤷤ޤ�������Υ�˥塼��ɽ�����뤿���ʸ�������ꤷ�ޤ���
     ;; �������Ѥ��ʤ�����nil�Ǥ���
     ;; 
     ;; ��1) tabbed-menu-org-menu "+" ;; �Ǻ�ü��ɽ��
     ;; ��2) tabbed-menu-org-menu  t  ;; �����ȥ��֤�ɽ��

     tabbed-menu-tab-function-limit 0
     tabbed-menu-tab-function-alist
     '(
       (" o " . tabbed-menu-switch-tab)
       ("<=>" . tabbed-menu-move-tab)
       (" x " . kill-buffer)
       (" % " . (lambda(x)(save-excursion (set-buffer x) (toggle-read-only))))
       )
     ;;
     ;; ���֤򲡤�������ư��ؿ������ꤷ�ޤ���
     ;; limit��0���ȥܥ����ɽ������ޤ���
     ;; 1�ʾ�����ꤹ����ǡ�alist��(1����)limit�������ǤޤǤ�
     ;; ��󤹤�ؿ��ڤ��ؤ��ܥ��󤬺Ǻ�ü��ɽ������ޤ���
     ;; 
     ;; alist��(��٥�ʸ���� . �Хåե�1�Ĥ�����˼��ؿ�)��Ϣ�ۥꥹ�ȤǤ���
     ;; (tabbed-menu-move-tab �����ϥ��ְ�ư��ɬ�פʤ��ᡢ�������̤Ǥ����ɡ�)
     ;;
     ;; ��1) tabbed-menu-tab-function-limit 2 ;; �����å����¤��ؤ��Τ߻���
     ;; ��2) tabbed-menu-tab-function-limit 7 ;; alist���Ĺ���ͤǤ������
     ;;      tabbed-menu-tab-function-alist   ;; ��ư��ؿ�������
     ;;      '(
     ;;        ("   " . tabbed-menu-switch-tab)
     ;;        (" x " . kill-buffer)
     ;;        (" F " . �����δؿ�)
     ;;                          :
     ;;                          :
     ;;        )
     ;;

     ;;���ޤ�
     tabbed-menu-tab-stop-at-end t
     ;;
     ;; ����ξü�ۤ����������¡� (C-u 3 �� C-5 �ʤɤλ�)
     ;;
     ;; Tips: �������ְ������Ѥ���tabbed-menu-{next/prev}-buffer ��ư����ȡ�
     ;;       next�Ϻ�ü��prev�ϱ�ü��1�Ȥ��Ƥ����ֹ�Υ���(���ξ���3����)
     ;;       ��ľ�ܰ�ư���ޤ������λ������ͤ�nil����ξü�ǥ��֤��ֹ椬
     ;;       �ݤ��줺��mod�Ƿ׻�����ޤ���

     tabbed-menu-display-number nil
     ;;
     ;; ���֤θ��߰��֤�ɽ�����ޤ���(ver 1.0b)
     ;; �� ���ߥܥ���Ȥ��Ƥε�ǽ��̵����
     ;;    ������٥뤬ɽ�����������Ǥ���
     ;;
     )
  )

;;
;; ���֤��¤��ؤ�������������ѥ졼���ǹԤ���������
;; �ʲ��δؿ���������Ʋ������� a,b: �Хåե�
;; (defun tabbed-menu-my-comparator (a b)
;;  )
;;
;; �ޤ�
;; (tabbed-menu-change-sort-type 'custom)
;; ����������������ѥ졼���򤹤��˻��ѽ���ޤ���
;; 
;; ɸ��Ǥ�
;; 'dic: �����(���̤Υ�����) 'time:�������� 
;; 'ext: ��ĥ�ҽ�             'size:�ե����륵������
;; ���Ѱդ���Ƥ��ޤ�����������ȥ����פ�'dic�Ǥ���
;;
;;
;; ��) �ǥ��쥯�ȥ���˳�ĥ�ҽ�ǥ�����
;;
;; (defun tabbed-menu-my-comparator (a b)
;;   (let ((f1 (file-name-directory
;; 	     (or (buffer-file-name a)
;; 		 (save-excursion (set-buffer a) list-buffers-directory) "")))
;; 	(f2 (file-name-directory
;; 	     (or (buffer-file-name b)
;; 		 (save-excursion (set-buffer b) list-buffers-directory) ""))))
;;     (if f1 (if f2 (if (not (equal f1 f2)) (string-lessp f1 f2)
;; 		    (tabbed-menu-compare-buffer-by-ext a b)))
;;       (if f2 t (string-lessp (buffer-name a) (buffer-name b)))))
;;   )

;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; [���]  ���Υե������ Version �� 1.0b �Ǥ���
;;
;; �� <<���ΤΥХ�>>
;;    ��˥塼��Ϣ�Ǥ��Ƥ���Ȼ����ܤ��롣���ޤ�ˤ���Ǥ���
;;    �������˥塼�����޻Ĥꡢ�ʹ�������(Mew/Draft�⡼�ɤǳ�ǧ)
;;    ���饤�ɥܥ���ʤɤ����˵�ǽ���ʤ��餷����(�Ǳ�ü�Ǥκ����饤��?)
;;    ¾��̤��ǧ�Τ�¿����
;; 
;;    �� �㤷���Х����ȥ��ְ�ư������ʤ��ʤä����˥塼���������줺��
;;       �����Ȥ��ʤ��ʤäƤ��ޤ���ǽ��������ޤ���¾�κ�Ȥˤ�
;;       �礷�ƻپ㤬̵��Ȧ�Ǥ��Τǡ��ǥե���Ȥ�switch-to-buffer
;;       �ʤɤ���Ѥ��Ʋ�������
;;       ���Ƚ����������������Х����٤������Τǡ��⤷��������
;;       e-mail��Ǽ��ĤʤɤǾ������Τ餻�Ʋ�����Ƚ�����ޤ���
;;
;; �� <<��˥塼�λ��;� Ƴ���Բ�ǽ�Ȼפ��뵡ǽ>> 
;;    ����å��ܥ����Ƚ��/���֥륯��å�����ư���ѹ���
;;    �����ե���Ȱʳ��Ǥδ����ʥ�����·����
;;    
;;    �� menu-bar �ϥ��٥�Ȥ�������Ƥ� (menu-bar) ����ͭ��ޤ���ġ�
;;       ï�����褽�����ä��鶵���Ʋ�������
;;
;; �� <<����>>
;;    �ޥ����ǥ��֤����򤷤����Ǥ�ξü�ˡֶ����פ����Ȥ��Ƥ��ޤ���
;;    �Ǥ���������Ϻǽ����äȰ��´��򴶤��뤫�⤷��ޤ���
;;    ���ȡ�����tabbed-menu�ϴ����ˡ֥�˥塼�С��β�¤�פǤ��Τǡ�
;;    �ե���Ȥ俧���ѹ���ˡ�ϳ�OS�ǤΥ�˥塼�С����ѹ��λ����˰�¸���ޤ���
;;
;;    Meadow(Windows)�Ǥ������᤮��ȥ�˥塼�С��ϼ�ưŪ��
;;    ¿�ʤˤʤ뤿�ᡢ���֤κ������ɬ�ܹ��ܤǤ�ͭ��ޤ��󤬡�
;;    ���̤�Emacs(UNIX)���ȱ�ü��ɽ������ʤ��ʤäƤ��ޤ��Ȼפ��ޤ���
;;    ���ä�Meadow�Ǥϥ��֤κ������Ŭ�����礭���ͤǤ�����פǤ���
;;

;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; [Program Part]
;; 

(require 'menu-bar)
(menu-bar-mode t)

(defvar tabbed-menu-tab-order     nil)
(defvar tabbed-menu-start-tab      -1)
(defvar tabbed-menu-current-tab    -1)
(defvar tabbed-menu-before-buffer nil)

(defvar tabbed-menu-global-menu nil)
(defvar tabbed-menu-local-menu  nil)

(defvar tabbed-menu-sort-type '(tabbed-menu-compare-buffer-by-dic . nil))
(defvar tabbed-menu-tab-order-alist    nil)
(defvar tabbed-menu-tab-function-current 0)

(defvar tabbed-menu-tab-type  nil)
(defvar tabbed-menu-tab-group nil)
(defvar tabbed-menu-wincfg    nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun tabbed-menu-compare-buffer-by-dic (a b)
  (string-lessp (buffer-name a) (buffer-name b))
  )

(defun tabbed-menu-compare-buffer-by-ext (a b)
  (let ((sub1 (tabbed-menu-get-file-ext (buffer-name a)))
	(sub2 (tabbed-menu-get-file-ext (buffer-name b))))
    (if (equal sub1 sub2) (string-lessp (buffer-name a) (buffer-name b))
      (string-lessp sub1 sub2))
    )
  )

(defun tabbed-menu-compare-buffer-by-time (a b)
  (let ((f1 (or (buffer-file-name a)
		(save-excursion (set-buffer a) list-buffers-directory)))
	(f2 (or (buffer-file-name b)
		(save-excursion (set-buffer b) list-buffers-directory))))
    (if f1 (if f2 (file-newer-than-file-p f2 f1) nil)
      (if f2 t (string-lessp (buffer-name a) (buffer-name b)))))
  )

(defun tabbed-menu-compare-buffer-by-size (a b)
  (let ((size1 (save-excursion (set-buffer a) (buffer-size)))
	(size2 (save-excursion (set-buffer b) (buffer-size))))
    (if (buffer-file-name a) (if (buffer-file-name b) (< size1 size2) nil)
      (if (buffer-file-name b) t (< size1 size2)))
    )
)

(fset 'tabbed-menu-compare-buffer
      (symbol-function 'tabbed-menu-compare-buffer-by-dic))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun tabbed-menu-buffer-read-only-p (buf)
  (save-excursion (set-buffer buf) buffer-read-only)
  )

(defun tabbed-menu-get-file-ext (str)
  (let ((ext (string-match "[^\\.]*$" str)))
    (if (> 2 ext) ""
      (setq str (substring str ext))
      (if (setq ext (string-match "<[0-9]+>$" str))
	  (substring str 0 ext) str)))
  )

(defun tabbed-menu-buffer-type ()
  (cond
   ((buffer-file-name)     0)  ;; file
   (list-buffers-directory 1)  ;; dir
   (t (let* ((name (buffer-name)) (head (string-to-char name)))
	(cond                  ;; *minibuf
	 ((and (< 9(length name))(equal(substring name 0 10) " *Minibuf-")) -1)
	 ((eq head ?+) 2)      ;; +system
	 ((eq head ?*) 3)      ;; *system
;;	 ((eq head ? ) 3)      ;;  system
	 (t            4)      ;; else
	 ))
      ))
  )

(defun tabbed-menu-buffer-name (buf)
  (let ((name (buffer-name buf)) len (suffix "")
	(type (save-excursion (set-buffer buf) tabbed-menu-tab-type)))
    (cond
     ((eq type -1) (setq suffix "*" name "*command"))
     ((eq type  0) (setq name (concat
			       (if (tabbed-menu-buffer-read-only-p buf) "%" "")
			       (if (buffer-modified-p buf) "+" "") name)))
     ((eq type 1) (setq suffix "/"))
     ((eq type 2) (setq suffix "/"))
     ((eq type 3) (setq suffix "*" name(substring name 0 (- (length name) 1))))
     (t (setq name (concat "?" name)))
     )

    (if (eq buf (current-buffer))
	(setq suffix (concat suffix "]") name (concat "[" name)))

    (setq len (- tabbed-menu-string-max (length suffix)))

    (cond
     ((< len (length name)) (concat (substring name 0 (- len 2)) ".." suffix))
     ((and tabbed-menu-fill-space (< 0 (setq len (- len (length name)))))
      (if (eq buf (current-buffer)) (concat name suffix (make-string len ? ))
	(concat " " name suffix (make-string (- len 1) ? ))))
     (t (concat name suffix))
     )
    )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun tabbed-menu-candidate-buffer-p (buf)
  (let ((type (save-excursion (set-buffer buf) tabbed-menu-tab-type)))
    (cond
     ;; group
     ((and
       (default-value 'tabbed-menu-tab-group)
       (not (eq tabbed-menu-tab-group
		(save-excursion (set-buffer buf) tabbed-menu-tab-group)))) nil)
     
     ;; force-show
     ((funcall tabbed-menu-force-function buf tabbed-menu-force-show) t)
     ;; force-hide
     ((funcall tabbed-menu-force-function buf tabbed-menu-force-hide) nil)

     ;; mini-buffer
     ((eq type -1) nil)
     ;; visible-buffer
     ((and tabbed-menu-show-window-buffer (get-buffer-window buf)) t)
     ;; unknown type
     ((and (<= 4 type) (eq buf (current-buffer))) t)
     ;; easy type limitation
     ((<= type tabbed-menu-display-type) t)
     ;;else
     (t nil)
     ))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun tabbed-menu-adjust-pos (pos)
  (if (not tabbed-menu-tab-stop-at-end)
      (mod pos (length tabbed-menu-tab-order))
    (if (> 0 pos) 0
      (if (< pos (length tabbed-menu-tab-order)) pos
	(- (length tabbed-menu-tab-order) 1)
	)))
  )

;; so dirty
(defun tabbed-menu-next-buffer (num) (interactive "P")
  (if (eq num '-) (tabbed-menu-toggle-group-mode)
  (if (not (integerp num))
      (if (setq num (memq (current-buffer) tabbed-menu-tab-order))
	  (setq num (- (length  tabbed-menu-tab-order) (length num) 1))
	(let ((rest (memq tabbed-menu-before-buffer tabbed-menu-tab-order)))
	  (if (not rest) (setq num 0)
	    (setq num (- (length tabbed-menu-tab-order) (length rest) 1)))))
    (if (and tabbed-menu-direct-access (default-value 'tabbed-menu-tab-group))
	(setq num (tabbed-menu-select-group num))
   (setq num (tabbed-menu-adjust-pos(- (length tabbed-menu-tab-order) num))))))
  (if (integerp num) (tabbed-menu-set-buffer num))
  )

;; so dirty
(defun tabbed-menu-prev-buffer (num) (interactive "P")
  (if (eq num '-) (tabbed-menu-toggle-group-mode)
  (if (not (integerp num))
      (if (setq num (memq (current-buffer) tabbed-menu-tab-order))
	  (setq num (+ (- (length  tabbed-menu-tab-order) (length num)) 1))
	(let ((rest (memq tabbed-menu-before-buffer tabbed-menu-tab-order)))
	  (if (not rest) (setq num (- (length tabbed-menu-tab-order) 1))
	    (setq num (+ (length tabbed-menu-tab-order) (length rest) 1)))))
    (if (and tabbed-menu-direct-access (default-value 'tabbed-menu-tab-group))
	(setq num (tabbed-menu-select-group num))
      (setq num (tabbed-menu-adjust-pos (- num 1))))))
  (if (integerp num) (tabbed-menu-set-buffer num))
  )

(defun tabbed-menu-switch-tab (buf)
  (if (setq buf (memq buf tabbed-menu-tab-order))
      (tabbed-menu-set-buffer (- (length tabbed-menu-tab-order) (length buf))))
  )

(defun tabbed-menu-select-group (num)
  (setq tabbed-menu-before-buffer (current-buffer))
  (tabbed-menu-save-order tabbed-menu-tab-group)

  (let ((grp (assq num tabbed-menu-tab-order-alist)) tmp)
    (if (not grp) (message "Group %d is empty now." num)
      (setq tmp grp grp (cdr grp))
      (setcar grp (delq nil (mapcar '(lambda(x) (if (buffer-live-p x) x nil))
				    (car grp))))
      (if (not (car grp))
	  (and (message "Group %d is already unloaded." num)
	       (setq tabbed-menu-tab-order-alist
		     (delq tmp tabbed-menu-tab-order-alist)))
	(if (setq tabbed-menu-tab-order (car grp)
		  tabbed-menu-before-buffer
		  (if (buffer-live-p (cdr grp)) (cdr grp) nil)
		  grp (memq (cdr grp) (car grp)))
	    (- (length tabbed-menu-tab-order) (length grp))
	  (- (length tabbed-menu-tab-order) 1))
	)
      ))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun tabbed-menu-shift-left (num) (interactive "P")
  (if (integerp num)
      (tabbed-menu-shift-tab (- 0 num) (length tabbed-menu-tab-order))
    (if (eq (length (memq (current-buffer) tabbed-menu-tab-order)) 1)
	(setq num (- 1 (length tabbed-menu-tab-order))) (setq num 1))
    (tabbed-menu-shift-tab num))
  )

(defun tabbed-menu-shift-right (num) (interactive "P")
  (if (integerp num)
      (tabbed-menu-shift-tab num -1)
    (if (eq (current-buffer) (car-safe tabbed-menu-tab-order))
	(setq num (- 1 (length tabbed-menu-tab-order))) (setq num 1))
    (tabbed-menu-shift-tab (- 0 num)))
  )

(defun tabbed-menu-shift-tab (num &optional org)
  (let ((buf (memq (current-buffer) tabbed-menu-tab-order)))
    (if (not buf) t
      (setq num (tabbed-menu-adjust-pos
		 (+ (if (integerp org) org 
		      (- (length tabbed-menu-tab-order) (length buf))) num))
	    buf (current-buffer))

      (setq tabbed-menu-tab-order (delq buf tabbed-menu-tab-order))
      (if (eq num 0)
	  (setq tabbed-menu-tab-order (cons buf tabbed-menu-tab-order))
	(setq buf (cons buf (nthcdr num tabbed-menu-tab-order)))
	(setcdr (nthcdr (- num 1) tabbed-menu-tab-order) buf)))
    )
  (force-mode-line-update) ;; update-menu
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun tabbed-menu-sort-tab () (interactive)
  (setq tabbed-menu-tab-order nil)
  (if (default-value 'tabbed-menu-tab-group)
      (setq tabbed-menu-tab-order-alist
	    (delq (assq tabbed-menu-tab-group tabbed-menu-tab-order-alist)
		  tabbed-menu-tab-order-alist)))

  (if (eq last-command 'tabbed-menu-sort-tab)
      (let ((func (car tabbed-menu-sort-type)))
	(setcdr tabbed-menu-sort-type (not (cdr tabbed-menu-sort-type)))
	(if (not (cdr tabbed-menu-sort-type))
	    (fset 'tabbed-menu-compare-buffer (symbol-function func))
	  (fset 'tabbed-menu-compare-buffer `(lambda(x y) (not (,func x y))))))
    )
  (force-mode-line-update) ;; update-menu
  )

(defun tabbed-menu-change-sort-type (&optional type &optional rev)(interactive)
  (let ((funcs '(tabbed-menu-compare-buffer-by-dic
		 tabbed-menu-compare-buffer-by-ext
		 tabbed-menu-compare-buffer-by-time
		 tabbed-menu-compare-buffer-by-size
		 tabbed-menu-my-comparator))
	func (types '(dic ext time size custom)) (num 5))

    (if (integerp rev) (if (> 0 rev) (setcdr tabbed-menu-sort-type t)
			 (if (> rev 0) (setcdr tabbed-menu-sort-type nil)))
      (if type (setcdr tabbed-menu-sort-type nil)
	  (if (not (cdr tabbed-menu-sort-type))(setcdr tabbed-menu-sort-type t)
	(setcdr tabbed-menu-sort-type nil) (setq num 6))))
	
    (setcar tabbed-menu-sort-type
	    (nth (if type (- 5 (length (memq type types)))
		   (- num (length (memq (car tabbed-menu-sort-type) funcs))))
		 funcs))
    (if (not (functionp (car tabbed-menu-sort-type)))
	(setcar tabbed-menu-sort-type 'tabbed-menu-compare-buffer-by-dic))

    (setq func (car tabbed-menu-sort-type))
    (if (not (cdr tabbed-menu-sort-type))
	(fset 'tabbed-menu-compare-buffer (symbol-function func))
      (fset 'tabbed-menu-compare-buffer  `(lambda(x y) (not (,func x y)))))
    (message "Tab sort: %S%s"
	     (nth (- 5(length(memq (car tabbed-menu-sort-type) funcs))) types)
	      (if (cdr tabbed-menu-sort-type) " (reverse)" ""))
    )
  )

(defun tabbed-menu-rotate-function (num)
  (if (not (integerp num)) (setq num 1))
  (setq tabbed-menu-tab-function-current
	(mod (+ tabbed-menu-tab-function-current num) 
	     (min (length tabbed-menu-tab-function-alist)
		  tabbed-menu-tab-function-limit)))
  (force-mode-line-update) ;; update-menu
  )

(defun tabbed-menu-tab-function () (interactive)
  (if (stringp last-command-event)
      (let* ((buf (get-buffer last-command-event)) func)
	(if (not (bufferp buf)) (message "Tabbed-Menu: unknown error.")
	  (setq func (cdr-safe (nth tabbed-menu-tab-function-current
				    tabbed-menu-tab-function-alist)))
	  (if (eq func 'tabbed-menu-move-tab)
	      (setq func 'tabbed-menu-switch-tab))
	  (if func (funcall func buf))))
    ) (force-mode-line-update) ;; update-menu
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun tabbed-menu-get-group-label ()
  (let ((i 1) grp (list tabbed-menu-group-list)
	(name (or (buffer-file-name) list-buffers-directory (buffer-name))))
    (while (and list (setq grp (car-safe list)) (not (string-match grp name)))
      (setq i (+ i 1) list (cdr-safe list)))
    (if (not list) 0 i))
  )

(defun tabbed-menu-save-order (label)
  (let ((cur (assq label tabbed-menu-tab-order-alist)))
    (if cur (setcdr cur (cons tabbed-menu-tab-order tabbed-menu-before-buffer))
      (setq tabbed-menu-tab-order-alist
	    (cons (cons label
			(cons tabbed-menu-tab-order tabbed-menu-before-buffer))
		  tabbed-menu-tab-order-alist)))
    )
  )

(defun tabbed-menu-restore-order (label)
  (setq label (cdr-safe (assq label tabbed-menu-tab-order-alist)))
  (if label (or (setq tabbed-menu-tab-order     (car-safe label)
		      tabbed-menu-before-buffer (cdr-safe label)) t))
  )

(defun tabbed-menu-group-order ()
  (if (buffer-live-p tabbed-menu-before-buffer)
      (save-excursion (set-buffer tabbed-menu-before-buffer)
		      (tabbed-menu-save-order tabbed-menu-tab-group)))
  (tabbed-menu-restore-order tabbed-menu-tab-group)
  )

(defun tabbed-menu-toggle-group-mode () (interactive)
  (if (setq-default tabbed-menu-tab-group
		    (not (default-value 'tabbed-menu-tab-group)))
      (let ((list (nreverse tabbed-menu-tab-order)) grp)
	(setq tabbed-menu-tab-order-alist nil)
	(save-excursion
	  (while list
	    (if (not (buffer-live-p (car list))) nil
	      (set-buffer (car list))
	      (if (setq grp (assq tabbed-menu-tab-group
				  tabbed-menu-tab-order-alist))
		  (setcdr grp (cons (car list) (cdr grp)))
		(setq tabbed-menu-tab-order-alist
		      (cons (cons tabbed-menu-tab-group (list (car list)))
			    tabbed-menu-tab-order-alist))
		)) (setq list (cdr list))))
	(setq tabbed-menu-tab-order nil
	      tabbed-menu-tab-order-alist
	      (mapcar '(lambda(x) (cons (car x)	(cons (cdr x) nil)))
		      tabbed-menu-tab-order-alist))
	)

    (setq tabbed-menu-tab-order
	  (apply 'append (mapcar '(lambda(x) (car (cdr x)))
				 (sort tabbed-menu-tab-order-alist
         '(lambda(a b) (> (if (integerp (car a)) (car a) -1)
			  (if (integerp (car b)) (car b) -1))))))
	  tabbed-menu-tab-order-alist nil)
    (let ((list tabbed-menu-tab-order))
      (while list
	(setcdr list (delq (car list) (cdr list))) (setq list (cdr list))))
    (if (setq tabbed-menu-current-tab
	      (memq (current-buffer) tabbed-menu-tab-order))
	(setq tabbed-menu-current-tab (- (length tabbed-menu-tab-order)
					 (length tabbed-menu-current-tab)))
      (setq tabbed-menu-current-tab -1))
    )
  (force-mode-line-update) ;; update-menu
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun tabbed-menu-save-win (&optional w)
  (save-excursion (set-buffer (window-buffer w))
		  (setq tabbed-menu-wincfg
			(current-window-configuration)))
  )

(defun tabbed-menu-set-buffer (pos)
  (if tabbed-menu-save-wincfg
      (if (not (eq tabbed-menu-save-wincfg 'sync))
	  (tabbed-menu-save-win) (walk-windows 'tabbed-menu-save-win)))

  (if (and (integerp pos) (< 0 (length tabbed-menu-tab-order)))
      (let (buf win)
 	(setq pos (mod pos (length tabbed-menu-tab-order))
	      buf (nth pos tabbed-menu-tab-order))
 	(if (not tabbed-menu-save-wincfg) (switch-to-buffer buf)

	  (setq win (save-excursion (set-buffer buf) tabbed-menu-wincfg))
 	  (if (not (window-configuration-p win)) ;; not-initialized
	      (progn (delete-other-windows) (switch-to-buffer buf))
	    (set-window-configuration win) (setq win nil)

	    ;; really correct?
	    (if (not (eq tabbed-menu-save-wincfg 'sync)) (switch-to-buffer buf)
	      (walk-windows '(lambda(x) 
			       (if (eq buf (window-buffer x)) (setq win x))))
	      (if (window-live-p win) (select-window win)
		(delete-other-windows) (switch-to-buffer buf)))
	    ))
	))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; [memo]
;;
;; '(14 13 12 11 10 9 8 7 6 5 4 3 2 1 0) tab
;;                      c         v
;;                + + - - - - - + +
;;
;; item 9 v-min 2 cur 4<->8
;;

;; not optimized.
(defun tabbed-menu-adjust-start ()
  (setq tabbed-menu-visible-min (min (/ (- tabbed-menu-item-max 1) 2)
				     tabbed-menu-visible-min))
  (if (<= 0 tabbed-menu-current-tab)
      (let ((next tabbed-menu-start-tab)
	    (min tabbed-menu-visible-min)
	    (max tabbed-menu-item-max)
	    (pos tabbed-menu-current-tab)
	    (len (- (length tabbed-menu-tab-order) 1))
	    (begin tabbed-menu-start-tab) end)
	(setq end (- (+ begin max) min 1))
	(setq begin (+ begin min))
	(if (< pos begin)
	    (setq next (- pos min))
	  (if (> pos end)
	      (setq next (- pos (- max min 1)))))
	(if (> (- (+ next max) 1) len)
	    (setq next (+ (- len max) 1)))
	(setq tabbed-menu-start-tab next)
	))
  (if (> 0 tabbed-menu-start-tab)
      (setq tabbed-menu-start-tab 0))
  )

;; not optimized.
(defun tabbed-menu-slide-start (num)
  (if (not (eq 0 num))
      (let ((next tabbed-menu-current-tab)
	    (min tabbed-menu-visible-min)
	    (max tabbed-menu-item-max)
	    (pos tabbed-menu-current-tab)
	    (len (- (length tabbed-menu-tab-order) 1))
	    (begin (+ tabbed-menu-start-tab num)) end)
	(if (< begin 0) (setq begin 0)
	  (if (< (- len (- max 1)) begin) (setq begin (- len (- max 1)))))
	(setq tabbed-menu-start-tab begin)
	
	(setq end (- (+ begin max) min 1) begin (+ begin min))
	
	(if (and (> pos end))
	    (tabbed-menu-set-buffer end)
	  (if (and (< pos begin))
	      (tabbed-menu-set-buffer begin)))
	))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun tabbed-menu-mrg-menu ()
  (let ((map (cdr (assq (current-local-map) tabbed-menu-local-menu))))
;; work so bad.
;;    (local-set-key [menu-bar tabbed-menu]
;;		   (cons (tabbed-menu-buffer-name (current-buffer)) map))
    (if (keymapp map)
 	(define-key-after tabbed-menu-global-menu [local-menu]
 	  (cons "Local-Menu" map) t)
      (define-key tabbed-menu-global-menu [local-menu] nil))
    )
  tabbed-menu-global-menu
  )

(defun tabbed-menu-make-list (menu list max)
  (let ((i 0))
    (while (and (< i max) list)
      (setq menu (cons
		  (if (and (eq (car list)(current-buffer)) tabbed-menu-org-menu
			   (not (stringp tabbed-menu-org-menu)))
		      (nconc (list 'menu (tabbed-menu-buffer-name (car list)))
			     (tabbed-menu-mrg-menu))
		    (nconc (list (buffer-name (car list))
				 (tabbed-menu-buffer-name (car list)) '(nil))
			   'tabbed-menu-tab-function)) menu))
      (setq i (+ i 1) list (cdr list)))
    menu)
  )

(defmacro tabbed-menu-move-tab (key label num)
  `(nconc (list ,key ,label)
	  '(lambda () (interactive)
	     (let ((tabbed-menu-tab-stop-at-end t)) ;; needless
	       (tabbed-menu-shift-tab ,num))
	     (force-mode-line-update))) ;; update-menu
  )

(defmacro tabbed-menu-slide-tab (key label num)
  `(nconc (list ,key ,label) '(lambda () (interactive)
				(tabbed-menu-slide-start ,num)
				(force-mode-line-update))) ;; update-menu
  )

(defmacro tabbed-menu-slide-menu (key label tab-list num)
  `(nconc (list ,key ,label) (cons 'keymap
				   (tabbed-menu-make-list nil ,tab-list ,num)))
  )

(defun tabbed-menu-number-label ()
  (if (and tabbed-menu-direct-access
	   (default-value 'tabbed-menu-tab-group)
	   (integerp tabbed-menu-tab-group))
      (format "G:%d" tabbed-menu-tab-group)
    (format "%d/%d"(if (>= tabbed-menu-current-tab 0)
		       (- (length tabbed-menu-tab-order)
			  tabbed-menu-current-tab) 0)
	    (length tabbed-menu-tab-order)))
  )

(defun tabbed-menu-add-tab ()
  (tabbed-menu-adjust-start)

  (let ((tab-list tabbed-menu-tab-order) menu
	(func (cdr-safe (nth tabbed-menu-tab-function-current
			     tabbed-menu-tab-function-alist))))
    ;; move-right
    (if (eq func 'tabbed-menu-move-tab)
	(if (< 0 tabbed-menu-current-tab)
	    (setq menu (cons (tabbed-menu-move-tab 'next ">" -1) menu)))
      ;; slide-right
      (if (< 0 tabbed-menu-start-tab)
	  (if (< 0 tabbed-menu-slide-step)
	      (setq menu (cons
			  (tabbed-menu-slide-tab
			   'next ">" (- 0 tabbed-menu-slide-step)) menu))
	    (setq menu (cons
			(tabbed-menu-slide-menu
			 'next ">" tab-list tabbed-menu-start-tab) menu))))
      )
    ;; buffer-tab
    (setq tab-list (nthcdr tabbed-menu-start-tab tabbed-menu-tab-order)
	  menu (tabbed-menu-make-list menu tab-list tabbed-menu-item-max)
	  tab-list (nthcdr tabbed-menu-item-max tab-list))

    ;; move-left
    (if (eq func 'tabbed-menu-move-tab)
 	(if (or (> 0 tabbed-menu-current-tab)
		(eq tabbed-menu-current-tab
		    (- (length tabbed-menu-tab-order) 1)))
 	    (if tabbed-menu-fill-space
 		(setq menu (cons (tabbed-menu-slide-tab 'prev " " 0) menu)))
 	  (setq menu (cons (tabbed-menu-move-tab 'prev "<" 1) menu)))
      ;; slide-left
      (if tab-list
	  (if (< 0 tabbed-menu-slide-step)
	      (setq menu (cons (tabbed-menu-slide-tab
				'prev "<" tabbed-menu-slide-step) menu))
	    (setq menu (cons (tabbed-menu-slide-menu
			      'prev "<" tab-list  
			     (- (length tabbed-menu-tab-order) 1)) menu)))
	(if tabbed-menu-fill-space
	    (setq menu (cons (tabbed-menu-slide-tab 'prev " " 0) menu))))
      )

    ;; number
    (if tabbed-menu-display-number
	(setq menu (cons `(number ,(tabbed-menu-number-label)
				  lambda () (interactive)) menu)))

    ;; function-button
    (if (< 0 tabbed-menu-tab-function-limit)
	(setq menu
	      (cons
	       (nconc
		(list 'function-button
		      (car-safe (nth tabbed-menu-tab-function-current
				     tabbed-menu-tab-function-alist)))
		'(lambda () (interactive) (tabbed-menu-rotate-function 1)))
	       menu)))

    ;; org-menu
    (if (stringp tabbed-menu-org-menu)
	(setq menu (cons (nconc (list 'menu tabbed-menu-org-menu)
				(tabbed-menu-mrg-menu)) menu)))

    (global-set-key [menu-bar] (cons 'keymap menu))
    )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun tabbed-menu-update-tab-list ()
  (mapcar #'(lambda(x)
	     (save-excursion
	       (set-buffer x)
	       (if (not (local-variable-p 'tabbed-menu-tab-type))
		   (setq tabbed-menu-tab-type (tabbed-menu-buffer-type)))
	       (if (and (default-value 'tabbed-menu-tab-group)
			(not (local-variable-p 'tabbed-menu-tab-group)))
		   (setq tabbed-menu-tab-group
			 (funcall tabbed-menu-group-function)))
	       )) (buffer-list))
	     
  (if (<= 0 tabbed-menu-current-tab)
      (setq tabbed-menu-before-buffer (nth tabbed-menu-current-tab
					  tabbed-menu-tab-order)))
  (if (not tabbed-menu-add-pos) (setq tabbed-menu-tab-order nil)
    (if (default-value 'tabbed-menu-tab-group) (tabbed-menu-group-order)))
  (let ((org
	 (delq nil(mapcar #'(lambda(x)
			      (if(and(buffer-live-p x)
				     (tabbed-menu-candidate-buffer-p x))x nil))
			   tabbed-menu-tab-order)))
	cur new (pos tabbed-menu-add-pos))
    
    (setq new(delq nil (mapcar #'(lambda(x)
				   (if (and (not (memq x org))
					    (tabbed-menu-candidate-buffer-p x))
				       x nil)) (buffer-list)))
	  new (nreverse (sort new 'tabbed-menu-compare-buffer)))

    (setq cur (or (memq (current-buffer) org)
		   (memq tabbed-menu-before-buffer org)))
    (cond
     ((eq pos  'left-most) (setq org  (nconc org new)))
     ((eq pos 'right-most) (setq org  (nconc new org)))
     ((eq pos 'left)
      (if (not cur)        (setq org  (nconc org new))
	(setq new (nconc new (cdr cur))) (setcdr cur new))
      )
     (t
      (if (not cur)        (setq org (nconc new org))
	(setq new (nconc new cur))
	(if (eq cur org) (setq org new)
	  (setcdr (nthcdr (- (length org) (length cur) 1) org) new))))
     )
    (setq cur (memq (current-buffer) org))
    (if cur (setq cur (- (length org) (length cur))) (setq cur -1))

    (setq tabbed-menu-tab-order   org
	  tabbed-menu-current-tab cur)
    )
  )

(defun tabbed-menu-update-first ()
  (global-set-key [menu-bar] nil)
  (global-set-key [menu-bar] (cons " " tabbed-menu-global-menu))

  (tabbed-menu-update-tab-list)

  (if (and (not (assq (current-local-map) tabbed-menu-local-menu))
	   (keymapp (current-local-map)))
      (let ((map (local-key-binding [menu-bar])))
	(if map
	    (setq tabbed-menu-local-menu
		  (cons (cons (current-local-map) map) tabbed-menu-local-menu))
	  ))
    )
  )

(defun tabbed-menu-update-last ()
  (global-set-key [menu-bar] nil)
  (local-set-key  [menu-bar] nil)
  (tabbed-menu-add-tab)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun tabbed-menu-init ()
  (if (string-lessp emacs-version "20") nil
    (setq tabbed-menu-global-menu (global-key-binding [menu-bar]))
    (make-variable-buffer-local 'tabbed-menu-tab-type)
    (make-variable-buffer-local 'tabbed-menu-tab-group)
    (make-variable-buffer-local 'tabbed-menu-wincfg)
    
    (add-hook 'menu-bar-update-hook 'tabbed-menu-update-first)
    (add-hook 'menu-bar-update-hook 'tabbed-menu-update-last t)
    )
  )

(defun tabbed-menu-quit ()
  (if (keymapp tabbed-menu-global-menu)
      (progn
 	(define-key tabbed-menu-global-menu [local-menu] nil)
 	(global-set-key [menu-bar] tabbed-menu-global-menu)
 	(mapcar '(lambda (x) (if (keymapp (car x))
				 (define-key (car x) [menu-bar] (cdr x))))
		tabbed-menu-local-menu))
    )
  (setq tabbed-menu-global-menu nil tabbed-menu-local-menu  nil)
  (remove-hook 'menu-bar-update-hook 'tabbed-menu-update-first)
  (remove-hook 'menu-bar-update-hook 'tabbed-menu-update-last)
  )

(defun tabbed-menu-mode (flag) (interactive "P")
  (if (and (integerp flag) (<= flag 0)) (tabbed-menu-quit)
    (if (not tabbed-menu-global-menu)  (tabbed-menu-init)
      (tabbed-menu-quit) (if flag (tabbed-menu-init))))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(if (not (featurep 'tabbed-menu))
    (tabbed-menu-mode t)
  )

(provide 'tabbed-menu)

;; Local Variables:
;; mode: Emacs-Lisp
;; comment-start: ";;"
;; End:
