public final static int fieldX = 800;
public final static int fieldY = 600;

public ArrayList metaballs = new ArrayList();
int threshold = 4;
Metaball creating = null;

void setup(){
  size(fieldX, fieldY, P2D);
  frameRate(10);
}

void draw(){
  background(0);
  renderMetaballs();
  fill(255);
  growCreating();
}

void mousePressed(){
  if(mouseButton == LEFT){
    creating = new Metaball(mouseX, mouseY, 1000);
  }
  else{
    creating = new Metaball(mouseX, mouseY, -1000);
  }
}

void mouseReleased(){
  metaballs.add(new Metaball(creating));
  creating = null;
}

public void growCreating(){
  if(creating != null){
    if(mouseButton == LEFT){
      creating.charge += 1000;
    }
    else{
      creating.charge -= 1000;
    }
    creating.center.x = mouseX;
    creating.center.y = mouseY;
  }
}

public float netChargeHere(Vector2D here){
  float total = 0;
  for(int i = 0; i < metaballs.size(); i++){
      Metaball m = (Metaball) metaballs.get(i);
      total += m.chargeFrom(here);
  }
  if(creating != null){
    total += creating.chargeFrom(here);
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
    
