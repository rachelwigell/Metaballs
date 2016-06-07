public final static int fieldX = 400;
public final static int fieldY = 300;

public ArrayList metaballs = new ArrayList();
int metaballThreshold = 4;
Metaball creating = null;
boolean allRepel = false;

void setup(){
  size(400, 300, P2D);
  frameRate(10);
}

void draw(){
  renderMetaballs();
  growCreating();
}

public void toggleMode(boolean dipole){
  if(dipole == allRepel){
    allRepel = !allRepel;
  }
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
  if(creating != null){
    metaballs.add(new Metaball(creating));
    creating = null;
  }
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

public boolean within(float num1, float num2, float threshold){
  return abs(num1-num2) < threshold;
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

public float netChargeMutallyRepulsive(Vector2D here, Metaball ball){
  float total = 0;
  for(int i = 0; i < metaballs.size(); i++){
      Metaball m = (Metaball) metaballs.get(i);
      if(m.center.samePoint(ball.center)){
        total += abs(m.chargeFrom(here));
      }
      else{
        total -= abs(m.chargeFrom(here));
      }      
  }
  if(creating != null){
    if(creating.center.samePoint(ball.center)){
        total += abs(creating.chargeFrom(here));
      }
    else{
      total -= abs(creating.chargeFrom(here));
    }
  }
  return total;
}

public void renderMetaballs(){
  if(!allRepel){
    for(int i = 0; i < fieldX; i++){
      for(int j = 0; j < fieldY; j++){
        Vector2D here = new Vector2D(i, j);
        float chargeHere = netChargeHere(here);
        if(chargeHere > metaballThreshold){
          set(i, j, color(180, 80, 80));
        }
        else if(chargeHere < -metaballThreshold){
          set(i, j, color(80, 80, 180));
        }
        else{
          set(i, j, color(0));
        }
      }
    }
  }
  else{
    for(int i = 0; i < fieldX; i++){
      for(int j = 0; j < fieldY; j++){
        set(i, j, color(0));
        Vector2D here = new Vector2D(i, j);
        for(int k = 0; k < metaballs.size(); k++){
          Metaball m = (Metaball) metaballs.get(k);
          float chargeHere = netChargeMutallyRepulsive(here, m);
          if(chargeHere > metaballThreshold){
            set(i, j, color(80, 180, 80));
          }
        }
        if(creating != null){
          float chargeHere = netChargeMutallyRepulsive(here, creating);
          if(chargeHere > metaballThreshold){
            set(i, j, color(80, 180, 80));
          }
        }
      }
    }
  }
}
    
