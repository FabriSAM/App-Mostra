import processing.video.*;
import java.util.Map;

//Interi
int timer = 60;
int interviewIndex;
int arrayCount = 0;
int ticketCounterAdult;
int ticketCounterHalf;
int ticketCounterFree;

int firstBtnX = 50;
int firstBtnY = 310;
int firstBtnW = 130;
int firstBtnH = 50;

int resX = 416;
int resY = 900;

//Float
float laMostraY = 0;
float pieroY = 0;
float wangY = 0;
float quevadoY = 0;

//Stringhe
String artistSelected = "";
String interviewSelected = "";

//Colori
color sidebar_color = color(141, 141, 141, 255);
color rect_color = color(217, 217, 217, 255);
color button_color = color(192, 192, 192, 50);
color bg_color = color(255, 255, 255, 255);
color transparent_color = color(255,255,255,0);

//Buleani
boolean firstTime = true;
HashMap<String, Integer> pageList  = new HashMap<String, Integer>();
void InitPage()
{
  pageList.put("landingPageActive", 1);
  pageList.put("firstPageActive", 0);
  pageList.put("laMostraPageActive", 0);
  pageList.put("artistiActive", 0);
  pageList.put("artistaInfoPageActive", 0);
  pageList.put("intervisteActive", 0);
  pageList.put("intervisteInfoPageActive", 0);
  pageList.put("bigliettoPageActive", 0);
  pageList.put("pieroPageActive", 0);
  pageList.put("wangPageActive", 0);
  pageList.put("quevadoPageActive", 0);
  pageList.put("memoryPageActive", 0);
}


// Immagini
PImage img_wifi;
PImage img_battery;
PImage img_lte;
PImage img_backHome;
PImage img_barcode;
PImage img_plus;
PImage img_minus;
PImage img_home;
PImage img_mostra;
PImage img_mostra_top;
PImage img_homebar;
PImage img_artisti;
PImage img_fame;
PImage img_piero;
PImage img_piero_top;
PImage img_mangia;
PImage img_wang;
PImage img_wang_top;
PImage img_gusta;
PImage img_quevado;
PImage img_quevado_top;

//Bottoni
Button btn_skip;
Button btn_mostra;
Button btn_artisti;
Button btn_biglietti;
Button btn_backHome;
Button btn_plus;
Button btn_minus;
Button btn_plus2;
Button btn_minus2;
Button btn_back;

//Video
Movie introVideo;

Memory memory;

