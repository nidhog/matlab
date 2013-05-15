The Prairie resonant scanning mode has been outputting broken images lately. This fixes them.

USAGE: prairiefix('brokendata','fixeddata')

brokendata is a directory containing only the broken images from a run.  

Note that this does not attempt to fix rotation or reflection errors. Those are trivial to fix using ImageJ (Image -> Transform -> Rotate or Flip).