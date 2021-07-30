
library('rvest')

## Abriendo pagina prodescuento ##

prodescuentoCL <- read_html("https://prodescuento.cl/ver-todos-nuestros-productos")

print(html_text(prodescuentoCL))

## Simulando navegacion en 3 paginas ##

for (numPagina in 1:3) {
  print("=====================================================================================================================")
  print(paste("Navegando por el num de pagina:",numPagina))
  urlprodescuentoCL <- paste("https://prodescuento.cl/ver-todos-nuestros-productos?",numPagina,"page=3",sep = "")
  print(urlprodescuentoCL)
  prodescuentoCL <- read_html(urlprodescuentoCL)
  print(html_text(prodescuentoCL))
}

## Lista de todos los productos ##

prodescuentoCL <- read_html("https://prodescuento.cl/ver-todos-nuestros-productos")
tablaprodescuentoCL <- html_nodes(prodescuentoCL,css = "div.col-md-3.col-6")
print(html_text(tablaprodescuentoCL[15]))


print(html_text(tablaprodescuentoCL[28]))

## Lista de todos los productos segun su posicion ##

for (posicionElemento in 1:length(tablaprodescuentoCL)) {
  print(html_text(tablaprodescuentoCL[35]))
  
}

#creando dataframe para la data de productos

datosprodescuento <- data.frame()

## Obteniendo precios de tabla de productos segun posicion ##

preciosprodescuentoCL <- html_nodes(tablaprodescuentoCL, css = "span.product-block-list")
print(length(preciosprodescuentoCL))
print(html_text(preciosprodescuentoCL[15]))

## Obteniendo todos los precios obtenidos ##

for (posicionElemento in 1:length(preciosprodescuentoCL)) {
  print(html_text(preciosprodescuentoCL[posicionElemento]))
}

## obteniendo titulos de productos con su descripcion ##
nombresProductosprodescuentoCL <- html_nodes(tablaprodescuentoCL, css="h4")
a <- html_nodes(nombresProductosprodescuentoCL, css = "a")
print(length(nombresProductosprodescuentoCL))

## obteniendo link de cada producto y precio ##
for (nombreElemento in a) {
  print("=====================================")
  print(html_text(nombreElemento))
  nombreProductoprodes <- html_text(nombreElemento)
  urlProductoprodescuento <- html_attr(nombreElemento, "href")
  urlCompletaProdescuento <- paste("https://prodescuento.cl" ,sep = "" ,(urlProductoprodescuento))
  print(urlCompletaProdescuento)
  linkcadaproductoprodes <- urlCompletaProdescuento
  paginaProductoProdescuento <- read_html(urlCompletaProdescuento)
  precioProductoProdescuento <- html_nodes(paginaProductoProdescuento, css = "#product-form-price-2")
  
## lipiando los precios
  precioProductoProdescuento <- html_nodes(paginaProductoProdescuento, css = "#product-form-price-2")
  precioProductoLibre <- html_text(precioProductoProdescuento)
  precioProductoLibre <- gsub("[$]", "" ,precioProductoLibre)
  precioProductoLibre <- gsub("[.]", "" ,precioProductoLibre)
  print(precioProductoLibre)
  Precio <- precioProductoLibre
  
  dfprodescuento <- data.frame(Nombre = nombreProductoprodes, LinkProducto = linkcadaproductoprodes, PrecioProducto = Precio)
  datosprodescuento <- rbind(datosprodescuento, dfprodescuento)   
}
 
write.csv(datosprodescuento, "prodescuentocsv.csv")
