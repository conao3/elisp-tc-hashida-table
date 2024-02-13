;;; tc-hashida-table.el ---                          -*- lexical-binding: t; -*-

;; Copyright (C) 2024  Naoya Yamashita

;; Author: Naoya Yamashita <conao3@gmail.com>
;; Keywords: convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Insert hashida-table

;;; Code:

(defvar tc-hashida-table--keyboard "1234567890qwertyuiopasdfghjkl;zxcvbnm,./")

(defvar tc-hashida-table--d 5.0)
(defvar tc-hashida-table--D (* tc-hashida-table--d 2))
(defvar tc-hashida-table--r 1.0)
(defvar tc-hashida-table--R 4)

(defun tc-hashida-table--make-empty-svg (d)
  "Make svg image of hashida-table with D."
  (let* ((D (* d 2))
         (sequence-img (svg-create (* D 10) (* D 4))))
    (svg-rectangle sequence-img 0 0 (* D 10) (* D 4) :fill-color "white" :stroke-color "black")
    sequence-img))

(defun tc-hashida-table--make-svg (d seq)
  "Make svg image of hashida-table with D for SEQ."
  (let* ((D (* d 2))
         (keyboard tc-hashida-table--keyboard)
         (sequence-img (tc-hashida-table--make-empty-svg d)))
    (cl-flet ((x (e) (- (* D (+ e 1)) d))
              (y (e) (+ (* D e) d)))
      (dolist (i (number-sequence 0 3))
        (dolist (j (number-sequence 0 9))
          (unless (or (= i 0) (= j 4) (= j 5))
            (svg-circle sequence-img (x j) (y i) 1.2 :fill-color "black"))))
      (let ((key1 (list (/ (cl-position (elt seq 0) keyboard) 10) (% (cl-position (elt seq 0) keyboard) 10)))
            (key2 (list (/ (cl-position (elt seq 1) keyboard) 10) (% (cl-position (elt seq 1) keyboard) 10))))
        (svg-circle sequence-img (x (nth 1 key1)) (y (nth 0 key1)) 4 :fill-color "black")
        (svg-circle sequence-img (x (nth 1 key2)) (y (nth 0 key2)) 4 :fill-color "white" :stroke-color "black")))
    sequence-img))

(defun tc-hashida-table--insert-svgs (d seqs)
  "Insert svg images of hashida-table with D for SEQS."
  (dolist (seq seqs)
    (svg-insert-image (if (string= seq "")
                          (tc-hashida-table--make-empty-svg d)
                        (tc-hashida-table--make-svg d seq)))))

(defun tc-hashida-table-hiragana ()
  "Make hashida-table with hiragana."
  (interactive)
  (let ((d tc-hashida-table--d))
    (with-current-buffer (get-buffer-create "*hashida-table*")
      (display-buffer (current-buffer))
      (erase-buffer)
      (dolist (elm '(("あ" ("yf" "hd" "yd" "lt" "oa"))
                     ("か" ("je" "hr" "jt" "nf" "uf"))
                     ("さ" ("ug" "js" ",f" "uw" ";b"))
                     ("た" ("ks" "/a" ".d" "la" "ja"))
                     ("な" ("lg" "kg" "a." "fd" "kd"))
                     ("は" ("jg" "m." "rs" ";;" "pz"))
                     ("ま" ("md" "/g" "yh" "lc" "ia"))
                     ("や" ("ye" ""   "cc" ""   "jw"))
                     ("ら" ("ig" "jc" ";a" ";e" "ps"))
                     ("わ" ("ys" "s1" ""   "d1" ";g"))
                     ("ん" ("nd"))))
        (insert (car elm))
        (tc-hashida-table--insert-svgs d (cadr elm))
        (newline)))))

(provide 'tc-hashida-table)
;;; tc-hashida-table.el ends here

