;; init.el -*- lexical-binding: t; -*-
;; makes emacs loadtime faster by reducing the garbage collector 
(setq gc-cons-threshold (* 50 1000 1000))

;; package repository
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; LOAD CUSTOM FILE
(load-file "~/.emacs.d/.authinfo")
;;; --- UI --- ;;;
(menu-bar-mode -1) ;; Oculta la barra del menú
(scroll-bar-mode -1) ;; Oculta la barra de desplazamiento
(tool-bar-mode -1) ;; Oculta la barra de herramientas

;; cambia de yes or no a y or n
(defalias 'yes-or-no-p 'y-or-n-p)

(delete-selection-mode 1) ;; Borra la región seleccionada
(global-display-line-numbers-mode 1) ;; muestra el numero de linea
;;(global-hl-line-mode 1) ;; destacar linea actual 

;; Cambiar la fuente 
(add-to-list 'default-frame-alist
	     '(font . "JetBrains Mono-11"))

;; tells emacs to not make backups and not to autosave stuff
(setq auto-save-default nil)
(setq make-backup-file nil)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (emacs-lisp . t)))
;; disable line numbers for some modes
(dolist (mode '(org-mode-hook ;; org document
		term-mode-hook ;; terminal
		vterm-mode-hook ;; another terminal
		shell-mode-hook ;; shell
		eshell-mode-hook ;; another shell
		treemacs-mode-hook ;; filetree
		completion-list-mode-hook ;; auto completion buffer
		org-agenda-mode-hook ;; agenda viewer
		tetris-mode-hook ;; tetris
		elfeed-search-mode-hook ;;elfeed
		elfeed-show-mode-hook ;;elfeed
		eww-mode-hook ;; eww 
		doc-view-mode-hook
		elpher-mode-hook)) 
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
;;AUCTEX
(use-package auctex
  :ensure pdf-tools
  :config
  (setq TeX-view-program-selection '(((output-dvi has-no-display-manager)
				   "dvi2tty")
				  ((output-dvi style-pstricks)
				   "dvips and gv")
				  (output-dvi "xdvi")
				  (output-pdf "PDF Tools")
				  (output-html "xdg-open"))))
