function imgsz --description 'give dimensions of image' --argument file
	sips -g pixelWidth -g pixelHeight $file
end
