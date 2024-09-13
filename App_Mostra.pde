import processing.video.*;
import java.util.Map;

// Interi

// Tempo tra una pressione del bottone e la successiva
int timer = 15;

int ticketCounterAdult;
int ticketCounterHalf;

// Risoluzione
int resX = 416;
int resY = 900;

// Barra superiore
int top_size = 23;

// Float

// Scorrimento delle pagine
float laMostraY = 0;
float pieroY = 0;
float wangY = 0;
float quevadoY = 0;

// Stringhe
String artistSelected = "";

// Colori
color sidebar_color = color(141, 141, 141, 255);
color rect_color = color(217, 217, 217, 255);
color button_color = color(192, 192, 192, 50);
color homebar_color = color(229, 227, 233, 255);
color bg_color = color(255, 255, 255, 255);
color transparent_color = color(255,255,255,0);

// Booleani

// Controllo della pressione del bottone
boolean firstTime = true;

// Dizionario < Stringa, Intero > per il controllo della pagina attualmente visualizzata
HashMap<String, Integer> pageList  = new HashMap<String, Integer>();

// Inizializzazione delle pagine
void InitPage()
{
  pageList.put("landingPageActive", 1);
  pageList.put("firstPageActive", 0);
  pageList.put("laMostraPageActive", 0);
  pageList.put("artistiActive", 0);
  pageList.put("artistaInfoPageActive", 0);
  pageList.put("intervisteInfoPageActive", 0);
  pageList.put("bigliettoPageActive", 0);
  pageList.put("pieroPageActive", 0);
  pageList.put("wangPageActive", 0);
  pageList.put("quevadoPageActive", 0);
  pageList.put("memoryPageActive", 0);
}

// Immagini
// Top Bar
PImage img_wifi, img_battery, img_lte, img_logo;

// Ticket
PImage img_barcode, img_plus, img_minus;

// Landing Page
PImage img_home;

// La Mostra
PImage img_mostra, img_mostra_top;

// Home Bar
PImage img_homebar;

// Artisti
PImage img_artisti, img_fame, img_mangia, img_gusta;

// Piero
PImage img_piero, img_piero_top;

// Wang
PImage img_wang, img_wang_top;

//Quevado
PImage img_quevado, img_quevado_top;

// Skip Intro
PImage img_skip_btn;

// Inizializzazione delle immagini
void InitImage()
{
  //Immagini
  //Assets/misc
  img_wifi = loadImage("Assets/misc/wifi.png");
  img_battery = loadImage("Assets/misc/battery.png");
  img_lte = loadImage("Assets/misc/lte.png");
  img_barcode = loadImage("Assets/misc/barcode.png");
  img_plus = loadImage("Assets/misc/plus.png");
  img_minus = loadImage("Assets/misc/minus.png");
  img_skip_btn = loadImage("Assets/misc/skip.png");
  img_logo = loadImage("Assets/misc/logo.png");

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
}

// Video
Movie introVideo;

// Memory
Memory memory;

void setup()
{
  size(416, 900);

  background(bg_color);

  InitPage();
  InitImage();
  
  //Video di Intro
  introVideo = new Movie(this, dataPath("Assets/video/intro.mp4").replace("\\data", ""));
}

//Event Methods
//NON RIMUOVERE QUESTO METODO
void movieEvent(Movie m) {
  m.read();
}

void mouseWheel(MouseEvent event) {

  float e = event.getCount();
  e *= -1;
  
  if (GetBoolFromHash("laMostraPageActive"))
  {
    laMostraY = constrain(laMostraY + e*10, ( resY - 100 ) - img_mostra.height, 0);
  } else if (GetBoolFromHash("pieroPageActive"))
  {
    pieroY = constrain(pieroY + e*10, ( resY - 300 ) - img_piero.height, 0);
  }else if (GetBoolFromHash("wangPageActive"))
  {
    wangY = constrain(wangY + e*10, ( resY - 100) - img_wang.height, 0);
  }else if (GetBoolFromHash("quevadoPageActive"))
  {
    quevadoY = constrain(quevadoY + e*10, ( resY - 100) - img_quevado.height, 0);
  }
}

