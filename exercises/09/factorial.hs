factorial :: Integral t => t -> t
factorial 0 = 1
factorial n = n * factorial (n - 1)