void setup()
{
  size(416, 900);
  //fullScreen();
  background(bg_color);
  InitPage();

  //Immagini
  //Assets/misc
  img_wifi = loadImage("Assets/misc/wifi.png");
  img_battery = loadImage("Assets/misc/battery.png");
  img_lte = loadImage("Assets/misc/lte.png");
  img_backHome = loadImage("Assets/misc/back.png");
  img_barcode = loadImage("Assets/misc/barcode.png");
  img_plus = loadImage("Assets/misc/plus.png");
  img_minus = loadImage("Assets/misc/minus.png");

  //Assets/homebar
  img_homebar = loadImage("Assets/homebar/intera.png");

  //Assets/menu
  img_home = loadImage("Assets/menu/home.png");
  img_artisti = loadImage("Assets/menu/artisti.png");
  img_fame = loadImage("Assets/menu/fame.png");
  img_mangia = loadImage("Assets/menu/mangia.png");
  img_gusta = loadImage("Assets/menu/gusta.png");

  //Assets/artisti
  img_mostra = loadImage("Assets/artisti/mostra.png");
  img_mostra_top = loadImage("Assets/artisti/mostra_top.png");
  img_piero = loadImage("Assets/artisti/piero.png");
  img_piero_top = loadImage("Assets/artisti/piero_top.png");
  img_wang = loadImage("Assets/artisti/wang.png");
  img_wang_top = loadImage("Assets/artisti/wang_top.png");
  img_quevado = loadImage("Assets/artisti/quevado.png");
  img_quevado_top = loadImage("Assets/artisti/quevado_top.png");

  //Bottoni
  btn_skip = new Button(new PVector(300, 650), new PVector(30, 30), "", button_color);
  btn_mostra = new Button(new PVector(206, 273), new PVector(101, 60), "", transparent_color);
  btn_artisti = new Button(new PVector(120, 389), new PVector(101, 60), "", transparent_color);
  btn_biglietti = new Button(new PVector(120, 620), new PVector(101, 60), "", transparent_color);
  btn_plus = new Button(new PVector(firstBtnX + firstBtnW - 20, firstBtnY + firstBtnH/2 - 2), new PVector(10, 10), "", color(0,0,0,0));
  btn_minus = new Button(new PVector(firstBtnX + 10, firstBtnY + firstBtnH/2 - 2), new PVector(10, 10), "", color(0,0,0,0));
  btn_plus2 = new Button(new PVector(firstBtnX + firstBtnW + 20 + firstBtnW - 20, firstBtnY + firstBtnH/2 - 2), new PVector(10, 10), "", color(0,0,0,0));
  btn_minus2 = new Button(new PVector(firstBtnX + firstBtnW + 20 + 10, firstBtnY + firstBtnH/2 - 2), new PVector(10, 10), "", color(0,0,0,0));
  
  //Video di Intro
  introVideo = new Movie(this, dataPath("Assets/video/intro.mp4").replace("\\data", ""));
}

//Event Methods
//NON RIMUOVERE QUESTO METODO
void movieEvent(Movie m) {
  m.read();
}

void mouseWheel(MouseEvent event) {

  if (GetBoolFromHash("firstPageActive")) return;
  float e = event.getCount();
  e *= -1;
  if (GetBoolFromHash("laMostraPageActive"))
  {
    laMostraY = constrain(laMostraY + e*10, resY - img_mostra.height, 43);
  } else if (GetBoolFromHash("pieroPageActive"))
  {
    pieroY = constrain(pieroY + e*10, resY - img_piero.height, 43);
  }else if (GetBoolFromHash("wangPageActive"))
  {
    wangY = constrain(wangY + e*10, resY - img_wang.height, 43);
  }else if (GetBoolFromHash("quevadoPageActive"))
  {
    quevadoY = constrain(quevadoY + e*10, resY - img_quevado.height, 43);
  }
}

//Utility Methods
boolean GetBoolFromHash(String key)
{
  int value = pageList.get(key);
  if (value == 1)
  {
    return true;
  } 

  return false;
}

//Metodo per scrivere un testo
void DrawTextLayer(int x, int y, String text, int textSize, color col, int strokeValue, int verticalAlign, int horizontalAlign)
{
  //Controllo per verificare se inserire o meno il grassetto
  if (strokeValue == 0)
  {
    noStroke();
  } else
  {
    stroke(strokeValue);
  }
  textSize(textSize);
  textAlign(verticalAlign, horizontalAlign);
  fill(col);
  text(text, x, y);
}

void TemporizationPage()
{
  if (timer < 0)
  {
    timer = 60;
    firstTime = false;
  }
  
  if (firstTime)
  {
    timer --;
  }
}

void HomeBar(String[] editPage)
{
  image(img_homebar, width * 0.5 - img_homebar.width * 0.5, height - 50);

  println(width * 0.5 - img_homebar.width * 0.5);

  //Central button
  Button btn_backHome = new Button(new PVector(width * 0.5 - 15, height - 42.5), new PVector(30, 30), "", transparent_color);
  btn_backHome.canHovered = false;
  btn_backHome.Draw();

  //Left button
  Button btn_back = new Button(new PVector(width * 0.5 - img_homebar.width * 0.5 + 17.5 , height - 42.5), new PVector(30, 30) ,"", transparent_color);
  btn_back.canHover = false;
  btn_back.Draw();
  if(!firstTime)
  {  
    if (btn_backHome.OnClicked())
    {
      pageList.put(editPage[1], 0);
      pageList.put("firstPageActive" , 1);
      firstTime = true;
      return;
    }

    if (btn_back.OnClicked())
    {
      pageList.put(editPage[1], 0);
      pageList.put(editPage[0], 1);
      firstTime = true;
      return;
    }
  }
}

