class Nave{
  var velocidad
  var direccion 
  var combustible

  method acelerar(unValor){velocidad = velocidad + unValor}

  method desacelerar(unValor){velocidad = velocidad - unValor}

  method irHaciaElSol(){direccion = 10}

  method escaparDelSol(){direccion = -10}
  
  method ponerseParaleloAlSol(){direccion = 0}

  method acercarseUnPocoAlSol(){direccion = direccion + 1}

  method alejarseUnPocoDelSol(){direccion = direccion - 1}

  method cargar(unaCantidad){combustible = combustible + unaCantidad}

  method descargar(unaCantidad){combustible = combustible - unaCantidad}

  method prepararViaje(){
    self.cargar(30000)
    self.acelerar(5000)
  }

  method initialize(){
    if (not direccion.between(-10, 10)){
      self.error(direccion.toString() + "no es una direccion valida")
    }

    if (not velocidad.between(0, 100000)){
      self.error(velocidad.toString() + "no es una velocidad valida")
    }
  }
}

//nave baliza
class NaveBaliza inherits Nave{
  var baliza

  method cambiarColorDeBaliza(colorNuevo){baliza = colorNuevo}

  override method prepararViaje(){
    super()
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()
  }

  method initialize(){
    if (not colores.validos().contains(baliza)){
      self.error(baliza.toString() + "no es un color valido")
    }
  }
}

object colores{
  method validos() = ["verde", "rojo", "azul"]
}

//nave pasajeros
class NavePasajeros inherits Nave{
  const cantidadPasajeros 
  var racionesComida
  var racionesBebida

  method cargarComida(unaCantidad){racionesComida = racionesComida + unaCantidad}

  method descargarComida(unaCantidad){racionesComida = racionesComida - unaCantidad}

  method cargarBebida(unaCantidad){racionesBebida = racionesBebida + unaCantidad}

  method descargarBebida(unaCantidad){racionesBebida = racionesBebida - unaCantidad}

  override method prepararViaje(){
    super()
    self.cargarComida(4*cantidadPasajeros)
    self.cargarBebida(6*cantidadPasajeros)
    self.acercarseUnPocoAlSol()
  }
}

//nave combate
class NaveCombate inherits Nave{
  var esVisible
  var estanLosMisilesDeplegados
  const mensajesEmitidos
  
  method ponerseVisible(){esVisible = true}

  method ponerseInvisible(){esVisible = false}

  method estaInvisible() = esVisible 

  method desplegarMisiles(){estanLosMisilesDeplegados = true}

  method replegarMisiles(){estanLosMisilesDeplegados = false}

  method misilesDeplegados() = estanLosMisilesDeplegados

  method emitirMensaje(mensaje){mensajesEmitidos.add(mensaje)}

  method mensajesEmitidos() = mensajesEmitidos
  
  method primerMensajeEmitido() = mensajesEmitidos.first()
  
  method ultimoMensajeEmitido() = mensajesEmitidos.last()
  
  method esEscueta() = mensajesEmitidos.all{m => m.length() < 30}
  
  method emitioMensaje(mensaje) = mensajesEmitidos.contains(mensaje)

  override method prepararViaje(){
    super()
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en mision")
  }
}