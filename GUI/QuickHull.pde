public class QuickHull{
  
  public ArrayList<PVector> convexHull = new ArrayList<PVector>();
    private int minIndex = 0; 
    private int maxIndex = 0;
    private float smallX = width;
    private float biggerX = 0;
    
    public int findSmallPoint(){  
      for(int i = 0; i<points.size(); i++){
        if(points.get(i).x < smallX){
          smallX = points.get(i).x;
          minIndex = i;
        }
    }
     return minIndex;
    }
  
  public int findBiggerPoint(){
   for(int j = 0; j<points.size(); j++){
    if(points.get(j).x > biggerX){
      biggerX = points.get(j).x;
      maxIndex = j;
    }
   }
   return maxIndex;
    
  }
  
   public ArrayList<PVector> pointsAtLeft(PVector min, PVector max){
     ArrayList<PVector> leftSide = new ArrayList<PVector>();
     for (int i = 0; i < points.size(); i++){
              PVector p = points.get(i);
              if (pointPosition(min, max, p) == -1)
                  leftSide.add(p);
        }
       return leftSide;
  }
  
  public  ArrayList<PVector> pointsAtRight(ArrayList<PVector>  l,PVector min, PVector max){
    ArrayList<PVector> rightSide = new ArrayList<PVector>();
    for (int i = 0; i < l.size(); i++){
      PVector p = l.get(i);
      if (pointPosition(min, max, p) == 1)
            rightSide.add(p);
        }
      return rightSide;
  }
  
   public float pointPosition(PVector min, PVector max, PVector p){
        float location = (max.x - min.x) * (p.y - min.y) - (max.y - min.y) * (p.x - min.x);
        if (location > 0)
            return 1.0;
        else if (location == 0)
            return 0;
        else
            return -1.0;
    }
    
     public float calculateDistance(PVector min, PVector max, PVector p){
        float px = max.x - min.x;
        float py = max.y - min.y;
        float dist = px * (min.y - p.y) - py * (min.x - p.x);
        if (dist < 0)
            dist = -dist;
        return dist;
    }
    
    public void findHull(PVector min, PVector max, ArrayList<PVector> side,ArrayList<PVector> hullPoints){
        int insertPosition = hullPoints.indexOf(max);
        if (side.size() == 0)
            return;
        if (side.size() == 1){
            PVector p = side.get(0);
            side.remove(p);
            hullPoints.add(insertPosition, p);
            return;
            
        }else{
          
        //Encontrar el punto mas alejado
        float dist = 0;
        int furthestIndex = -1;
        for (int i = 0; i < side.size(); i++){
            PVector p = side.get(i);
            float distance = calculateDistance(min, max, p);
            if (distance > dist){
                dist = distance;
                furthestIndex = i;
            }
        }
        
        PVector furthest = side.get(furthestIndex);
        side.remove(furthestIndex);
        hullPoints.add(insertPosition, furthest);
 
        ArrayList<PVector> leftSetAP = pointsAtRight(side,min,furthest);
        ArrayList<PVector> leftSetPB = pointsAtRight(side,furthest,max);
      
        findHull(min, furthest, leftSetAP, hullPoints);
        findHull(furthest, max, leftSetPB, hullPoints);
 
      }
    }
    
     public ArrayList<PVector> quickHull(){
        maxIndex = findBiggerPoint();
        minIndex = findSmallPoint();
        PVector min = points.get(minIndex);
        PVector max = points.get(maxIndex);
        convexHull.add(min);
        convexHull.add(max);
        points.remove(min);
        points.remove(max);    
        ArrayList<PVector> leftSide = pointsAtLeft(min,max);
        ArrayList<PVector> rightSide = pointsAtRight(points,min,max);
        findHull(min, max, rightSide, convexHull);
        findHull(max, min, leftSide, convexHull);
 
        return convexHull;
    }
    
    
   public ArrayList<PVector> getConvexHull(){
     return convexHull;
   }
 
   public void draw(){
     stroke(255, 0, 0);
     strokeWeight(1);
     for(int i = 0; i<convexHull.size()-1; i++){
       line(convexHull.get(i).x,convexHull.get(i).y,convexHull.get(i+1).x, convexHull.get(i+1).y);
     }
     line(convexHull.get(0).x,convexHull.get(0).y,convexHull.get(convexHull.size()-1).x,convexHull.get(convexHull.size()-1).y);
    
     PVector reference = convexHull.get(0);
     for(int i = 2; i<convexHull.size()-1; i++){
       line(reference.x,reference.y,convexHull.get(i).x,convexHull.get(i).y);
     }
  }
}