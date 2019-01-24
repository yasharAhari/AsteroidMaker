

void setup(){
 size(1000,800,P3D);
 //test 1;
 AsteroidGenerator g = new AsteroidGenerator(50);
 Asteroid a = new Asteroid(g);
 a.generate();
 a.drawVertexes();
  
  
}





void draw()
{
  
  
  
}
