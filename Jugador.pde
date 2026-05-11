// ============================================================
//  Jugador.pde  —  Subclase de Personaje (HERENCIA)
//  Añade: movimiento, arma equipada, munición, vidas extra
// ============================================================

class Jugador extends Personaje {

  // ── Atributos privados propios del Jugador ─────────────────
  private float velocidad;
  private int   municion;
  private Arma  armaEquipada;

  // Flags de movimiento (controlados desde keyPressed/keyReleased)
  private boolean moviendoArriba, moviendoAbajo, moviendoIzq, moviendoDer;

  // ── Constructor ────────────────────────────────────────────
  Jugador(float x, float y, String nombre) {
    super(x, y, nombre, 100, 15, color(80, 160, 255));
    this.velocidad = 3.5;
    this.municion  = 20;
    this.armaEquipada = null;
  }

  // ── Getters ────────────────────────────────────────────────
  int  getMunicion() { return municion; }
  Arma getArma()     { return armaEquipada; }
  void setMunicionActual(int m) { municion = max(0, m); }

  // ── Setters ────────────────────────────────────────────────
  void setVelocidad(float v)  { if (v > 0) velocidad = v; }
  void agregarMunicion(int m) { if (m > 0) municion += m; }
  void agregarVida(int hp)    { curar(hp); }  // redirige al método heredado

  // ── Equipar arma (oculta detalles de asignación) ──────────
  void equiparArma(Arma a) {
    armaEquipada = a;
    if (a != null) setDanioAtaque(a.getDanio());
  }

  // ── Mecánica de disparo (encapsula toda la lógica) ────────
  boolean disparar() {
    if (armaEquipada == null || municion <= 0) return false;
    municion--;
    // El daño real se aplica en el sketch principal al encontrar el objetivo
    return true;
  }

  // ── Flags de movimiento ───────────────────────────────────
  void moverArriba(boolean estado)    { moviendoArriba = estado; }
  void moverAbajo(boolean estado)     { moviendoAbajo  = estado; }
  void moverIzquierda(boolean estado) { moviendoIzq    = estado; }
  void moverDerecha(boolean estado)   { moviendoDer    = estado; }

  // ── Actualizar posición según flags ──────────────────────
  @Override
  void actualizar() {
    float nx = getX();
    float ny = getY();
    if (moviendoArriba)  ny -= velocidad;
    if (moviendoAbajo)   ny += velocidad;
    if (moviendoIzq)     nx -= velocidad;
    if (moviendoDer)     nx += velocidad;

    // Mantener dentro del canvas
    nx = constrain(nx, 20, width  - 20);
    ny = constrain(ny, 20, height - 20);
    setX(nx);
    setY(ny);
  }

  // ── Dibujar jugador (forma de nave/personaje) ─────────────
  @Override
  void dibujar() {
    if (!estaVivo()) return;
    float px = getX(), py = getY();

    // Cuerpo principal
    noStroke();
    fill(getColor());
    ellipse(px, py, 38, 38);

    // Indicador de dirección (triángulo superior = "frente")
    fill(180, 230, 255);
    triangle(px, py - 22, px - 10, py - 8, px + 10, py - 8);

    // Etiqueta del arma
    if (armaEquipada != null) {
      fill(255, 200, 60);
      textSize(10);
      textAlign(CENTER, CENTER);
      text("[" + armaEquipada.getNombre() + "]", px, py + 30);
    }

    dibujarBarraVida(px, py);
  }
}