//Metodo Sidebar
void Sidebar()
{
  fill(sidebar_color);
  noStroke();

  rect(0, 0, width, 43);
  //rect(0, height - 44, width, 44);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(17);
  text(nf(hour(), 2) + " : " + nf(minute() , 2), 30, 44/2);

  // Incone stato telefono
  image(img_wifi, width-60, 44/2-5, 12, 10);
  image(img_lte, width-40, 44/2-5, 12, 10);
  image(img_battery, width-20, 44/2-5, 12, 10);
}

// METODI PER LA VISUALIZZAZIONE DELLE PAGINE

// Pagina di arrivo
void LandingPage()
{
  introVideo.play();
  image(introVideo, 0, 44, width, height - 88);
  btn_skip.Draw();
  if (introVideo.time() >= introVideo.duration()-0.05)
  {
    EndVideo();
  }

  if (btn_skip.OnClicked())
  {
    EndVideo();
  }
}

void EndVideo()
{
  if (GetBoolFromHash("landingPageActive"))
  {
    introVideo.stop();
    pageList.put("landingPageActive", 0);
    pageList.put("firstPageActive", 1);  
  }
}

//Metodo Pagina 1
void FirstPage()
{
  image(img_home, 0, 0, resX, resY);
  
  btn_mostra.Draw();
  btn_artisti.Draw();
  btn_interviste.Draw();
  btn_biglietti.Draw();
  
  if (btn_mostra.OnClicked())
  {
    pageList.put("laMostraPageActive", 1);
    pageList.put("firstPageActive" , 0);
    firstTime = true;
  }

  if (btn_artisti.OnClicked())
  {
    pageList.put("firstPageActive" ,0);
    pageList.put("artistiActive", 1);
    firstTime = true;
  }
  
  if (btn_interviste.OnClicked())
  {
    pageList.put("intervisteActive", 1);
    pageList.put("firstPageActive" , 0);
    firstTime = true;
  }

  if (btn_biglietti.OnClicked())
  {
    pageList.put("firstPageActive" , 0);
    pageList.put("bigliettoPageActive", 1);
    firstTime = true;
  }  
}

//Metodo per visualizzare la pagina "LA MOSTRA"
void LaMostraPage()
{
  TemporizationPage();
  image(img_mostra, 0, 43 + laMostraY);
  image(img_mostra_top, 0, 43);

  String[] editPage = {"firstPageActive", "laMostraPageActive"};
  HomeBar(editPage);
}

//Metodo per visualizzare la pagina "GLI ARTISTI"
String ArtistiPage()
{
  TemporizationPage();
  image(img_artisti, 0, 43);

  Button btn_1 = new Button(new PVector(100, 238.61 + 43), new PVector(215, 62.42), "", transparent_color);
  btn_1.canHover = false;
  btn_1.Draw();

  Button btn_2 = new Button(new PVector(100, 392.12 + 43), new PVector(215, 62.42), "", transparent_color);
  btn_2.canHover = false;
  btn_2.Draw();

  Button btn_3 = new Button(new PVector(100, 545.12 + 43), new PVector(215, 62.42), "", transparent_color);
  btn_3.canHover = false;
  btn_3.Draw();

  String[] editPage = {"firstPageActive", "artistiActive"};
  HomeBar(editPage);

  if(!firstTime)
  {
    if (btn_1.OnClicked())
    {
      pageList.put("artistiActive", 0);
      pageList.put("artistaInfoPageActive", 1);
      firstTime = true;
      return "fame";
    }
    if (btn_2.OnClicked())
    {
      pageList.put("artistiActive", 0);
      pageList.put("artistaInfoPageActive", 1);
      firstTime = true;
      return "mangia";
    }
    if (btn_3.OnClicked())
    {
      pageList.put("artistiActive", 0);
      pageList.put("artistaInfoPageActive", 1);
      firstTime = true;
      return "gusta";
    }
  }
  return "";
}