;;EWW
(use-package eww
  :config
  (setq ;;browse-url-browser-function 'eww-browse-url ;; eww navegador default
      shr-use-colors nil ;; no color
      shr-bullet "• " ;; 
      shr-folding-mode t ;;
      eww-search-prefix "https://lite.duckduckgo.com/html?q="
      url-privacy-level '(email agent cookies lastloc)))
;;ELPHER
(use-package elpher
  :ensure t
  :pin melpa-stable)
;;GEMINI
(use-package gemini-mode
  :ensure t)
;; ELFEED settings
(use-package elfeed
  :ensure t
  :config
  (keymap-global-set "C-x w" 'elfeed)
  (setq elfeed-feeds (quote
		      (("https://news.nononsenseapps.com/index.atom")
		       ("https://itsfoss.com/rss/" linux)
		       ("https://www.eff.org/rss/updates.xml" blog)
		       ("https://old.reddit.com/r/MMORPG/top/.rss?t=week" reddit)
		       ("https://old.reddit.com/r/LivestreamFail/top/.rss?t=week" reddit lives)
		       ("https://old.reddit.com/r/MouseReview/top.rss" reddit)
		       ("https://old.reddit.com/r/privacy/top.rss" reddit)
		       ("https://old.reddit.com/r/chile/top.rss" reddit chile)
		       ("https://techcrunch.com/rss" blog)
		       ("https://arstechnica.com/gadgets/rss" blog)
		       ("https://elchapuzasinformatico.com/feed" blog)
		       ("https://spectrum.ieee.org/feeds/feed.rss" blog)
		       ("https://hackaday.com/blog/rss" blog)
		       ("https://www.theverge.com/rss/index.xml" blog)
		       ("https://www.wired.com/feed/category/security/latest/rss" blog)
		       ("https://www.wired.com/feed/tag/ai/latest/rss" blog)
		       ("https://www.df.cl/noticias/site/list/port/rss.xml" chile)
		     
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCcaTUtGzOiS4cqrgtcsHYWg" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UC2eYFnH61tmytImy1mTYvhA" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCXuqSBlHAE6Xw-yeJA0Tunw" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCEU9D6KIShdLeTRyH3IdSvw" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UC-UcKEWOSpz0AfY33TrYw3g" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCt44wdefZzrhNDYYAyEy3Xg" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCECJDeK0MNapZbpaOzxrUPA" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCyQqzYXQBUWgBTn4pw_fFSQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCKNq_4ub5GACIkQfuVWEBtg" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCQX_MZRCaluNKxkywkLEgfA" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCxQKHvKbmSzGMvUrVtJYnUA" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCOE04OX-W6NH3aenP2etYQA" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCeeFfhMcJa1kjtfZAGskOCA" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCMIqrmh2lMdzhlCPK5ahsAg" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCJ0-OtVpF0wOKEqT2Z1HEtA" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UC7FW6FYqPLeQIXMSulBfOLw" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UC-V8FVQCUpRRUPNClviki3w" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCuSDKzAWVtXIAt7rg8v9Q6w" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCaBLE6gLWBA1q2SKH9t4wqg" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCBgi-68fpmF6yIEDOqd4kPw" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCYgwtk-sU-W9h8MbGfESiPg" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCKJiiEQWWpTmM4tJAtopd4w" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCHdoOrwo__5kf2qXwdyVdww" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCV5G678sZwW5IcF3pCfRbHQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCGc7D1dcbCWHzh3SfDhSFhw" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCQZkWBdIi24VkVjgd5znSkQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCvrLvII5oxSWEMEkszrxXEA" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCaKIsOxGHRiHgLdkoy-jolA" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCqL9sqfRCcIlqwazHpr9Ohg" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCkSMDOtrKr43OGSSmKnx6tQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UC-7Fid0mztwtmf2Z7OgPRRQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCkHN7h7CFeYL6Y1N5JcEZug" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCyNtlmLB73-7gtlBz00XOQQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UC6mIxFTvXkWQVEHPsEdflzQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCYO_jab_esuFRV4b17AJtAw" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCqCXtp6TDLe_BorZRj722Mg" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCgeS8J9W62B-uLBgzp14BtQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCurv9zw0LturSVaqI6NgdrQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UC-_kZ3UZBsnCWJEVr8ysMww" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCwd5VFu4KoJNjkWJZMFJGHQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCWTiYFhbyq9_NK6HD4Ajo7A" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCA2mbBnNsT3_5uFW0lGa49g" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCK6KUE1U4UWM9mZNn9zDjJg" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCvG04Y09q0HExnIjdgaqcDQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCqGONXW1ORgz5Y4qK-0JdkQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCL_QvUUeriC6q610RCXDlSQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCZiL6BoryLWxyapUuVYW27g" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCQsGrKtlTUH7L-Z--Lszbtg" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UC8Dy320v_pjCpxbvvEXwFDQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCP7QY6L5pvmm0-stL-pNFrw" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCNHWpNqiM8yOQcHXtsluD7Q" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCMbQbVilo-nezMvwf1BZfAA" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCVw72OZW5oPtptwRugiGf3w" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCr97_mhDwscRciN6eWyXLow" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCa3DVlGH2_QhvwuWlPa6MDQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCq2jigrIGtupbTXiNjq6Wrw" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCbdSYaPD-lr1kW27UJuk8Pw" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCZPhunsQWLP5f_AEYNN_p5A" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCaoHSaIMfXjvTyrZAdg1j7g" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCJKFZ26gRK7AJXfmuxWR9Cg" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCZ4kCvGQpNOi8CvOahXnDFA" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCOCYnTfY7izcASanFVHL3Aw" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UC4ZtjUYf_RKzqZWVliTjoTA" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCBZiUUYeLfS5rIj4TQvgSvA" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCpJj6QQsXA4GQwRi2E5oZ4Q" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCN216-B_l5E_wke2cKcNSjg" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCQ15DMXpPuy_-f-ERY3IxUw" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCO8DQrSp5yEP937qNqTooOw" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UChY9Cgv-iyPDvf1Bkyx20OQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UC36xmz34q02JYaZYKrMwXng" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UC_vox7Q_ruWvLfSo3rd-iCQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UC7ZWBllAI9hFTGpCT6fYcYQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCMHXMAeKkI6HXlPfLiYvo9g" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCdXKM0KKoSSCXES9AKB_HKw" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UC62hT7P4rX-FyuM3RQuGgnQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UC0U1FCjcs-JYpjzWEh_4K4Q" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCpe6mr0ykFR-_A9PhfBq0DQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UC40Ztmc_11leuUR-tHh_irQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCGHd8uFq4qbZKjyYp36DuZA" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCauWzM4ElgQCuwymc3sV42g" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCntjizjCXuUno06eDdtSYfg" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCd4IkWsJxct7nDYSKrQoMyA" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UC6H4RND0w8ZUdH1H8IXpU6Q" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCqyPDXPuiX1r7Pl95KixD8Q" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCyxT2L5glnHKGkzs7fm2xEg" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UC5cVsohNhl8CS2gncqN5JzQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UC10VYNif0DyGCiPNRMKYVCQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCW-FqabogT_167Xnvtc5KUw" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCP4shyHDsJv-n_5T1QdcybA" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCFqU5os3zhAz-d9oV4SjHvQ" youtube)
		       ("https://www.youtube.com/feeds/videos.xml?channel_id=UCXazgXDIYyWH-yXLAkcrFxw" youtube)))))
;; DASHBOARD
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook) ;; iniciar dashboard
  (setq dashboard-startup-banner 'logo) ;; imagen inicial 
  (setq dashboard-banner-logo-title "Hola weones") ;; mensaje abajo de la imagen oficial
  (setq dashboard-items '((agenda . 3)
			  (recents . 3)
			  (bookmarks . 3)))
  (setq dashboard-item-names '(("Agenda for the coming week:" . "Agenda semanal:")
			       ("Recent Files:" . "Archivos recientes")
                               ("Bookmarks:" . "Marcadores")))
  (setq dashboard-startupify-list '(dashboard-insert-banner
                                  dashboard-insert-navigator
                                  dashboard-insert-newline
                                  dashboard-insert-init-info
                                  dashboard-insert-items
                                  dashboard-insert-newline
                                  dashboard-insert-footer))
  (setq dashboard-center-content t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t))

