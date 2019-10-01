TakePhoto.m takes a photo using the webcam.
cornerDetection.m Takes as input a bitMask picture of the paper to be drawn on.Returns the Origin in terms of its location in the BitMask relative to
the center in mm, the rotation of the paper relative to the camera, and theheight and the width of the paper.
BinaryDuck.m convert the photo to a binary form, detects the duck location.
CreateBinary.m creates a binary form image.
PaperDetect.m convert the photo to a binary form, detects the paper location.
CornerDuck.m returns the center of the duck in terms of of center of the binary picture.
