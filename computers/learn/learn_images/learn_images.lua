-- Display image on a monitor
-- The image file should be already in the folder
-- Images should be in the .nfp format. (rin.nfp and cat.nfp has been saved in this github for example)
-- Converter used for converting to .nfp format: https://github.com/DownrightNifty/computercraft-stuff (The colours are not 100% correct but the general image does show)
-- Credit to original images:
-- cat.nfp = https://art.pixilart.com/42e019c236fe77a.png
-- rin.nfp = https://wallpaperaccess.com/full/751993.jpg

-- Main
mon = peripheral.wrap("right")
image = paintutils.loadImage("cat.nfp")
term.redirect(mon)
paintutils.drawImage(image, 1, 1)