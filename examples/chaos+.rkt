#lang reader SRFI-105


#!r6rs


(library (chaos+)

  (export)

  (import
   
   ;; import base R6RS
   (except (rnrs base (6)) if) ; Scheme+ has it own 'if' compatible with Scheme's 'if'

   ;;(only (racket) print-mpair-curly-braces) ; list as Lisp and Scheme , no { }

   (only (rnrs control (6)) when)
   (only (rnrs io simple (6)) display newline)

   (Scheme+R6RS)

   ;; R6RS does not allow #:something keywords used with optional parameters of procedures
   ;; the package below allow other syntax , something: as replacement
   (Scheme+R6RS examples kw)

   (plot)

   (only (srfi :41) stream-iterate)

   (racket gui base)

   (colors)

   (rnrs r5rs (6))

   (racket class)

   (only (racket math) pi)
   (only (racket stream) stream-map stream->list stream-take)
   (only (racket match) match-let)

   (only (racket base) add1 format)

   (rename (only (racket base) for) (for for-racket))

   (compatibility mlist)
   
   )


  ;; ← or <- or := are equivalent to 'define' (or 'set!' if the variable already exist !)
  ;; (define i +1i)
  {i ← +1i} ;; imaginaire pur / i complex

  ;; (define xws 500)
  {xws ← 500} ;; X window size
  {yws ← 500} ;; Y window size

  ;; return the coordonates of the center of graph
  (define (center-coords)
    (values (quotient xws 2)
	    (quotient yws 2)))

  {(xo yo) ← (center-coords)} ; multiple values assignment (or definition !)

  {unit-axis-in-pixel ← 10} ;; will change dynamically for each graph

  {no-pen ← (new pen% [style 'transparent])}
  {no-brush ← (new brush% [style 'transparent])}
  {blue-brush ← (new brush% [color "blue"])}

  
  ;; draw a vector point
  (define (draw-vect-point dc z-vect point-brush)
    ;; size of the ellipse / point in pixels
    {ga ← 3} ; grand axe / big axis
    {pa ← 3} ; petit axe / little axis
    {x ← z-vect[0]}
    {y ← z-vect[1]}
    {z ← x + i * y} ; complex number
    {(x y) ← (to-screen-multi-values z)}
    {x ← x - (quotient ga 2)}
    {y ← y - (quotient pa 2)}
    (send dc set-pen no-pen)
    (send dc set-brush point-brush) ; blue-brush)
    (send dc draw-ellipse x y ga pa))


  ;; convert in screen coordinates
  (define (to-screen-multi-values z0) ; z0 is a complex number
    {re ← (real-part z0)}
    {im ← (imag-part z0)}
    {xs ← re * unit-axis-in-pixel}
    {ys ← im * unit-axis-in-pixel}
    (values (round {xo + xs})
	    (round {yo - ys})))


  (define (norm x y)
    {x ** 2 + y ** 2})

  ;; get maximum norm of list of points (compare also x and y)
  (define (max-list-norm-x-y ls)
    {max-norm-x-y <- (norm (car ls)[0] (car ls)[1])} ; 0 indexed is x,1 indexed is y
    (if (null? (cdr ls))
	max-norm-x-y
	(max max-norm-x-y (max-list-norm-x-y (cdr ls)))))



  
  (define (chaos p q d x0 y0)
    
    (define a {2 * cos{2 * pi * p / q}}) ; or {2 * (cos {2 * pi * p / q})} or {2 * cos({2 * pi * p / q})}
    (define ksx (sqrt {{2 + a} / 2})) ; or sqrt{{2 + a} / 2}
    {ksy := (sqrt {{2 - a} / 2})} ; or (define ksy (sqrt {{2 - a} / 2}))
    
    (stream-map (lambda (z)
                  (match-let (((vector x y) z))
                    (vector {{ksx / (sqrt 2)} * {x + y}}
			    {{ksy / (sqrt 2)} * {(- x) + y}})))
                (stream-iterate (lambda (z)
                                  (match-let (((vector x y) z))
                                    (vector
                                     {{a * x} + y + {d * x} / (add1 {x ** 2})} ; infix left to right evaluation avoid extra parenthesis but is hard for humans
                                     (- x))))
				(vector x0 y0))))




  
  (define *data* '((1  34 5 0.1 0 60000)
                 (1  26 5 0.1 0 90000)
                 (1  25 5 0.1 0 60000)
                 (1  13 5 0.1 0 60000)
                 (1  10 5 0.5 0 60000)
                 (1   8 5 0.1 0 60000)
                 (1   7 5 1   0 60000)
                 (2  13 5 1   0 60000)
                 (1   5 5 0.1 0 60000)
                 (3  14 5 0.1 0 60000)
                 (2   9 5 0.1 0 60000)
		 (3  13 5 0.1 0 60000)
                 (3  10 5 1   0 60000)
                 (8  25 5 0.1 0 60000)
                 (1   3 5 0.1 0 60000)
                 (6  17 5 0.5 0 60000)
                 (3   8 5 1   0 60000)
                 (5  13 5 0.1 0 60000)
                 (2   5 5 1   0 60000)
                 (7  17 5 0.1 0 60000)
                 (11 25 5 0.1 0 60000)
                 (6  13 5 1   0 90000)
                 (8  17 5 0.1 1 60000)))


  
  ;; compute the RGB color from hsv
  (define (compute-rgb-color-from-hsv point max-norm-x-y)

    ;; extract the coordonates
    {x <- point[0]}
    {y <- point[1]}

    ;; with various colormaps
    (define h (sqrt {(norm x y) / max-norm-x-y})) ; normalized scalar
    (when (= h 1.0) ;; strange? hue can not be 1.0 when converting to RGB after: it causes a strange error:
      ;; kw.rkt:1263:25: color-conversion: nonsense hue: 1, internal: 6
      ;;(display h)
      ;;(newline)
      (set! h 0.999))

    (hsv->color (hsv {1 - h} 1 1)))


  (declare rv cv) ; or (define rv '()) ;; declaring cv remove error : last statement is not an expression (but a definition)
  (define lgt-*data* (length *data*))
  (define frm (make-vector lgt-*data*))
  (define my-canvas% (make-vector lgt-*data*))
  (define index 0)


  (define graphic-mode #t)
  (define plot-mode #t)

  (define im*data* (mlist->list *data*))
  
  (for-racket ([datum im*data*]) ; 'for-racket' is the original 'for' of Racket but renamed

	      (display "index=") (display index) (newline)

	      {imdatum <- (mlist->list datum)}
	    
	      (match-let ((`(,p ,q ,d ,x ,y ,n) imdatum))
	      
		{imlst-points <- (stream->list
				  (stream-take
				   (chaos p q d x y) n))}

		{lst-points <- (list->mlist imlst-points)}
	      
		(define max-norm-x-y (max-list-norm-x-y lst-points)) ; maximum

		(when graphic-mode ; no memory overloading in this mode
		  ;; Make a frame by instantiating the frame% class
		  {frm[index] ← (new frame% [label (format "Chaos+ ~a" index)]
				     [width xws]
				     [height yws])}

		  (send {frm[index]} show #t)

		  ;; Derive a new canvas (a drawing window) class to handle events
		  {my-canvas%[index] ← (class canvas% ; The base class is canvas%
					      
					      ;; Define overriding method to handle mouse events
					      ;; (define/override (on-event event)
					      ;;   (send cv refresh))
					      
					      ;; Call the superclass init, passing on all init args
					      (super-new))}

		
		  {cv ← (new my-canvas%[index]

			   [parent frm[index]] ; variable cv could be used with mouse event (but currently not)
			   
			   [paint-callback
			    
			    (lambda (canvas dc) ;; dc: Drawing Context
			      ;; cf. https://docs.racket-lang.org/draw/overview.html#%28tech._drawing._context%29	
			      (send dc erase)
			      (send dc set-pen "black" 1 'solid)

			      ;; compute the units of graph
			      {unit-axis-in-pixel ← (min xws yws) / {2 * (sqrt max-norm-x-y)}}
			      
			      ;; display the points
			      (for-racket ([point imlst-points])
					  
					  ;; compute the RGB color
					  ;;(define rgb-color (compute-rgb-color point max-norm-x-y))
					  (define rgb-color (compute-rgb-color-from-hsv point max-norm-x-y))
					  
					  ;; create brush
					  (define point-brush (new brush% [color rgb-color]))
					  
					  (draw-vect-point dc point point-brush)))])})
		

		;; warning memory overload,  require almost 4Gb
		(when {plot-mode and index > 19}
		  
		  ;; multichrome plot
		  
		  (define-kwish kw-points points) ;; R6RS does not allow #:something keywords, this creates a new function
		  
		  (define plt
		    
		    (plot
		     (mlist->list ; in R6RS we must convert list from mutable to immutable ones to use with Racket library
		      (map (lambda (point)
			     
			     (kw-points ;(points
			      (mlist->list (list point))
			      ;;#:alpha 0.4
			      ;; R6RS does not allow #:something keywords
			      ;;#:sym 'fullcircle1
			      ;;#:color (compute-rgb-color-from-hsv point max-norm-x-y) ;; change the color of a point according to its co-ordinate
			      ;; we use as replacement 
			      sym: 'fullcircle1
			      color: (compute-rgb-color-from-hsv point max-norm-x-y) ;; change the color of a point according to its co-ordinate
			      ))
			   lst-points))))
		  
		  {rv <- (cons plt rv)})
		
		{index := index + 1} ; or you can use <- ,set!, etc ...
		
		) ;  end match-let
	      
	      ) ; enf for-racket

  (display (reverse rv)) ; reverse the return value list as it has been build with cons
  (newline) ; note that as R6RS has no REPL you must display the list to see the plots inside...
  
  ) ; end module chaos
