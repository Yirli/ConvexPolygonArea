ArrayList<PVector> points = new ArrayList<PVector>(); 
QuickHull q ;
CartesianPlane g;

public void setup(){
  size(700,700);
  g = new TransformGrid(1920*2,1080*2,200,new PVector());
  g.setTextSize(30);
  g.offset(new PVector(-width*1,height*-0.0));
  reset();
}
  
public void draw(){
    background(255);
    g.draw();
    
   pushMatrix();
   translate(0,height);
   q.draw();
   popMatrix();
}
public void createPoints(){
  int max = (int)g.getMaxY();
  ((TransformGrid)g).clear();
  float step = g.getStep();
  for(int i = 0; i<50; i++){
    PVector pos = new PVector(random(1,max*step),random(1,max*step));
    ((TransformGrid)g).addPoint(pos);
    pos.y *= -1;
    points.add(pos);  
   }
}

public void printArea(){
  ArrayList<PVector> hull = new ArrayList();
  for(PVector p : q.getConvexHull())hull.add(p.copy().div(g.getStep()));
  println("El área de polígono es: "+CalculateArea.area(hull)+" ul^2");
}

void keyPressed(){
  if(key=='r')reset();
}

void reset(){
  points.clear();
  createPoints();
  q = new QuickHull();
  q.quickHull(); 
  printArea();
}