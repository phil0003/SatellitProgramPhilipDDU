float angle;
PImage sphere;
PShape globe;
float lon = 150.5;
float lat = -37.5;
float r = 200;

JSONObject url;
  JSONArray posSat;
  
  JSONObject pos1;
  JSONObject pos2;
  
  float satLat;
  float satLon;
  float satAlt;
  
  PVector xyzAll;

void setup() {
  size(1800,1000,P3D);
    sphere = loadImage("earth.jpg");
    
  url = loadJSONObject("https://api.n2yo.com/rest/v1/satellite/positions/25544/41.702/-76.014/0/2/&apiKey=TMYM59-5QF89R-D748JA-4YA4");
  
  posSat = url.getJSONArray("positions");
  
  pos1 = posSat.getJSONObject(0);
  pos2 = posSat.getJSONObject(1);
  
  satLat = pos1.getFloat("satlatitude");
  satLon = pos2.getFloat("satlongitude");
  satAlt = (6400 + 417.85)/(6400/200);
  
  println(satLat,satLon,satAlt);
  
  xyzAll = convert(satLat,satLon,satAlt);
  
  println((6400/200)*xyzAll.x + "  " + (6400/200)*xyzAll.y + "   " + (6400/200)*(xyzAll.z));
  angle = 0;

  
  noStroke();
  globe = createShape(SPHERE,r);
  globe.setTexture(sphere);
}

void draw() {
  background(50);
  pushMatrix();
  translate(width * 0.5, height * 0.5);
    pushMatrix();
  rotateY(angle);
  //rotateX(angle);
  angle += 0.025;
  
  sphereDetail(90);
  //directionalLight(51,102,126,0,-1,0);
  lights();
  fill(200);
  noStroke();
  //texture(sphere);
  //sphere(r);
  shape(globe);
  
  popMatrix();
  pushMatrix();
  translate(xyzAll.x,xyzAll.y,abs(xyzAll.z));
  fill(200,200,100);
  box(10);
  popMatrix();
  popMatrix();
  
}

PVector convert(float satLat, float satLon, float satAlt ) {
  float theta = radians(satLat);
  float phi = radians(satLon) + PI;

  float x = satAlt * cos(theta) * cos(phi);
  float y = -satAlt * sin(theta);
  float z = -satAlt * cos(theta) * sin(phi);

  return new PVector(x, y, z);

}
