// ============================================================
//  Personaje.pde 
//  Encapsulación y modificadores de acceso, getters/setters)
// ============================================================

class Personaje {

  // ── Atributos PRIVADOS (encapsulación) ─────────────────────
  private float x, y;
  private int   vida;
  private int   vidaMax;
  private String nombre;
  private boolean vivo;
  private int danioAtaque;
  private color colorPersonaje;

  // ── Constructor ────────────────────────────────────────────
  Personaje(float x, float y, String nombre, int vidaMax, int danioAtaque, color col) {
    this.x            = x;
    this.y            = y;
    this.nombre       = nombre;
    this.vidaMax      = vidaMax;
    this.vida         = vidaMax;
    this.danioAtaque  = danioAtaque;
    this.vivo         = true;
    this.colorPersonaje = col;
  }

  // ── Getters (acceso controlado) ────────────────────────────
  float  getX()       { return x; }
  float  getY()       { return y; }
  int    getVida()    { return vida; }
  int    getVidaMax() { return vidaMax; }
  String getNombre()  { return nombre; }
  boolean estaVivo()  { return vivo; }
  int    getDanioAtaque() { return danioAtaque; }
  color  getColor()   { return colorPersonaje; }

  // ── Setters con validación ─────────────────────────────────
  void setX(float nx)            { x = nx; }
  void setY(float ny)            { y = ny; }
  void setDanioAtaque(int d)     { if (d >= 0) danioAtaque = d; }
  void setColor(color c)         { colorPersonaje = c; }
  void setVidaActual(int v) {
    vida = (int)constrain(v, 0, vidaMax);
    vivo = vida > 0;
  }
  void setVidaMax(int nuevaVidaMax) {
    if (nuevaVidaMax <= 0) return;
    vidaMax = nuevaVidaMax;
    vida = (int)constrain(vida, 0, vidaMax);
    vivo = vida > 0;
  }

  // ── Método PÚBLICO que oculta lógica interna (encapsulación)
  void recibirDanio(int cantidad) {
    if (!vivo) return;
    vida = max(0, vida - cantidad);
    if (vida <= 0) morir();
  }

  void curar(int cantidad) {
    if (!vivo) return;
    vida = min(vidaMax, vida + cantidad);
  }

  // ── Lógica protegida de muerte (oculta detalles internos) ──
  protected void morir() {
    vida = 0;
    vivo = false;
  }

  // ── Actualizar: para sobreescribir en subclases ─────────────
  void actualizar() { /* lógica base vacía */ }

  // ── Dibujar barra de vida sobre el personaje ───────────────
  protected void dibujarBarraVida(float px, float py) {
    float anchoBar = 40;
    float altoBar  = 5;
    fill(80);
    noStroke();
    rect(px - anchoBar/2, py - 36, anchoBar, altoBar, 2);
    fill(50, 220, 80);
    float prop = map(vida, 0, vidaMax, 0, anchoBar);
    rect(px - anchoBar/2, py - 36, prop, altoBar, 2);
  }

  // ── Dibujar base: círculo con nombre ──────────────────────
  void dibujar() {
    if (!vivo) return;
    noStroke();
    fill(colorPersonaje);
    ellipse(x, y, 36, 36);
    dibujarBarraVida(x, y);
    fill(255);
    textSize(11);
    textAlign(CENTER, CENTER);
    text(nombre, x, y + 28);
  }
}
