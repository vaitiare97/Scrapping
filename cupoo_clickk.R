#abriendo rvest

library('rvest') 


#abriendo pagina web cupoclick seccion todos

cupoclick <- read_html ("https://www.cupoclick.cl/collections/todos")

#revisando contenido de cupoclick seccion todos

print(html_text(cupoclick))
  

#obteniendo informacion de los productos en div

cupoclick <- read_html("https://www.cupoclick.cl/collections/todos")
tablaProductoscupoclick <- html_nodes(cupoclick, css = ".collection-grid.view-grid")

#reconociendo div de producto

cupoclick <- read_html("https://www.cupoclick.cl/collections/todos")
divProducto <- html_nodes(cupoclick, css = ".main_box")
print(html_text(divProducto))

#data de los productos

datoscupoclick <- data.frame()

#obteniendo precio de los productos en seccion todos
cupoclick <- read_html("https://www.cupoclick.cl/collections/todos")
tablaProductoscupoclick <- html_nodes(cupoclick, css = ".collection-grid.view-grid")
preciosProductosCupo <- html_nodes(tablaProductoscupoclick, css = ".price")
print(length(preciosProductosCupo))
print(html_text(preciosProductosCupo))

#mostrando precios obtenidos
for (posicionElemento in 1:length(preciosProductosCupo)) {
  print(html_text(preciosProductosCupo[posicionElemento]))
}

      
#obteniendo los nombres de los productos en seccion todos
cupoclick <- read_html("https://www.cupoclick.cl/collections/todos")
divProducto <- html_nodes(cupoclick, css = ".main_box")
tituloProductosCupoClick <- html_nodes(divProducto, css = "h5")
a <- html_nodes(tituloProductosCupoClick, css = "a")
print(length(tituloProductosCupoClick))
print(html_text(tituloProductosCupoClick))

#obteniendo link de productos y entrando a las paginas de cada producto
#obteniendo nombre y precio de cada producto

for (nombreElemento in a){
  print("================================================================")
  print(html_text(nombreElemento))
  nombreProducto <- html_text(nombreElemento)
  urlProductoCupo <- html_attr(nombreElemento, "href")
  urlcorregidaProductoCupo <- paste("https://www.cupoclick.cl" ,sep = "" ,(urlProductoCupo))
  print(urlcorregidaProductoCupo)
  urlcadaproductocupo <- urlcorregidaProductoCupo
  paginaProducto <- read_html(urlcorregidaProductoCupo)
  precioProducto <- html_nodes(paginaProducto, css = ".price.smart_checkout_price_pos")
  
#limpiando precios
  precioProducto <- html_nodes(paginaProducto, css = ".price.smart_checkout_price_pos")
  precioproductolimpio <- html_text(precioProducto)
  precioproductolimpio <- gsub("\n", "" ,precioproductolimpio)
  precioproductolimpio <- gsub("\t", "" ,precioproductolimpio)
  precioproductolimpio <- gsub("            ", "" ,precioproductolimpio)
  precioproductolimpio <- gsub("[$]", "" ,precioproductolimpio)
  precioproductolimpio <- gsub("[.]", "" ,precioproductolimpio)
  print(precioproductolimpio)
   Precio <-  precioproductolimpio

dfCupoClick <- data.frame(Nombre = nombreProducto, LinkProducto = urlcadaproductocupo, PrecioProducto = Precio) 
datoscupoclick <- rbind(datoscupoclick, dfCupoClick)
}

write.csv(datoscupoclick, "cupoclickcsv.csv")

