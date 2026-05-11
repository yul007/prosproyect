// ============================================================
//  Subclases de Item.pde
// herencias...
//  Powerup  |  Arma  |  Municiones
// ============================================================

// ────────────────────────────────────────────────────────────
//  Powerup — restaura vida al jugador
// ────────────────────────────────────────────────────────────
class Powerup extends Item {

  private int cantidadCura;   // atributo propio

  Powerup(float x, float y, String nombre, int cantidadCura) {
    super(x, y, nombre, color(60, 220, 100));
    this.cantidadCura = cantidadCura;
  }

  // Getter
  int getCantidadCura() { return cantidadCura; }

  // Sobreescritura del efecto concreto (Polimorfismo base)
  @Override
  protected void efectoEspecifico(Jugador j) {
    j.agregarVida(cantidadCura);
  }

  // Dibujar: cruz verde (símbolo salud)
  @Override
  void dibujar() {
    if (!estaActivo()) return;
    float px = getX(), py = getY();
    float bob = sin(frameCount * 0.08) * 4;
    noStroke();
    fill(getColorItem());
    // Cruz
    rect(px - 6,  py - 16 + bob, 12, 32, 3);
    rect(px - 16, py -  6 + bob, 32, 12, 3);
    fill(255);
    textSize(10);
    textAlign(CENTER, CENTER);
    text(getNombre(), px, py + 24 + bob);
  }
}












// ────────────────────────────────────────────────────────────
//  Arma — aumenta el daño del jugador
// ────────────────────────────────────────────────────────────
class Arma extends Item {

  private int    danio;
  private String tipoBala;
  private int    municionInicial;

  Arma(String nombre, int danio, String tipoBala, int municionInicial) {
    // Las armas se crean sin posición fija; se equipan directamente
    super(0, 0, nombre, color(255, 165, 0));
    this.danio           = danio;
    this.tipoBala        = tipoBala;
    this.municionInicial = municionInicial;
  }

  // Getters
  int    getDanio()           { return danio; }
  String getTipoBala()        { return tipoBala; }
  int    getMunicionInicial() { return municionInicial; }

  // Efecto al recoger: equipar arma y dar munición
  @Override
  protected void efectoEspecifico(Jugador j) {
    j.equiparArma(this);
    j.agregarMunicion(municionInicial);
  }

  // Las armas solo se dibujan si están en el mundo (activas con posición)
  @Override
  void dibujar() {
    if (!estaActivo() || getX() == 0) return;
    float px = getX(), py = getY();
    float bob = sin(frameCount * 0.08) * 4;
    noStroke();
    fill(getColorItem());
    // Forma de pistola simplificada
    rect(px - 14, py - 6  + bob, 28, 10, 3);
    rect(px - 4,  py - 14 + bob, 8,  10, 2);
    fill(255);
    textSize(10);
    textAlign(CENTER, CENTER);
    text(getNombre(), px, py + 18 + bob);
  }
}














// ────────────────────────────────────────────────────────────
//  Municiones — agrega balas al arma equipada
// ────────────────────────────────────────────────────────────
class Municiones extends Item {

  private int cantidad;
  private String tipo;

  Municiones(float x, float y, String tipo, int cantidad) {
    super(x, y,  tipo + "+", color(200, 200, 60));
    this.tipo     = tipo;
    this.cantidad = cantidad;
  }

  // Getters
  int    getCantidad() { return cantidad; }
  String getTipo()     { return tipo; }

  // Efecto al recoger: dar munición al jugador
  @Override
  protected void efectoEspecifico(Jugador j) {
    j.agregarMunicion(cantidad);
  }

  // Dibujar: pila de balas
  @Override
  void dibujar() {
    if (!estaActivo()) return;
    float px = getX(), py = getY();
    float bob = sin(frameCount * 0.08) * 4;
    noStroke();
    // Varias "balas" apiladas
    for (int i = 0; i < 3; i++) {
      fill(getColorItem());
      rect(px - 5 + i * 6, py - 14 + bob, 4, 22, 2);
    }
    fill(255);
    textSize(10);
    textAlign(CENTER, CENTER);
    text(getNombre(), px, py + 18 + bob);
  }
}
