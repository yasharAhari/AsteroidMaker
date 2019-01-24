/**
  The class Vertex is same as Vector3 in Unity, hold the coordinate in 3D.



*/
class Vertex
{
 private float _x;
 private float _y;
 private float _z;
 
 public Vertex(float x,float y,float z)
 {
  _x = x;
  _y = y;
  _z = z;
 }
  
  public float getX()
  {
   return this._x;
   
  }
  public float getY()
  {
   return this._y; 
  }
  
  public float getZ()
  {
   return this._z; 
  }
  
}

/**
  The asteroid Generator is a class that randomly generates data for asteroids.


*/
class AsteroidGenerator
{
  private float size;
  private ArrayList<Vertex> _vertexes;
  private AsteroidGenerator(float size)
  {
    this.size = size;
    _vertexes = new ArrayList<Vertex>();
    
  }
  
  private AsteroidGenerator()
  {
    this.size = random(50,1500);
    _vertexes = new ArrayList<Vertex>();
  }
  
  
  private Vertex getCoordinates(float theta, float phi, float radius)
  {
   float x = radius * sin(theta) * cos(phi);
   float y = radius * sin(theta) * sin(phi);
   float z = radius * cos(theta);
   Vertex v = new Vertex(x,y,z);
   return v;
    
    
  }
  
  public void generate()
  {
    float radius = this.size;
    for(float phi = 0 ; phi <= 360 ; phi = phi + 0.5)
    {
     for(float theta = 0 ; theta <= 180 ; theta = theta + 0.5)
     {
       Vertex v = getCoordinates(theta,phi,radius);
       _vertexes.add(v);
       
       
     }
      
    }
    
    
    
  }
  
  
  public ArrayList<Vertex> getVertexes()
  {
   return this._vertexes; 
    
  }
  
  
}

class Asteroid
{
  private ArrayList<Vertex> _vertexList;
  private ArrayList<Vertex> _UVList;
  private int[] triangels;
  
  private AsteroidGenerator _generator;
  public Asteroid(AsteroidGenerator generator)
  {
    _generator = generator; 
    _vertexList = new ArrayList<Vertex>();
    _UVList = new ArrayList<Vertex>();
    
  }
  
  public void generate()
  {
    _generator.generate();
    _vertexList = _generator.getVertexes();
      
  }
  
  public void addVertex(Vertex _v)
  {
   _vertexList.add(_v); 
    
  }
  
  public void drawVertexes()
  {
   for(Vertex vertex : _vertexList)
   {
    point(vertex.getX(),vertex.getY(),vertex.getZ()); 
     
   }
  }
  
  
  
  
}
