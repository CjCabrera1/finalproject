import processing.sound.*;
SoundFile file;
int accuracy = 1;
int time;
int speed = 1;
int h = 1;
int score;

// boolean
boolean shoot;
boolean lose;

// bullet
float hit;
float shots;


ArrayList asteroids;
void setup()
{
  size(800,500);
  asteroids = new ArrayList();
  file = new SoundFile(this,"raygun.mp3");
}

void draw()
{
  background(0);
  if(!lose)
  {
    difficultyChange();
    spawn();
    moveAst();
    atk();
    display();
    loser();
    text("Score: " + score, 10,15);
    text("Enemy health: " + h, 10, 31);
    if(shots != 0)
    {
      if (hit > shots){
        hit = shots;
      }
      text("Accuracy: " + int(hit) + "/" + int(shots), 10, 47);
    }
    time++;
  }
  else
  {
    text("YOU LOSE",10,40);
    text("SCORE: " + score,10,70);
  }

  shoot = false;
}


void mousePressed()
{
  shoot = true;
  shots ++;
}
class Asteroid
{
  int x;
  int y;
  int r;
  int maxHealth;
  int health;
  float speed;
  
  Asteroid(int tx, int tr, float tspeed, int th)
  {
    x = tx;
    r = tr;
    speed = tspeed;
    maxHealth = th;
    health = maxHealth;
  }
  
  void move()
  {
    y += speed;
  }
  
  void display()
  {
    fill(0,255,0);
    ellipse(x,y,r,r);
    fill(255,0,0);
    text(health, x - 2, y + 5);
  }
}
void spawn()
{
  if(time == 30)
  {
    time = 0;
    Asteroid enemy = new Asteroid(int(random(30,470)), int(random(20,40)),speed, h);
    asteroids.add(enemy);
    enemy = null;
    accuracy++;
  }
}

void moveAst()
{
    for(int i = 0; i < asteroids.size(); i++)
  {
    Asteroid enemy = (Asteroid)asteroids.get(i);
    enemy.move();
    enemy = null;
  }
}
void atk()
{
  if(shoot)
  {
    file.play();
    file.amp(.3);
    for(int i = 0; i < asteroids.size(); i++)
    {
      Asteroid enemy = (Asteroid) asteroids.get(i);
      if(mouseX < enemy.x + enemy.r && mouseX > enemy.x - enemy.r)
      {
        enemy.health -= 1;
        if(enemy.health <= 0)
        {
          enemy = null;
          asteroids.remove(i);
          score += int(speed) + h;
        }
        hit ++;
        score ++;
      }
    }
  } 
}
void display()
{
  for(int i = 0; i < asteroids.size(); i++)
  {
    Asteroid enemy = (Asteroid)asteroids.get(i);
    enemy.display();
    enemy = null;
  }
  fill(255);
  rect(mouseX-10,480,20,480);
  if(shoot)
  {
    stroke(255);
    line(mouseX,0,mouseX,500);
    stroke(0);
  }
}

void difficultyChange()
{
  if(speed < 8 && accuracy >= 10)
  {
   speed = accuracy / 10;
  }
  if(h < 3 && accuracy >= 10)
  {
    h = int(accuracy / 10);
  }
  
}
void loser()
{
  for(int i = 0; i < asteroids.size(); i++)
  {
    Asteroid enemy = (Asteroid) asteroids.get(i);
    if(enemy.y > 500)
    {
      lose = true;
    }
  }
}
