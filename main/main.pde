public final static int fieldX = window.screen.availWidth-100;
public final static int fieldY = window.screen.availHeight-100;

public ArrayList metaballs = new ArrayList();
int threshold = 24;

void setup(){
  size(fieldX, fieldY, P2D);
}

void draw(){
  background(0);
}

void mouseClicked(){
  metaballs.add(new Metaball(mouseX, mouseY, 100));
}