;; Makes the dashboard buffer the default for when you use the emacs daemon
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
;; GPTEL
(use-package gptel 
  :ensure t
  :config
  (setq gptel-model 'llama3-70b-8192
   gptel-backend (gptel-make-openai "Groq"               ;Any name you want
  :host "api.groq.com"
  :endpoint "/openai/v1/chat/completions"
  :stream nil
  :key (api-key "groq")  ;can be a function that returns the key
  :models '(llama-3.1-70b-versatile
            llama-3.1-8b-instant
            llama3-70b-8192
            llama3-8b-8192
            mixtral-8x7b-32768
            gemma-7b-it)))
  (gptel-make-openai "Perplexity"         ;Any name you want
  :host "api.perplexity.ai"
  :key (api-key "perplexity")                   ;can be a function that returns the key
  :endpoint "/chat/completions"
  :stream t
  :models '(;; has many more, check perplexity.ai
            pplx-7b-chat
            pplx-70b-chat
            pplx-7b-online
            pplx-70b-online
	    llama-3.1-sonar-large-128k-chat
	    llama-3.1-sonar-large-128k-online))
  (add-to-list 'gptel-directives '(english . "I'm an expert English language interpreter with experience in translation and interpretation. I'm here to help you better understand the English phrases you'd like to analyze. My function is to explain the meaning, grammar, and context of each phrase you provide in a clear and concise manner. You can give me any English phrase or text, and I'll be happy to help you uncover its deeper and more precise meaning") t)
  (setq gptel-default-mode 'org-mode))
;;org-bullets
(use-package org-bullets
  :ensure t)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-bullets-bullet-list '("♦" "◉" "◇" "✿"))
;; Cargar el tema
(load-theme 'doom-one t)

(setq org-image-actual-width nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("88f7ee5594021c60a4a6a1c275614103de8c1435d6d08cc58882f920e0cec65e" default))
 '(package-selected-packages
   '(gptel vterm which-key gemini-mode elpher pdf-tools dashboard elfeed doom-themes)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