void BigliettoPage()
{
  TemporizationPage();
  fill(255);
  rect(10, 60, width - 20, height - 160, 30);
  
  fill(bg_color);
  circle(10, height - 240, 60);
  circle(width - 10, height - 240, 60);

  //Intero
  fill(255);
  stroke(2);
  rect(firstBtnX, firstBtnY,firstBtnW, firstBtnH);

  fill(0);
  text(str(ticketCounterAdult) + " Intero", firstBtnX + firstBtnW / 2, firstBtnY + firstBtnH / 2 - 1);
  
  image(img_plus, firstBtnX + firstBtnW - 20, firstBtnY + firstBtnH/2 - 2 , 10, 10);
  image(img_minus, firstBtnX + 10, firstBtnY + firstBtnH/2 - 2 , 10, 10);
  //btn_plus
  if(btn_plus.OnClicked())
  {
    ticketCounterAdult ++;
  }
  if(btn_minus.OnClicked())
  {
    if(ticketCounterAdult - 1 >= 0)
    {
      ticketCounterAdult --;
    }
  }

  //Ridotto
  fill(255);
  stroke(2);
  int newFirsBtnX = firstBtnX + firstBtnW + 20; 
  rect(newFirsBtnX, firstBtnY,firstBtnW, firstBtnH);
  
  fill(0);
  text(str(ticketCounterHalf) + " Ridotto", newFirsBtnX + firstBtnW / 2, firstBtnY + firstBtnH / 2 - 1);
  
  image(img_plus, newFirsBtnX + firstBtnW - 20, firstBtnY + firstBtnH/2 - 2 , 10, 10);
  image(img_minus, newFirsBtnX + 10, firstBtnY + firstBtnH/2 - 2 , 10, 10);
  
  if(btn_plus2.OnClicked())
  {
    ticketCounterHalf ++;
  }
  if(btn_minus2.OnClicked())
  {
    if(ticketCounterHalf - 1 >= 0)
    {
      ticketCounterHalf --;
    }
  }
  
  // Total Rectangle
  int rectX = 100;
  int rectY = 490;
  int rectW = 180;
  int rectH = 50;
  noStroke();
  fill(button_color);
  rect(rectX, rectY,rectW, rectH);
  int numberOfTicket = ticketCounterAdult + ticketCounterHalf + ticketCounterFree;
  int totalPrice = ticketCounterAdult * 10 + ticketCounterHalf * 5;
  String ticketLabel = "Biglietto";

  if (numberOfTicket > 1 || numberOfTicket == 0)
  {
    ticketLabel = "Biglietti";
  }

  fill(0);
  text(str(numberOfTicket) + " " + ticketLabel + " € " + str(totalPrice), rectX + rectW / 2, rectY + rectH / 2 - 1);

  //Line
  stroke(0);
  for(int i = 0; i < 30; i++)
  {
    float size = width - 100;
    float distanceDraw = size / 30;
    if(i%2==0)
    {
      line(50 + distanceDraw*i, height - 240,50 + distanceDraw*i + distanceDraw, height - 240);
    }
  }

  image(img_barcode, 40, height - 210, width - 90, 80);

  String[] editPage = {"firstPageActive", "bigliettoPageActive"};
  HomeBar(editPage);
}

