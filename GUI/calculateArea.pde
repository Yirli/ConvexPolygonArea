
static class CalculateArea{
  
  public static float selectPoints(ArrayList<PVector> convexHull){
    ArrayList<PVector> pointsOfTriangle = new ArrayList<PVector>();
    pointsOfTriangle.add(convexHull.get(0));
    
    float totalArea = 0;
    
    for(int i = 1; i<convexHull.size(); i++){
      if(pointsOfTriangle.size() == 3){
        totalArea += calcTriangleArea(pointsOfTriangle);
        pointsOfTriangle.clear();
        pointsOfTriangle.add(convexHull.get(0));
        pointsOfTriangle.add(convexHull.get(i-1));
      }
      pointsOfTriangle.add(convexHull.get(i));
    }
    return totalArea;
  }
  
  public static float calcTriangleArea(ArrayList<PVector> p){
      float area = (p.get(0).x*(p.get(1).y-p.get(2).y)+p.get(1).x*(p.get(2).y-p.get(0).y)+p.get(2).x*(p.get(0).y-p.get(1).y));
      return abs(area/2);
  }
  
  static float area(ArrayList<PVector> vertexs){
    return selectPoints(vertexs);
  }
    
  
}