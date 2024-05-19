;;; enhanced-reading-mode.el --- Emacs minor mode for an enhanced text readability
;;
;;
;; Copyright (C) 2024 Kevin Borling <kborling@protonmail.com>
;;
;; Author: Kevin Borling <kborling@protonmail.com>
;; Created: May 25, 2024
;; Version: 0.0.1
;; Keywords: enhanced-reading, reading, enhanced-reading-mode
;; License: MIT
;; URL: https://github.com/kborling/enhanced-reading-mode
;; Homepage: https://github.com/kborling/enhanced-reading-mode
;; Filename: enhanced-reading-mode.el
;; Package-Requires: ((emacs "24.1"))
;;
;; This file is NOT part of GNU Emacs.
;;
;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:
;;
;; The above copyright notice and this permission notice shall be included in all
;; copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.
;;
;;; Commentary:
;;
;; Enhanced Reading Mode is an Emacs minor mode that enhances readability by highlighting the initial characters of each word in a customizable way. This mode is inspired by techniques to improve reading speed and comprehension.
;;
;;; Code:

(defgroup enhanced-reading nil
  "Customization group for Enhanced Reading mode."
  :group 'convenience)

(defcustom enhanced-reading-highlight-length 3
  "Number of characters to highlight at the start of each word."
  :type 'integer
  :group 'enhanced-reading)

(defcustom enhanced-reading-font-weight 'bold
  "Font weight for highlighted text."
  :type '(choice (const :tag "Ultra Heavy" ultra-heavy)
                 (const :tag "Heavy (Black)" heavy)
                 (const :tag "Ultra Bold (Extra Bold)" ultra-bold)
                 (const :tag "Bold" bold)
                 (const :tag "Semi Bold (Demi Bold)" semi-bold)
                 (const :tag "Medium" medium))
  :group 'enhanced-reading)

(defun enhanced-reading--highlight-region (beg end)
  "Highlight the first few letters of each word in the region from BEG to END."
  (save-excursion
    (goto-char beg)
    (while (re-search-forward "\\b\\w+\\b" end t)
      (let* ((match (match-string 0))
             (len (length match))
             (highlight-len (max 1 (min enhanced-reading-highlight-length (/ len 2))))
             (start (match-beginning 0))
             (end (match-end 0)))
        (remove-overlays start end 'enhanced-reading t)
        (let ((overlay (make-overlay start (+ start highlight-len))))
          (overlay-put overlay 'face `(:weight ,enhanced-reading-font-weight))
          (overlay-put overlay 'enhanced-reading t))))))

(defun enhanced-reading--apply-to-buffer ()
  "Apply enhanced reading highlight to the entire buffer."
  (enhanced-reading--highlight-region (point-min) (point-max)))

(defun enhanced-reading--remove-overlays ()
  "Remove enhanced reading overlays from the buffer."
  (remove-overlays (point-min) (point-max) 'enhanced-reading t))

(define-minor-mode enhanced-reading-mode
  "Minor mode for enhanced reading."
  :lighter " Enhanced"
  (if enhanced-reading-mode
      (progn
        (enhanced-reading--apply-to-buffer)
        (add-hook 'after-change-functions 'enhanced-reading--highlight-after-change nil t))
    (progn
      (enhanced-reading--remove-overlays)
      (remove-hook 'after-change-functions 'enhanced-reading--highlight-after-change t))))

(defun enhanced-reading--highlight-after-change (beg end _len)
  "Highlight the region after a change from BEG to END."
  (enhanced-reading--highlight-region beg end))

(provide 'enhanced-reading-mode)
;;; enhanced-reading-mode.el ends here