void ArtistaInfoPage()
{
  TemporizationPage();
  println(artistSelected);
  switch (artistSelected) {
    case "fame" :
      println("FAME");
      image(img_fame, 0, 43);
      Button btn_3 = new Button(new PVector(100, 383.72 + 43), new PVector(215, 62.42), "", transparent_color);
      btn_3.canHover = false;
      btn_3.Draw();
      if(!firstTime)
      {
        if (btn_3.OnClicked())
        {
          pageList.put("artistaInfoPageActive", 0);
          pageList.put("pieroPageActive", 1);
          firstTime = true;
        }
      }
      break;
    case "mangia" :
      println("MANGIA");
      image(img_mangia, 0, 43);
      Button btn_1 = new Button(new PVector(100, 203.54 + 43), new PVector(215, 62.42), "", transparent_color);
      btn_1.canHover = false;
      btn_1.Draw();
      if(!firstTime)
      {
        if(btn_1.OnClicked())
        {
          pageList.put("artistaInfoPageActive", 0);
          pageList.put("wangPageActive", 1);
        }
      }
      break;
    case "gusta" :
      println("GUSTA");
      image(img_gusta, 0, 43);
      btn_1 = new Button(new PVector(100, 203.54 + 43), new PVector(215, 62.42), "", transparent_color);
      btn_1.canHover = false;
      btn_1.Draw();
      if(!firstTime)
      {      
        if(btn_1.OnClicked())
        {
          pageList.put("artistaInfoPageActive", 0);
          pageList.put("quevadoPageActive", 1);
        }
      }
      break;	
  }

  String[] editPage = {"artistiActive", "artistaInfoPageActive"};
  HomeBar(editPage);
}

void PieroPage()
{
  TemporizationPage();
  image(img_piero, 0, 43 + pieroY);
  image(img_piero_top, 0, 43);

  String[] editPage = {"artistaInfoPageActive", "pieroPageActive"};
  HomeBar(editPage);

}

void WangPage()
{
  TemporizationPage();
  image(img_wang, 0, 43 + wangY);
  image(img_wang_top, 0, 43);

  String[] editPage = {"artistaInfoPageActive", "wangPageActive"};
  HomeBar(editPage);
}

void QuevadoPage()
{
  image(img_quevado, 0, 43 + quevadoY);
  image(img_quevado_top, 0, 43);

  String[] editPage = {"artistaInfoPageActive", "quevadoPageActive"};
  HomeBar(editPage);
}

void MemorPage()
{
  TemporizationPage();
  if (memory == null)
  {
    memory = new Memory(0, 0, width, height - 70);    
  }  

  memory.Draw();

  String[] editPage = {"firstPageActive", "memoryPageActive"};
  HomeBar(editPage);
}

//EVENTO DRAW
void draw()
{
  if (!GetBoolFromHash("landingPageActive") || !GetBoolFromHash("intervisteInfoPageActive"))
  {
    background(bg_color);
  }

  if (GetBoolFromHash("landingPageActive"))
  {
    LandingPage();
  } else if (GetBoolFromHash("firstPageActive" ))
  {
    FirstPage();
  } else if (GetBoolFromHash("laMostraPageActive"))
  {
    LaMostraPage();
  } else if (GetBoolFromHash("artistiActive"))
  {
    artistSelected = ArtistiPage();
  } else if (GetBoolFromHash("artistaInfoPageActive"))
  {
    ArtistaInfoPage();
  }
  else if (GetBoolFromHash("bigliettoPageActive"))
  {
    BigliettoPage();
  }
  else if (GetBoolFromHash("pieroPageActive"))
  {
    PieroPage();
  }else if (GetBoolFromHash("wangPageActive"))
  {
    WangPage();
  }else if (GetBoolFromHash("quevadoPageActive"))
  {
    QuevadoPage();
  }else if  (GetBoolFromHash("memoryPageActive"))
  {
    MemorPage();
    return;
  }
  
  Sidebar();
}

void mousePressed()
{
  if(GetBoolFromHash("memoryPageActive"))
  {
    memory.MousePressed();
  }
}
