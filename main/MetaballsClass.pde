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

