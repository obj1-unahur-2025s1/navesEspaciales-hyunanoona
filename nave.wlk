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

  method estaTranquila() = combustible >= 4000 and not velocidad > 12000 

  method escapar(){}

  method avisar(){}

  method recibirAmenaza(){
    self.escapar()
    self.avisar()
  }

  method tienePocaActividad() = true

  method estaDeRelajo() = self.estaTranquila() and self.tienePocaActividad()

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
  var seCambioDeColor

  method cambiarColorDeBaliza(colorNuevo){
    baliza = colorNuevo
    seCambioDeColor = true
  }

  method seCambioDeColor() = seCambioDeColor

  override method prepararViaje(){
    super()
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()
  }

  override method estaTranquila() = super() and not baliza == "rojo"

  override method escapar(){self.irHaciaElSol()}

  override method avisar(){self.cambiarColorDeBaliza("rojo")}
  
  override method tienePocaActividad() = not self.seCambioDeColor()
  
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
  var racionesDeComidaServidas

  method cargarComida(unaCantidad){racionesComida = racionesComida + unaCantidad}

  method descargarComida(unaCantidad){
    racionesComida = racionesComida - unaCantidad
    racionesDeComidaServidas = racionesDeComidaServidas + unaCantidad
  }

  method racionesDeComidaServidas() = racionesDeComidaServidas

  method cargarBebida(unaCantidad){racionesBebida = racionesBebida + unaCantidad}

  method descargarBebida(unaCantidad){racionesBebida = racionesBebida - unaCantidad}

  override method prepararViaje(){
    super()
    self.cargarComida(4*cantidadPasajeros)
    self.cargarBebida(6*cantidadPasajeros)
    self.acercarseUnPocoAlSol()
  }

  override method escapar(){velocidad = velocidad * 2}

  override method avisar(){
    self.descargarComida(cantidadPasajeros)
    self.descargarBebida(cantidadPasajeros*2)
  }

  override method tienePocaActividad() = racionesDeComidaServidas < 50
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

  override method estaTranquila() = super() and not self.misilesDeplegados()

  override method escapar(){
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
  }

  override method avisar(){self.emitioMensaje("Amenaza recibida")}

  override method tienePocaActividad() = not self.emitioMensaje("Amenaza recibida") //nunca se aclaro cual es la condicion en esta nave asi que la invente
}

// nave hospital
class NaveHospital inherits NavePasajeros{
  var estanPreparadosLosQuirofanos

  method prepararQuirofanos(){estanPreparadosLosQuirofanos = true}

  method estanPreparadosLosQuirofanos() = estanPreparadosLosQuirofanos

  override method estaTranquila() = super() and not self.estanPreparadosLosQuirofanos()

  override method recibirAmenaza(){
    super()
    self.prepararQuirofanos()
  }
}

//nave combate sigilosa
class NaveCombateSigilosa inherits NaveCombate{
  override method estaTranquila() = super() and not self.estaInvisible()

  override method escapar(){
    super()
    self.desplegarMisiles()
    self.ponerseInvisible()
  }
}