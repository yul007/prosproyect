// ============================================================
//  Enemigo.pde  —  Subclase de Personaje (HERENCIA)
//  Añade: movimiento autónomo hacia el jugador, dificultad
// ============================================================

class Enemigo extends Personaje {

  // ── Atributos privados ─────────────────────────────────────
  private float velocidad;
  private float dificultad;   // multiplicador de daño / velocidad
  private float angulo;       // para movimiento ondulado

  // ── Constructor ────────────────────────────────────────────
  Enemigo(float x, float y, String nombre, float dificultad) {
    super(x, y, nombre,
          (int)(60 * dificultad),   // vidaMax escala con dificultad
          (int)(8  * dificultad),   // daño    escala con dificultad
          color(220, 60, 60));
    this.dificultad = dificultad;
    this.velocidad  = 1.0 + dificultad * 0.5;
    this.angulo     = random(TWO_PI);
  }

  // ── Getters propios ────────────────────────────────────────
  float getDificultad() { return dificultad; }
  int   getDanio()      { return getDanioAtaque(); }

  // ── Actualizar: perseguir al jugador ──────────────────────
  @Override
  void actualizar() {
    if (!estaVivo()) return;

    float dx = jugador.getX() - getX();
    float dy = jugador.getY() - getY();
    float d  = dist(0, 0, dx, dy);
    if (d > 0) {
      setX(getX() + (dx / d) * velocidad);
      setY(getY() + (dy / d) * velocidad);
    }
  }

  // ── Dibujar enemigo (rombo/diamante) ──────────────────────
  @Override
  void dibujar() {
    if (!estaVivo()) return;
    float px = getX(), py = getY();

    pushMatrix();
    translate(px, py);
    rotate(frameCount * 0.025);
    noStroke();
    fill(getColor());
    // Rombo
    beginShape();
    vertex( 0, -20);
    vertex( 16,  0);
    vertex( 0,  20);
    vertex(-16,  0);
    endShape(CLOSE);

    // Ojo
    fill(255, 240, 0);
    ellipse(0, 0, 10, 10);
    fill(0);
    ellipse(0, 0, 5, 5);
    popMatrix();

    dibujarBarraVida(px, py);
    fill(255, 160, 160);
    textSize(10);
    textAlign(CENTER, CENTER);
    text(getNombre(), px, py + 28);
  }
}

// ────────────────────────────────────────────────────────────
//  Asteoride — enemigo especial con más vida y movimiento más errático
// ────────────────────────────────────────────────────────────
class Asteoride extends Enemigo {
  Asteoride(float x, float y, String nombre, float dificultad) {
    super(x, y, nombre, dificultad + 0.8);
    setColor(color(180, 180, 190));
    setDanioAtaque(max(10, getDanioAtaque() + 4));
  }

  @Override
  void actualizar() {
    if (!estaVivo()) return;
    float dx = jugador.getX() - getX();
    float dy = jugador.getY() - getY();
    float d = dist(0, 0, dx, dy);
    if (d > 0) {
      setX(getX() + (dx / d) * 0.7);
      setY(getY() + (dy / d) * 0.7);
    }
  }

  @Override
  void dibujar() {
    if (!estaVivo()) return;
    float px = getX(), py = getY();

    pushMatrix();
    translate(px, py);
    rotate(frameCount * 0.03);
    noStroke();
    fill(getColor());
    beginShape();
    vertex(0, -24);
    vertex(18, -10);
    vertex(24, 8);
    vertex(8, 24);
    vertex(-12, 20);
    vertex(-24, 0);
    vertex(-16, -18);
    endShape(CLOSE);
    fill(110, 110, 120);
    ellipse(-5, -3, 10, 10);
    ellipse(10, 8, 7, 7);
    popMatrix();

    dibujarBarraVida(px, py);
    fill(230);
    textSize(10);
    textAlign(CENTER, CENTER);
    text(getNombre(), px, py + 30);
  }
}
