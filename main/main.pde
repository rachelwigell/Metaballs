public final static int fieldX = 300;
public final static int fieldY = 300;

public ArrayList metaballs = new ArrayList();
int metaballThreshold = 4;
Metaball creating = null;
boolean metaballMode = true;

color fieldLineColor = 0;
float fieldLineThreshold = .015;
float fieldLineCharge = 0;
public ArrayList oldPixels = new ArrayList();
public ArrayList newPixels = new ArrayList();
float[][] charges = new float[fieldX][fieldY];

void setup(){
  size(fieldX, fieldY, P2D);
  frameRate(10);
}

void draw(){
  background(0);
  if(metaballMode){
    renderMetaballs();
    growCreating();
  }
  else{
    growFieldLine();
  }
}

void keyPressed(){
  metaballMode = !metaballMode;
  if(!metaballMode){
    for(int i = 0; i < fieldX; i++){
      for(int j = 0; j < fieldY; j++){
        charges[i][j] = netChargeHere(new Vector2D(i, j));
      }
    }
  }
}

void mousePressed(){
  if(metaballMode){
    if(mouseButton == LEFT){
      creating = new Metaball(mouseX, mouseY, 1000);
    }
    else{
      creating = new Metaball(mouseX, mouseY, -1000);
    }
  }
  else{
    Vector2D click = new Vector2D(mouseX, mouseY);
    oldPixels.add(click);
    fieldLineColor = color(random(0, 255), random(0, 255), random(0, 255));
    fieldLineCharge = netChargeHere(click);
  }
}

void mouseReleased(){
  if(metaballMode){
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

public void growFieldLine(){
  newPixels = new ArrayList();
  for(int i = 0; i < oldPixels.size(); i++){
    Vector2D pixel = (Vector2D) oldPixels.get(i);
    set((int) pixel.x, (int) pixel.y, fieldLineColor);
    ArrayList surroundingPixels = new ArrayList();
    surroundingPixels.add(new Vector2D(pixel.x+1, pixel.y));
    surroundingPixels.add(new Vector2D(pixel.x+1, pixel.y+1));
    surroundingPixels.add(new Vector2D(pixel.x, pixel.y+1));
    surroundingPixels.add(new Vector2D(pixel.x-1, pixel.y));
    surroundingPixels.add(new Vector2D(pixel.x-1, pixel.y-1));
    surroundingPixels.add(new Vector2D(pixel.x, pixel.y-1));
    surroundingPixels.add(new Vector2D(pixel.x+1, pixel.y-1));
    surroundingPixels.add(new Vector2D(pixel.x-1, pixel.y+1));
    for(int j = 0; j < 8; j++){
      Vector2D adjacentPixel = (Vector2D) surroundingPixels.get(j);
      if(within(charges[(int) adjacentPixel.x][(int) adjacentPixel.y], fieldLineCharge, fieldLineThreshold)){
        newPixels.add(adjacentPixel);
      }
    }
  }
  oldPixels = new ArrayList();
  for(int i = 0; i < newPixels.size(); i++){
    oldPixels.add(newPixels.get(i));
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

      if(netChargeHere(here) > metaballThreshold){
        set(i, j, color(180, 80, 80));
      }
      else if(netChargeHere(here) < -metaballThreshold){
        set(i, j, color(80, 80, 180));
      }
      else{
        set(i, j, color(0, 0, 0));
      }
    }
  }
}
    
