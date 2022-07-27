
(define (script-fu-group-all image layer group-name toggle-size)

	(gimp-image-undo-group-start image)
	(print "Toggler is")
	(print toggle-size)
	(print "Toggler ende")

	;; get all layers in the image
	;; create group
	;; add all to the group

	(let *(
	 		; create variables
	 		; add group
			(size (car (gimp-image-get-layers image))) 
			
			;vector
	 		(layers (car (cdr (gimp-image-get-layers image))))
		 	(new-group (car (gimp-layer-group-new image)))
	 	) 
		(gimp-image-insert-layer image new-group 0 -1)
		(gimp-layer-set-name new-group group-name)
		;(gimp-message "it worked")
		; for image range
		; insert into group
		(subGroupFunc image 0 layers new-group size toggle-size)

	)

	;(gimp-image-insert-layer image current_layer new-group end start)
	(gimp-image-undo-group-end image)
)

(define (moveLayer image c-layer group last-position)
	(print "Within SubFunction")
	(gimp-image-reorder-item image c-layer group last-position)
)

(define (scaleToImageSize c-layer toggle-size)
	(print "Scaling")
	(print toggle-size)
	(if (= toggle-size 1)
	(begin
		(print "Entering Scaling")
		(gimp-layer-resize-to-image-size c-layer)
	)
	(begin
		; nothing
		(print "No Scaling")
	)
	)
	(print "Scaling Aus")
)


(define (subGroupFunc image current-layer-count layers group size toggle-size)
	
	(if (>= current-layer-count size) 
		(begin 
			(gimp-message "finish")
		) 
		(begin 
			(print current-layer-count)
			(print "1")
			; else
			(print (vector-ref layers current-layer-count))
			( let *(
				; get next layer
				(c-layer (vector-ref layers current-layer-count))
				(last-position (car (gimp-item-get-children group)))
			)
				(print "2")
				(print (gimp-item-is-group c-layer))
				(define is_group (car (gimp-item-is-group c-layer)))
				(define is_visible (car (gimp-layer-get-visible c-layer)))
				(print "Grouping")
				(print is_group)
				(print is_visible)
				(print "Grouping Car")
				
				
				(if (begin
					(or (= is_group 1) (=  is_visible 0))
					)
					(begin
							(print "Skipping Group and or Visible Layer")
					)
					(begin
						(print "3")
						(scaleToImageSize c-layer toggle-size)
						(print "After Scaling")
						(moveLayer image c-layer group (- last-position 1))
						(print "4")
					)
				)
				(print "Checking this")
				(subGroupFunc image (+ current-layer-count 1) layers group size toggle-size)
			)
			(print "Leaving if")
		)
	)
	
)

; https://docs.gimp.org/en/gimp-using-script-fu-tutorial-first-script.html
(script-fu-register
	"script-fu-group-all"
	"<Image>/Image/Group All"
	"Groups all Layer into one Group - Caution: At the moment, layer groups will be ignored. Flatten your hierarchy before using this procedure is recommended."
	"Blackeye"
	"Blackeye"
	"July 2022"
	"RGB*, GRAY*"
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Layer" 0
	;SF-STRING "Praefix:" "#"
	;SF-ADJUSTMENT "Grouping Start" '(00 0 500 1 10 0 0)
	;SF-ADJUSTMENT "Grouping End" '(-1 -1 500 1 10 0 0)
	SF-STRING "Group Name" "group"
	SF-TOGGLE "Scale Layer to Image" TRUE
	;SF-ADJUSTMENT "Font-Size" '(100 1 1000 1 10 0 0)
	;SF-FONT "Font" "Harrington"
	;(script-fu-menu-register "script-fu-group-all" "<Image>/File/Create/Text")
)
