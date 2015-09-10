public final static int fieldX = 300; //window.screen.availWidth-100;
public final static int fieldY = 300; //window.screen.availHeight-100;

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
  metaballs.add(new Metaball(mouseX, mouseY, 100000));
}

public float netChargeHere(Vector2D here){
  float total = 0;
  for(int i = 0; i < metaballs.size(); i++){
      Metaball m = (Metaball) metaballs.get(i);
      total += m.chargeFrom(here);
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
    
public class Metaball {
  Vector2D center;
  int charge;
  boolean selected;

  public Metaball(int centerX, int centerY, int charge){
    this.center = new Vector2D(centerX, centerY);
    this.charge = charge;
    selected = false;
  }
  
  public void move(Vector2D to){
    this.center = to;
  }
  
  public float distanceFromCenter(Vector2D from){
    return this.center.distanceFrom(from);
  }
  
  public float squaredDistFromCenter(Vector2D from){
    return this.center.squareRad(from);
  }
  
  public float chargeFrom(Vector2D from){
    float rad = this.squaredDistFromCenter(from);
    return this.charge/(rad * rad);
  } 
}

public class Vector2D {
  public float x;
  public float y;
  
  public Vector2D(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  public float distanceFrom(Vector2D from){
    return (float) sqrt((this.x - from.x)*(this.x-from.x) + (this.y - from.y)*(this.y-from.y));
  }
  
  public float squareRad(Vector2D from){
    return (float) (this.x - from.x)*(this.x-from.x) + (this.y - from.y)*(this.y-from.y);
  }
  
  public boolean samePoint(Vector2D as){
    return (this.x == as.x && this.y == as.y);
  }
}


