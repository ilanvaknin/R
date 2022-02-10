library(rvest)

download.file(url = "https://www.google.com/search?hl=fr&tbm=isch&source=hp&biw=1536&bih=722&ei=FbgiX-2QHeONlwSa-J6gAg&q=patisserie&oq=patisserie&gs_lcp=CgNpbWcQAzICCAAyAggAMgIIADICCAAyAggAMgIIADICCAAyAggAMgIIADICCABQkgpY_jBgjD9oA3AAeACAAcoBiAHqD5IBBjAuMTIuMZgBAKABAaoBC2d3cy13aXotaW1n&sclient=img&ved=0ahUKEwit75ar-PTqAhXjxoUKHRq8ByQQ4dUDCAc&uact=5", destfile = 'C://data//temp.html')



# download.file(url = "http://www.ahavatorah.com/resource/media/paracha/berechit", destfile = 'C://paracha//temp.html')
# tab <- read_html('C://paracha//temp.html') %>% html_nodes("table")
# tab <- tab[[1]] %>% html_table
# mp3 <- tab[grepl("\\.(?:mp3)$", tab$Name), 'Name']
# for (i in mp3){
#   download.file(url = paste("http://www.ahavatorah.com/resource/media/paracha/berechit/",i,sep=""), destfile = paste('C://paracha//berechit//',i,sep=""))
# }

# download.file(url = "http://www.ahavatorah.com/resource/media/paracha/chemot", destfile = 'C://paracha//temp.html')
# tab <- read_html('C://paracha//temp.html') %>% html_nodes("table")
# tab <- tab[[1]] %>% html_table
# mp3 <- tab[grepl("\\.(?:mp3)$", tab$Name), 'Name']
# for (i in mp3){
#   download.file(url = paste("http://www.ahavatorah.com/resource/media/paracha/chemot/",i,sep=""), destfile = paste('C://paracha//chemot//',i,sep=""))
# }
# 
# download.file(url = "http://www.ahavatorah.com/resource/media/paracha/vayikra", destfile = 'C://paracha//temp.html')
# tab <- read_html('C://paracha//temp.html') %>% html_nodes("table")
# tab <- tab[[1]] %>% html_table
# mp3 <- tab[grepl("\\.(?:mp3)$", tab$Name), 'Name']
# for (i in mp3){
#   download.file(url = paste("http://www.ahavatorah.com/resource/media/paracha/vayikra/",i,sep=""), destfile = paste('C://paracha//vayikra//',i,sep=""))
# }
# 
# download.file(url = "http://www.ahavatorah.com/resource/media/paracha/bamidbar", destfile = 'C://paracha//temp.html')
# tab <- read_html('C://paracha//temp.html') %>% html_nodes("table")
# tab <- tab[[1]] %>% html_table
# mp3 <- tab[grepl("\\.(?:mp3)$", tab$Name), 'Name']
# for (i in mp3){
#   download.file(url = paste("http://www.ahavatorah.com/resource/media/paracha/bamidbar/",i,sep=""), destfile = paste('C://paracha//bamidbar//',i,sep=""))
# }
# 
# download.file(url = "http://www.ahavatorah.com/resource/media/paracha/devarim", destfile = 'C://paracha//temp.html')
# tab <- read_html('C://paracha//temp.html') %>% html_nodes("table")
# tab <- tab[[1]] %>% html_table
# mp3 <- tab[grepl("\\.(?:mp3)$", tab$Name), 'Name']
# for (i in mp3){
#   download.file(url = paste("http://www.ahavatorah.com/resource/media/paracha/devarim/",i,sep=""), destfile = paste('C://paracha//devarim//',i,sep=""))
# }