;//Änder die Nummer

;//Exportiere ein Bild 

; (define (script-fu-create-Thumbnail image layer folder color x y numberList font-size font-name)
	; (gimp-context-set-foreground color)
	; (gimp-text-fontname image -1 x y "#02" 0  TRUE font-size PIXELS font-name)
	; ;(car(gimp-image-merge-visible-layers image 0))
	; ;(gimp-image-flatten 0)
	; (file-png-save-defaults 1 1 (car(gimp-image-flatten 1))  (string-append folder "\T02.png") (string-append folder)) 
	; ;(gimp-drawable-fill layer WHITE-FILL)
	; ; (gimp-image-undo-group-start image)
	; ; (gimp-threshold layer threshold 255)
	; ; (plug-in-gauss RUN-NONINTERACTIVE image layer 3 3 1)
	; ; (gimp-levels layer HISTOGRAM-VALUE 95 160 1.0 0 255)
	; ; (gimp-image-undo-group-end image)
	; (gimp-displays-flush)	
; )

(define (script-fu-create-Thumbnail image layer praefix folder color start end font-size font-name)
	;(gimp-image-undo-group-start image)
	(gimp-context-set-foreground color)
	(gimp-text-layer-set-font-size layer font-size 0)
	(gimp-text-layer-set-font layer font-name)
	(gimp-text-layer-set-color layer color)
	
	;(gimp-text--fontname image -1 x y "#02" 0  TRUE font-size PIXELS font-name)
	;(car(gimp-image-merge-visible-layers image 0))
	;(gimp-image-flatten 0)
	;(file-png-save-defaults 1 1 (car(gimp-image-flatten 1))  (string-append folder "\T02.png") (string-append folder)) 
	;(gimp-drawable-fill layer WHITE-FILL)
	; (gimp-image-undo-group-start image)
	; (gimp-threshold layer threshold 255)
	; (plug-in-gauss RUN-NONINTERACTIVE image layer 3 3 1)
	; (gimp-levels layer HISTOGRAM-VALUE 95 160 1.0 0 255)
	; (gimp-image-undo-group-end image)
	(createThumbnail image layer praefix folder end start)
	
	;(gimp-image-undo-group-end image)
	;(gimp-displays-flush)	
)

(define (createThumbnail image layer praefix folder end currentNumber)
	;(gimp-image-undo-group-start image)
	(if (> currentNumber end)
		(
		(gimp-message "finish")
		)
		((gimp-text-layer-set-text layer (string-append praefix  (number->string currentNumber)))
		(let* (
			 (new-image (car (gimp-image-duplicate image)))
			 (the-new-layer (car (gimp-image-merge-visible-layers new-image CLIP-TO-IMAGE)))
			)
		;(define newimage (gimp-image-duplicate 1))
		;(define theNewLayer (gimp-image-merge-visible-layers newimage, CLIP_TO_IMAGE))
		(file-png-save-defaults 1 new-image the-new-layer (string-append (string-append (string-append folder "/T0") (number->string currentNumber)) ".png") (string-append (string-append (string-append folder "/T0") (number->string currentNumber)) ".png"))
		(gimp-image-delete new-image)
		)
		(createThumbnail image layer praefix folder end (+ currentNumber 1))
		
		;(createThumbnail image layer folder end (+ currentNumber 1))
		;(gimp-image-undo-group-end image))
		)
	)
	
)


; (define (script-fu-splatter-brush size)
	; (let* 
	; (
		; (image  (car (gimp-image-new size size GRAY)))
		; (layer (car (gimp-layer-new image size size GRAY-IMAGE "brush" 100 NORMAL-MODE)))
	; )
	; (gimp-image-insert-layer image layer 0 0)
	; (gimp-drawable-fill layer WHITE-FILL)
	; (gimp-displays-new image)
	; )
; )
  

(script-fu-register
	"script-fu-create-Thumbnail"
	"<Image>/Image/create-Thumbnail"
	"Creates Thumbnails with Numbers"
	"Blackeye"
	"Blackeye"
	"October 2017"
	"RGB*, GRAY*"
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Layer" 0
	SF-STRING "Praefix:" "#"
	SF-DIRNAME "Exportfolder" "%USER%"
	SF-COLOR "Font Color" "white"
	;SF-ADJUSTMENT "X" '(12 0 1000 10 100 0 0)
	;SF-ADJUSTMENT "Y" '(560 0 1000 10 100 0 0)
	SF-ADJUSTMENT "Number Start" '(01 0 500 1 10 0 0)
	SF-ADJUSTMENT "Number End" '(10 0 500 1 10 0 0)
	SF-ADJUSTMENT "Font-Size" '(100 1 1000 1 10 0 0)
	SF-FONT "Font" "Harrington"
)

; (script-fu-register
	; "script-fu-splatter-brush"
	; "<Image>/File/Create/splatter brush"
	; "Generates a random splatter brush"
	; "Blackeye"
	; "Blackeye"
	; "October 2017"
	; ""
	; SF-ADJUSTMENT "Brush Size (px)" '(400 100 1000 1 10 0 0)
; )