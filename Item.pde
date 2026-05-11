// ============================================================
//  Item.pde  
// (Encapsulación + Herencia)
// ============================================================

class Item {

  // ── Atributos privados ─────────────────────────────────────
  private float  x, y;
  private String nombre;
  private boolean activo;
  private color   colorItem;

  // ── Constructor ────────────────────────────────────────────
  Item(float x, float y, String nombre, color col) {
    this.x         = x;
    this.y         = y;
    this.nombre    = nombre;
    this.activo    = true;
    this.colorItem = col;
  }

  // ── Getters ────────────────────────────────────────────────
  float  getX()       { return x; }
  float  getY()       { return y; }
  String getNombre()  { return nombre; }
  boolean estaActivo(){ return activo; }
  color  getColorItem(){ return colorItem; }

  // ── Setters ────────────────────────────────────────────────
  void setActivo(boolean a) { activo = a; }
  void setColor(color c)    { colorItem = c; }
  void setX(float nx)       { x = nx; }
  void setY(float ny)       { y = ny; }
  void reactivarEn(float nx, float ny) {
    x = nx;
    y = ny;
    activo = true;
  }

  // ── Método PÚBLICO: aplicar efecto (sobreescribir en hijos)
  void aplicar(Jugador j) {
    efectoEspecifico(j);
    activo = false;   // el ítem desaparece al usarse
  }

  // ── Método PROTEGIDO: lógica concreta en subclases ─────────
  protected void efectoEspecifico(Jugador j) { /* implementar en hijos */ }

  // ── Dibujar base: cuadrado flotante ────────────────────────
  void dibujar() {
    if (!activo) return;
    float bob = sin(frameCount * 0.08) * 4;  // animación flotante
    noStroke();
    fill(colorItem);
    rect(x - 16, y - 16 + bob, 32, 32, 6);
    fill(255);
    textSize(10);
    textAlign(CENTER, CENTER);
    text(nombre, x, y + 28 + bob);
  }
}
