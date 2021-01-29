(define (script-fu-smooth-threshold image layer threshold)
	(gimp-image-undo-group-start image)
	(gimp-threshold layer threshold 255)
	(plug-in-gauss RUN-NONINTERACTIVE image layer 3 3 1)
	(gimp-levels layer HISTOGRAM-VALUE 95 160 1.0 0 255)
	(gimp-image-undo-group-end image)
	(gimp-displays-flush)
	
)

(define (script-fu-splatter-brush size)
	(let* 
	(
		(image  (car (gimp-image-new size size GRAY)))
		(layer (car (gimp-layer-new image size size GRAY-IMAGE "brush" 100 NORMAL-MODE)))
	)
	(gimp-image-insert-layer image layer 0 0)
	(gimp-drawable-fill layer WHITE-FILL)
	(gimp-displays-new image)
	)
)
  

(script-fu-register
	"script-fu-smooth-threshold"
	"<Image>/Colors/Smooth Threshold"
	"Threshold with smooth edges"
	"Blackeye"
	"Blackeye"
	"October 2017"
	"RGB*, GRAY*"
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Layer" 0
	SF-ADJUSTMENT "Threshold" '(127 0 255 1 10 0 0)
)

(script-fu-register
	"script-fu-splatter-brush"
	"<Image>/File/Create/splatter brush"
	"Generates a random splatter brush"
	"Blackeye"
	"Blackeye"
	"October 2017"
	""
	SF-ADJUSTMENT "Brush Size (px)" '(400 100 1000 1 10 0 0)
)