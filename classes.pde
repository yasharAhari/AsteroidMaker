/**
  The class Vertex is same as Vector3 in Unity, hold the coordinate in 3D.



*/
class Vertex
{
 private float _x;
 private float _y;
 private float _z;
 private float _radius;
 
 public Vertex(float x,float y,float z,float radius)
 {
  _x = x;
  _y = y;
  _z = z;
  _radius = radius;
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
  
  public float getRadius()
  {
   return _radius; 
  }
  
}

/**
  The asteroid Generator is a class that randomly generates data for asteroids.


*/
class AsteroidGenerator
{
  private float size;
  private ArrayList<Vertex> _vertexes;
  private float noiseLevel;
  private AsteroidGenerator(float size , float noiseLevel)
  {
    this.size = size;
    this.noiseLevel = noiseLevel;
    _vertexes = new ArrayList<Vertex>();
    
  }
  
  private AsteroidGenerator(float noiseLevel)
  {
    this.size = random(50,1500);
    this.noiseLevel = noiseLevel;
    _vertexes = new ArrayList<Vertex>();
  }
  
  
  private Vertex getCoordinates(float theta, float phi, float radius)
  {
    theta = theta * PI/180;
    phi = phi * PI/180;
   float x = radius * sin(theta) * cos(phi);
   float y = radius * sin(theta) * sin(phi);
   float z = radius * cos(theta);
   Vertex v = new Vertex(x,y,z,radius);
   return v;
    
    
  }
  
  public void generate()
  {
    
    float radius = random(3*size/4,size);
    float initial_radius = radius;
    boolean first_run_flag_theta = true;
    boolean first_run_flag_phi = true;
    float radius_side_theta = 0;
    float radius_side_phi = 0;
    for(float phi = 0 ; phi <= 360 ; phi = phi + 2)
    {
      int theta_vertex_count = 0;
     for(float theta = 0 ; theta <= 180 ; theta = theta + 2)
     {
       if(!first_run_flag_theta)
       {
         Vertex side_vertex_theta = _vertexes.get(_vertexes.size() - 1);
          radius_side_theta = side_vertex_theta.getRadius();
         if(!first_run_flag_phi)
         {
           Vertex side_vertex_phi = _vertexes.get(_vertexes.size() - theta_vertex_count - 1);
           radius_side_phi = side_vertex_phi.getRadius(); 
         }
         else
         {
           radius_side_phi = initial_radius;
         }
         float median_radius = (radius_side_theta + radius_side_phi) / 2;
         radius = random(median_radius - noiseLevel, median_radius + noiseLevel); 
       }
       
       Vertex v = getCoordinates(theta,phi,radius);
       _vertexes.add(v);
       ++theta_vertex_count;
       
       first_run_flag_theta = false;
      } 
      first_run_flag_phi = false;
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
    beginShape(POINTS);
    Vertex oldVertex = null;
   for(Vertex vertex : _vertexList)
   {
     vertex(vertex.getX(),vertex.getY(),vertex.getZ());
     
     if(oldVertex != null)
     {
      line(oldVertex.getX(),oldVertex.getY(),oldVertex.getZ(),vertex.getX(),vertex.getY(),vertex.getZ()); 
       
     }
     oldVertex = vertex;
     
   }
   endShape();
  }
  
  
  
  
}