void mousePressed()
{
  if(GetBoolFromHash("memoryPageActive"))
  {
    memory.MousePressed();
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

void TemporizationPage()
{
  if (timer < 0)
  {
    timer = 15;
    firstTime = false;
  }
  
  if (firstTime)
  {
    timer --;
  }
}

void HomeBar(String[] editPage)
{
  image(img_homebar, 0 , height - img_homebar.height);

  //Central button
  Button btn_backHome = new Button(new PVector(128.64 , height - img_homebar.height + 43), new PVector(45, 45), "", transparent_color);
  btn_backHome.canHovered = false;
  btn_backHome.Draw();

  //Left button
  Button btn_back = new Button(new PVector(80.60 , height - img_homebar.height + 43), new PVector(45, 45) ,"", transparent_color);
  btn_back.canHover = false;
  btn_back.Draw();

  Button btn_ticket = new Button(new PVector(200.12, height - img_homebar.height + 43), new PVector(45, 45), "", transparent_color);
  btn_ticket.canHover = false;
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

    if (btn_ticket.OnClicked())
    {
      pageList.put(editPage[1], 0);
      pageList.put("bigliettoPageActive", 1);
    }
  }
}

//Metodo Sidebar
void Sidebar()
{
  fill(sidebar_color);
  noStroke();

  rect(0, 0, width, top_size);

  fill(0);
  textAlign(CENTER, CENTER);
  textSize(17);
  text(nf(hour(), 2) + " : " + nf(minute() , 2), 30, top_size/2);

  // Incone stato telefono
  image(img_wifi, width-60, top_size/2-5, 12, 10);
  image(img_lte, width-40, top_size/2-5, 12, 10);
  image(img_battery, width-20, top_size/2-5, 12, 10);
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
// METODI PER LA VISUALIZZAZIONE DELLE PAGINE

// Pagina di arrivo
void LandingPage()
{
  introVideo.play();

  image(introVideo, 0, 44, width, height - 88);
  image(img_skip_btn, width-img_skip_btn.width, 750);

  Button btn_skip = new Button(new PVector(width-img_skip_btn.width, 750 + 43.85), new PVector(98.33, 28.43), "", transparent_color);
  btn_skip.canHover = false;
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

//Metodo Pagina 1
void FirstPage()
{
  image(img_home, 0, 0, resX, resY);
  
  Button btn_mostra = new Button(new PVector(width - 110.6 - 105.39, 287.69), new PVector(105.39, 62.54), "", transparent_color);
  Button btn_artisti = new Button(new PVector(108.75, 412.41), new PVector(105.39, 62.54), "", transparent_color);
  Button btn_memory = new Button(new PVector(width - 110.6 - 105.39, 532.21), new PVector(105.39, 62.54), "", transparent_color);
  Button btn_biglietti = new Button(new PVector(108.75, 656.33), new PVector(105.39, 62.54), "", transparent_color);

  btn_mostra.canHover = false;
  btn_artisti.canHover = false;
  btn_memory.canHover = false;
  btn_biglietti.canHover = false;

  btn_mostra.Draw();
  btn_artisti.Draw();
  btn_memory.Draw();
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

  if (btn_memory.OnClicked())
  {
    pageList.put("firstPageActive" ,0);
    pageList.put("memoryPageActive", 1);
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
  image(img_mostra, 0, top_size + laMostraY + img_mostra_top.height * 0.65);
  image(img_mostra_top, 0, top_size + laMostraY);

  String[] editPage = {"firstPageActive", "laMostraPageActive"};
  HomeBar(editPage);
}

//Metodo per visualizzare la pagina "GLI ARTISTI"
String ArtistiPage()
{
  TemporizationPage();
  image(img_artisti, 0, top_size);

  Button btn_1 = new Button(new PVector(100, 238.61 + top_size), new PVector(215, 62.42), "", transparent_color);
  btn_1.canHover = false;
  btn_1.Draw();

  Button btn_2 = new Button(new PVector(100, 392.12 + top_size), new PVector(215, 62.42), "", transparent_color);
  btn_2.canHover = false;
  btn_2.Draw();

  Button btn_3 = new Button(new PVector(100, 545.12 + top_size), new PVector(215, 62.42), "", transparent_color);
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

void ArtistaInfoPage()
{
  TemporizationPage();
  switch (artistSelected) {
    case "fame" :
      image(img_fame, 0, top_size);
      Button btn_3 = new Button(new PVector(100, 383.72 + top_size), new PVector(215, 62.42), "", transparent_color);
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
      image(img_mangia, 0, top_size);
      Button btn_1 = new Button(new PVector(100, 203.54 + top_size), new PVector(215, 62.42), "", transparent_color);
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
    case "gusta" :
      image(img_gusta, 0, top_size);
      btn_1 = new Button(new PVector(100, 203.54 + top_size), new PVector(215, 62.42), "", transparent_color);
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
  }

  String[] editPage = {"artistiActive", "artistaInfoPageActive"};
  HomeBar(editPage);
}

void BigliettoPage()
{
  TemporizationPage();

  image(img_logo, 0, top_size + 40);
  
  fill(homebar_color);
  circle(10, height - 240, 60);
  circle(width - 10, height - 240, 60);

  //Intero
  int firstBtnX = 50;
  int firstBtnY = 310;
  int firstBtnW = 130;
  int firstBtnH = 50;
  Button btn_plus = new Button(new PVector(firstBtnX + firstBtnW - 20, firstBtnY + firstBtnH/2 - 2), new PVector(10, 10), "", color(0,0,0,0));
  Button btn_minus = new Button(new PVector(firstBtnX + 10, firstBtnY + firstBtnH/2 - 2), new PVector(10, 10), "", color(0,0,0,0));

  fill(255);
  stroke(2);
  rect(firstBtnX, firstBtnY,firstBtnW, firstBtnH);

  fill(0);
  text(str(ticketCounterAdult) + " Intero", firstBtnX + firstBtnW / 2, firstBtnY + firstBtnH / 2 - 1);
  
  image(img_plus, firstBtnX + firstBtnW - 20, firstBtnY + firstBtnH/2 - 2 , 10, 10);
  image(img_minus, firstBtnX + 10, firstBtnY + firstBtnH/2 - 2 , 10, 10);
  //btn_plus
  if(!firstTime)
  {  
    if(btn_plus.OnClicked())
    {
      ticketCounterAdult ++;
      firstTime = true;
    }
    if(btn_minus.OnClicked())
    {
      if(ticketCounterAdult - 1 >= 0)
      {
        ticketCounterAdult --;
      }
      firstTime = true;
    }
  }

  //Ridotto

  float newFirsBtnX = width * 0.5 + 30; 
  Button btn_plus2 = new Button(new PVector(newFirsBtnX + firstBtnW - 20, firstBtnY + firstBtnH/2 - 2), new PVector(10, 10), "", sidebar_color);
  Button btn_minus2 = new Button(new PVector(newFirsBtnX + 10, firstBtnY + firstBtnH/2 - 2), new PVector(10, 10), "", sidebar_color);

  fill(255);
  stroke(2);
  rect(newFirsBtnX, firstBtnY,firstBtnW, firstBtnH);
  
  fill(0);
  text(str(ticketCounterHalf) + " Ridotto", newFirsBtnX + firstBtnW / 2, firstBtnY + firstBtnH / 2 - 1);
  
  image(img_plus, newFirsBtnX + firstBtnW - 20, firstBtnY + firstBtnH/2 - 2 , 10, 10);
  image(img_minus, newFirsBtnX + 10, firstBtnY + firstBtnH/2 - 2 , 10, 10);

  if(!firstTime)
  {  
    if(btn_plus2.OnClicked())
    {
      ticketCounterHalf ++;
      firstTime = true;
    }
    if(btn_minus2.OnClicked())
    {
      if(ticketCounterHalf - 1 >= 0)
      {
        ticketCounterHalf --;
      }
      firstTime = true;
    }
  }
  
  // Total Rectangle
  int rectW = 180;
  int rectH = 50;
  float rectX = width * 0.5 - rectW * 0.5;
  int rectY = 490;
  noStroke();
  fill(homebar_color);
  rect(rectX, rectY,rectW, rectH);
  int numberOfTicket = ticketCounterAdult + ticketCounterHalf;
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

void PieroPage()
{
  TemporizationPage();
  image(img_piero, 0, top_size + pieroY + img_piero_top.height * 0.65);
  image(img_piero_top, 0, top_size + pieroY);

  String[] editPage = {"artistaInfoPageActive", "pieroPageActive"};
  HomeBar(editPage);

}

void WangPage()
{
  TemporizationPage();
  image(img_wang, 0, top_size + wangY + img_wang_top.height * 0.65);
  image(img_wang_top, 0, top_size + wangY);

  String[] editPage = {"artistaInfoPageActive", "wangPageActive"};
  HomeBar(editPage);
}

void QuevadoPage()
{
  image(img_quevado, 0, top_size + quevadoY + img_quevado_top.height * 0.65);
  image(img_quevado_top, 0, top_size + quevadoY);

  String[] editPage = {"artistaInfoPageActive", "quevadoPageActive"};
  HomeBar(editPage);
}

void MemorPage()
{
  TemporizationPage();
  if (memory == null)
  {
    memory = new Memory(0, 0, width, height - img_homebar.height);    
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
