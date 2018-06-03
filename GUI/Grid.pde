class Grid{
  protected float step = formX(10);
  protected PVector pos;
  protected float width;
  protected float height;
  protected int stepsH = 0;
  protected int stepsV = 0;
  protected color background = color(230);
  protected color gridCol = color(100,30);
  protected color edge = color(20);
  protected float edgeSize = formX(1);
  protected PShape grid;
  protected PVector offset = new PVector();

  Grid(float w, float h, float step, PVector p){
    pos = new PVector(formX(p.x),formY(p.y));
    width = formX(w);
    height = formY(h);
    this.step = formX(step);
    calcSteps();
  }
  
  void calcSteps(){
    PShape temp;
    grid = null;
    grid = createShape(GROUP);
    stepsH = int(width/step);
    stepsV = int(height/step);
    float sum;
    for(int i=1; i<stepsH; i++){
      sum = pos.x+i*step-width/2;
      temp = createShape(LINE,sum,pos.y-height/2,sum,pos.y+height/2);
      temp.setStroke(gridCol);
      temp.setStrokeWeight(1);
      grid.addChild(temp);
    }
    for(int i=1; i<stepsV; i++){
      sum = pos.y+i*step-height/2;
      temp = createShape(LINE,pos.x-i-width/2,sum,pos.x+width/2,sum);
      temp.setStroke(gridCol);
      temp.setStrokeWeight(edgeSize);
      grid.addChild(temp);
    }
  }
  
  void draw(){
    pushMatrix();
    translate(pos.x+width/2+offset.x,pos.y+height/2+offset.y);
    shape(grid);
    popMatrix();
  }
  
  float getWidth(){
    return width;
  }
  
  float getHeight(){
    return height;
  }
  
  float getStep(){
    return step;
  }
  
  void offset(PVector p){
    offset = p.copy();
  }
  
}

class CartesianPlane extends Grid{
  protected float textSize = formX(10);
  
  CartesianPlane(float w, float h, float step, PVector p){
    super(w,h,step,p);
  }
  
  void calcSteps(){
    super.calcSteps();
    PShape temp;
    temp = createShape(LINE,pos.x+stepsH/2*step-width/2,pos.y-height/2,pos.x+stepsH/2*step-width/2,pos.y+height/2);
    temp.setStroke(lerpColor(gridCol,color(0,255),0.15));
    temp.setStrokeWeight(edgeSize*2);
    grid.addChild(temp);
    temp = createShape(LINE,pos.x-width/2,pos.y+stepsV/2*step-height/2,pos.x+width/2,pos.y+stepsV/2*step-height/2);
    temp.setStroke(lerpColor(gridCol,color(0,255),0.15));
    temp.setStrokeWeight(edgeSize*2);
    grid.addChild(temp);
  }
  
  void draw(){
   super.draw();
   float sum;
   pushMatrix();
   translate(pos.x+width/2+offset.x,pos.y+height/2+offset.y);
   for(int i=0; i<stepsH/2; i++){
     sum = pos.x+i*step;
     textSize(textSize);
     fill(color(30));
     text(""+int(sum/step),sum,pos.y);
     text(""+int(-sum/step),-sum,pos.y);
   }
   for(int i=0; i<stepsV/2; i++){
     sum = pos.y+i*step;
     textSize(textSize);
     fill(color(30));
     text(""+int(-sum/step),pos.x,sum);
     text(""+int(sum/step),pos.x,-sum);
   }
   popMatrix();
  }
  
  void setTextSize(float s){
    textSize = formX(s);
  }
  
  float getMaxY(){
    return stepsV/2;
  }
  
  float getMaxX(){
    return stepsH/2;
  }
}

class TransformGrid extends CartesianPlane{
  protected ArrayList<PVector> points = new ArrayList();
  
  TransformGrid(float w, float h, float step, PVector p){
    super(w,h,step,p);
  }
  
  void addPoint(PVector p){
    p = p.copy().div(step);
    p.y *= -1;
    points.add(p);
  }
  
  void draw(){
    super.draw();
    pushMatrix();
    translate(pos.x+width/2+offset.x,pos.y+height/2+offset.y);
    stroke(color(30,30,35));
    strokeWeight(3);
    for(PVector p : points){
      point(p.x*step,p.y*step);
    }
    popMatrix();
  }
  
  void clear(){
    points.clear();
  }
}

float formX(float pixels){
    return (pixels/1920.0)*width;
}

float formY(float pixels){
    return (pixels/1080.0)*height;
}