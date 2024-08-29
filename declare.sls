;; This file is part of Scheme+R6RS

;; Copyright 2021 Damien MATTEI

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;; /Applications/Racket\ v8.13/bin/plt-r6rs --install declare.scm 


#!r6rs

(library (declare)

  (export declare)

  (import (rnrs base (6)))

  ;; (declare ls dyn) ;; declare multiple variables

  (define-syntax declare
    (syntax-rules ()
      ((_ var1 ...) (begin
		      (define var1 '())
		      ...))))


  ) ; end library
