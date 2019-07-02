library('datasets')

group <- airquality$Month

x <- split(airquality,group)

x <- lapply(x, transform, Oz.scaled = scale(Ozone))

x <- unsplit(x, group)
