class Empresa {

	var sucursales = []
	
	method agregarSucursal(unaSucu){
		sucursales.add(unaSucu)
	}
	method totalFacturadoDeTodasLasSucursales(cant){ //punto2
		return sucursales.sum({sucursal => sucursal.totalFacturado(cant)})
	}
	
	
	method  sucursalQueMasFacturo(cant){ //punto 4
		return sucursales.max({sucursal => sucursal.totalFacturado(cant)})
	}
	
	method pedidoMasCaroXSucursal(){
		 
	}
	method pedidoMasCaroDeLaEmpresa(cantidPedidos){ //punto 6
		return	sucursales.map({sucursal => sucursal.pedidoMasCaro(cantidPedidos)}).max()
		
	}
	
	method sucursalQueVendioTodosLosTalles(){ // punto 7
		return sucursales.filter({sucursal => sucursal.sucursalVendioTodosLosTalles()})
	}

}

class Sucursal{
	var pedidos = []
	
	method agregarPedido(unPedido){ //punto 1
		pedidos.add(unPedido)
	}
	
	method totalFacturado(cant){ //punto 3
		return pedidos.sum({pedido => pedido.costoTotal(cant)})
	}
	
	method cantidadPedidosXcolor(unColor){ //punto 5
		return pedidos.count({pedido => pedido.estaContenidoUnColor(unColor)})	
	}
	
	method pedidoMasCaro(cantidadPedidos){
		return	pedidos.max({pedido => pedido.costoTotal(cantidadPedidos)})
	}
	
	method sucursalVendioTodosLosTalles(){ // TODO No es lo pedido
		return pedidos.any({pedido => pedido.seVendioTodosLosTalles()})
	}
}

class Pedido {

	var property cantidadParaQueDescuente
	var property tipoDeRemera
	var property seVendioTodosLosTalles = false // TODO Esto no vale, tenés que calcularlo
	
	method costoTotal(cantidadPedidios) {
		return self.costoXcantidad(cantidadPedidios) - (self.totalDescuento(cantidadPedidios)*self.costoXcantidad(cantidadPedidios))/100
	}
	
	method costoXcantidad(cantidadPedidios){
		return (tipoDeRemera.costo() * cantidadPedidios) 
	}

	method totalDescuento(cantidadPedidios) {
		if (cantidadParaQueDescuente < cantidadPedidios) {
			return tipoDeRemera.descuento()
			
		}
		else {
			return 0
		}
	}
	
	method estaContenidoUnColor(unColor){
		return tipoDeRemera.color() == unColor
	}

}

class Remera {

	var property color
	
}

class Lisa inherits Remera {

	method costo() {
		return color.costoDelColor()
	}

	method descuento() {
		return 10
	}

}

class Bordada inherits Remera {

		var colores = []

	method agregarColor(unColor) {
		colores.add(unColor)
	}

	method costo() {
		return colores.map({ color => color.costoDelColor() }).sum() // TODO No es lo pedido.
	}

	method descuento() {
		return 0
	}

}

class Sublimada inherits Remera {

	var property sublimadoXSuperficie
	var property marca

	method costo() {
		return color.costoDelColor() + (sublimadoXSuperficie.centimetroCuadradoDeSuperfice() * 50) + self.derechoDeAutor()
	}

	method derechoDeAutor() {
		return marca.precioPorDerechoDeAutor()
	}

	method descuento() {
		if (marca.tieneConvenioConLaPublicidad()) {
			return 0.20
		} else {
			return 0
		}
	}

}

class Marca {

	var property tieneConvenioConLaPublicidad = false
	var property tieneDerechoDeAutor = true
	var property precio

	method precioPorDerechoDeAutor() {
		if (tieneDerechoDeAutor) {
			return precio
		} else {
			return 0
		}
	}

}

class Color {

	var property talle
	var property nroTalle1
	var property nroTalle2

	method costoDelColor() {
		if (talle >= nroTalle1 && talle <= nroTalle2) {
			return 80
		} else {
			return 100
		}
	}

}

class OtroColor inherits Color {

	override method costoDelColor() {
		return super() * 1.10
	}

}

class SublimadoXSuperficie {

	var property alto
	var property ancho

	method centimetroCuadradoDeSuperfice() {
		return alto * ancho
	}

}

