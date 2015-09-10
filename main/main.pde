public final static int fieldX = 800;
public final static int fieldY = 600;

public ArrayList metaballs = new ArrayList();
int threshold = 4;

void setup(){
  size(fieldX, fieldY, P2D);
  frameRate(10);
}

void draw(){
  background(0);
  renderMetaballs();
}

void mouseClicked(){
  metaballs.add(new Metaball(mouseX, mouseY, 1000000));
}

void mouseDragged(){
  ((Metaball) (metaballs.get(0))).move(new Vector2D(mouseX, mouseY));
}

public float netChargeHere(Vector2D here){
  float total = 0;
  for(int i = 0; i < metaballs.size(); i++){
      Metaball m = (Metaball) metaballs.get(i);
      total += m.chargeFrom(here);
  }
  return total;
}

public float netChargeMinusThis(Vector2D here, Metaball ball){
  float total = 0;
  for(int i = 0; i < metaballs.size(); i++){
    Metaball m = (Metaball) metaballs.get(i);
    if(!m.center.samePoint(ball.center)){
      total += m.chargeFrom(here);
    }
  }
  return total;
}

public void renderMetaballs(){
  for(int i = 0; i < fieldX; i++){
    for(int j = 0; j < fieldY; j++){
      Vector2D here = new Vector2D(i, j);

      if(netChargeHere(here) > threshold){
        set(i, j, color(180, 80, 80));
      }
      else if(netChargeHere(here) < -threshold){
        set(i, j, color(80, 80, 180));
      }
      else{
        set(i, j, color(0, 0, 0));
      }
    }
  }
}
    
