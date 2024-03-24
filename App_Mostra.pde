import processing.video.*;

String[] artistList;
String[] interviewList;
ArrayList<Movie> interview;

int[] indexMem;

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
boolean landingPageActive = true;
boolean firstPageActive = false;
boolean laMostraPageActive = false;
boolean artistiActive = false;
boolean artistaInfoPageActive = false;
boolean intervisteActive = false;
boolean intervisteInfoPageActive = false;
boolean firstTime = true;
boolean bigliettoPageActive = false;

// Immagini
PImage img_wifi;
PImage img_battery;
PImage img_lte;
PImage img_backHome;
PImage img_barcode;
PImage img_plus;
PImage img_minus;
PImage img_home;

//Bottoni
Button btn_skip;
Button btn_mostra;
Button btn_artisti;
Button btn_interviste;
Button btn_biglietti;
Button btn_backHome;
Button btn_plus;
Button btn_minus;
Button btn_plus2;
Button btn_minus2;
//Video
Movie introVideo;
Movie intervistaVideo;

void setup()
{
  size(416, 900);
  //fullScreen();
  background(bg_color);
  
  //Leggo i file di testo e creo degli Array per lavorare con gli elementi
  artistList = loadStrings("Testi/list_artisti.txt");
  interviewList = loadStrings("Testi/list_interview.txt");
  
  //Istanzio l'ArrayList di elementi
  interview = new ArrayList<Movie>();
  
  //Creo e assegno i video e la lista degli attori intervistati
  for(int i = 0; i< interviewList.length; i++)
  {
    String[] temp = split(interviewList[i], '=');
    
    interviewList[i] = temp[0];
    Movie tempMovie = new Movie(this,  dataPath(temp[1]).replace("\\data", ""));
    interview.add(tempMovie);
  }
  
  // Istanzio L'Array di controllo per lo scorrimento
  indexMem = new int[3];
  indexMem[0] = 0;
  indexMem[1] = 1;
  indexMem[2] = 2;
  
  //Immagini
  img_home = loadImage("Assets/home.png");
  img_wifi = loadImage("Assets/wifi.png");
  img_battery = loadImage("Assets/battery.png");
  img_lte = loadImage("Assets/lte.png");
  img_backHome = loadImage("Assets/back.png");
  img_barcode = loadImage("Assets/barcode.png");
  img_plus = loadImage("Assets/plus.png");
  img_minus = loadImage("Assets/minus.png");

  //Bottoni
  btn_skip = new Button(new PVector(300, 650), new PVector(30, 30), "", button_color);
  btn_mostra = new Button(new PVector(206, 273), new PVector(101, 60), "", transparent_color);
  btn_artisti = new Button(new PVector(120, 389), new PVector(101, 60), "", transparent_color);
  btn_interviste = new Button(new PVector(1920,1080), new PVector(101, 60), "INTERVISTE", button_color);
  btn_biglietti = new Button(new PVector(120, 620), new PVector(101, 60), "", transparent_color);
  btn_plus = new Button(new PVector(firstBtnX + firstBtnW - 20, firstBtnY + firstBtnH/2 - 2), new PVector(10, 10), "", color(0,0,0,0));
  btn_minus = new Button(new PVector(firstBtnX + 10, firstBtnY + firstBtnH/2 - 2), new PVector(10, 10), "", color(0,0,0,0));
  btn_plus2 = new Button(new PVector(firstBtnX + firstBtnW + 20 + firstBtnW - 20, firstBtnY + firstBtnH/2 - 2), new PVector(10, 10), "", color(0,0,0,0));
  btn_minus2 = new Button(new PVector(firstBtnX + firstBtnW + 20 + 10, firstBtnY + firstBtnH/2 - 2), new PVector(10, 10), "", color(0,0,0,0));
  
  //Video di Intro
  println(dataPath("Assets/first_video.mp4").replace("\\data", ""));
  introVideo = new Movie(this, dataPath("Assets/first_video.mp4").replace("\\data", ""));
}

//Event Methods
//NON RIMUOVERE QUESTO METODO
void movieEvent(Movie m) {
  m.read();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  
  println(arrayCount);
  //Se la rotellina aumenta il valore (Scorre Verso Il Basso)
  if (e > 0) {
    //Lista di Controlli per verificare se esce all'esterno dell'indice dell'arrai artistList
    if (indexMem[0] + 1 >= arrayCount)
    {
      indexMem[0] = 0;
    } else
    {
      indexMem[0] += 1;
    }

    if (indexMem[1] + 1 >= arrayCount)
    {
      indexMem[1] = 0;
    } else
    {
      indexMem[1] += 1;
    }

    if (indexMem[2] + 1 >= arrayCount)
    {
      indexMem[2] = 0;
    } else
    {
      indexMem[2] += 1;
    }
  }
  // Se la rotellina diminuisce il valore (Scorre Verso L'Alto)
  else {
    //Lista di Controlli per verificare se esce all'esterno dell'indice dell'arrai artistList
    if (indexMem[0] - 1 < 0)
    {
      indexMem[0] = arrayCount-1;
    } else
    {
      indexMem[0] -= 1;
    }
    if (indexMem[1] - 1 < 0)
    {
      indexMem[1] = arrayCount-1;
    } else
    {
      indexMem[1] -= 1;
    }

    if (indexMem[2] - 1 < 0)
    {
      indexMem[2] = arrayCount-1;
    } else
    {
      indexMem[2] -= 1;
    }
  }
}

//Utility Methods

//Istanziare un testo da un file di Testo
String SetupString(String path)
{
  String[] descript = loadStrings(path);
  String composeText = "";

  for (int i = 0; i < descript.length; i++)
  {
    composeText += descript[i] + "\n";
  }

  return composeText;
}

//Disegno del rettangolo inferiore
void DrawLowRectangle()
{
  noStroke();
  fill(rect_color);
  rect(0, 331, width, 437);
}

Button DrawBackHomeButton(int x, int y)
{
  image(img_backHome, x, y, 30, 30 );
  Button btn_backHomeTemp = new Button(new PVector(x, y), new PVector(30, 30), "", color(255, 255, 255, 0));
  btn_backHomeTemp.canHovered = false;
  btn_backHomeTemp.Draw();
  return btn_backHomeTemp;
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

//Metodo Sidebar
void Sidebar()
{
  if (!landingPageActive || !intervisteInfoPageActive)
  {
    background(bg_color);
  }

  fill(sidebar_color);
  noStroke();

  rect(0, 0, width, 43);
  rect(0, height - 44, width, 44);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(17);
  text(hour() + " : " + minute(), 30, 44/2);

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
  if (landingPageActive)
  {
    introVideo.stop();
    landingPageActive = false;
    firstPageActive = true;  
  }
  else if (intervisteInfoPageActive)
  {
    intervisteInfoPageActive = false;
    intervisteActive = true;
    intervistaVideo.stop();
  }
}

//Metodo Pagina 1
void FirstPage()
{
 
  //DrawLowRectangle();
  image(img_home, 0, 0, resX, resY);
  
  btn_mostra.Draw();
  btn_artisti.Draw();
  btn_interviste.Draw();
  btn_biglietti.Draw();
  
  if (btn_mostra.OnClicked())
  {
    laMostraPageActive = true;
    firstPageActive = false;
  }

  if (btn_artisti.OnClicked())
  {
    firstPageActive = false;
    artistiActive = true;
  }
  
  if (btn_interviste.OnClicked())
  {
    intervisteActive = true;
    firstPageActive = false;
  }

  if (btn_biglietti.OnClicked())
  {
    firstPageActive = false;
    bigliettoPageActive = true;
  }  
}

//Metodo per visualizzare la pagina "LA MOSTRA"
void LaMostraPage()
{
  DrawLowRectangle();

  String title = "LA MOSTRA";
  String description = SetupString("Testi/la_mostra.txt");

  DrawTextLayer(width/2, 80, title, 40, color(0, 0, 0, 255), 150, CENTER, CENTER);
  btn_backHome = DrawBackHomeButton(40, 73);
  DrawTextLayer(20, 340, description, 20, color(0, 0, 0, 255), 0, LEFT, TOP);

  if (btn_backHome.OnClicked())
  {
    laMostraPageActive = false;
    firstPageActive = true;
  }
}

//Metodo per visualizzare la pagina "GLI ARTISTI"
String ArtistiPage()
{
  arrayCount = artistList.length;
  String title = "GLI ARTISTI";
  DrawLowRectangle();

  DrawTextLayer(width/2, 80, title, 40, color(0, 0, 0, 255), 150, CENTER, CENTER);
  btn_backHome = DrawBackHomeButton(40, 73);

  Button btn_1 = new Button(new PVector(20, 360), new PVector(300, 100), artistList[indexMem[0]], button_color);
  Button btn_2 = new Button(new PVector(20, 480), new PVector(300, 100), artistList[indexMem[1]], button_color);
  Button btn_3 = new Button(new PVector(20, 600), new PVector(300, 100), artistList[indexMem[2]], button_color);

  btn_1.Draw();
  btn_2.Draw();
  btn_3.Draw();

  TemporizationPage();

  if(!firstTime)
  {
    if (btn_backHome.OnClicked())
    {
      artistiActive = false;
      firstPageActive = true;
      firstTime = true;
    }

    if (btn_1.OnClicked())
    {
      artistiActive = false;
      artistaInfoPageActive = true;
      firstTime = true;
      return btn_1.title;
    }
    if (btn_2.OnClicked())
    {
      artistiActive = false;
      artistaInfoPageActive = true;
      firstTime = true;
      return btn_2.title;
    }
    if (btn_3.OnClicked())
    {
      artistiActive = false;
      artistaInfoPageActive = true;
      firstTime = true;
      return btn_3.title;
    }
  }
  return "";
}

void ArtistaInfoPage()
{
  String text = SetupString("Artisti/"+artistSelected+".txt");
  DrawLowRectangle();

  DrawTextLayer(width/2, 80, artistSelected, 40, color(0, 0, 0, 255), 150, CENTER, CENTER);
  btn_backHome = DrawBackHomeButton(40, 73);
  DrawTextLayer(20, 340, text, 20, color(0, 0, 0, 255), 0, LEFT, TOP);

  if (btn_backHome.OnClicked())
  {
    artistiActive = true;
    artistaInfoPageActive =false;
  }
}

String IntervistePage()
{
  arrayCount = interviewList.length;
  String title = "LE INTERVISTE";
  DrawLowRectangle();

  DrawTextLayer(width/2, 80, title, 40, color(0, 0, 0, 255), 150, CENTER, CENTER);
  btn_backHome = DrawBackHomeButton(40, 73);

  Button btn_1 = new Button(new PVector(20, 360), new PVector(300, 100), interviewList[indexMem[0]], button_color);
  Button btn_2 = new Button(new PVector(20, 480), new PVector(300, 100), interviewList[indexMem[1]], button_color);
  Button btn_3 = new Button(new PVector(20, 600), new PVector(300, 100), interviewList[indexMem[2]], button_color);

  btn_1.Draw();
  btn_2.Draw();
  btn_3.Draw();
  
  TemporizationPage();
  if(!firstTime)
  {
    if (btn_backHome.OnClicked())
    {
      intervisteActive = false;
      firstPageActive = true;
      firstTime = true;
    }

    if (btn_1.OnClicked())
    {
      intervisteActive = false;
      intervisteInfoPageActive = true;
      firstTime = true;
      interviewIndex = indexMem[0];
      return btn_1.title;
    }
    if (btn_2.OnClicked())
    {
      intervisteActive = false;
      intervisteInfoPageActive = true;
      firstTime = true;
      interviewIndex = indexMem[1];
      return btn_2.title;
    }
    if (btn_3.OnClicked())
    {
      intervisteActive = false;
      intervisteInfoPageActive = true;
      firstTime = true;
      interviewIndex = indexMem[2];
      return btn_3.title;
    }
  }
  
  return "";
}

void IntervisteInfoPage()
{
  intervistaVideo = interview.get(interviewIndex);
  intervistaVideo.play();
  image(intervistaVideo, 0, 44, width, height - 88);
}

void BigliettoPage()
{
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
}
//EVENTO DRAW
void draw()
{
  Sidebar();

  if (landingPageActive)
  {
    LandingPage();
  } else if (firstPageActive)
  {
    FirstPage();
  } else if (laMostraPageActive)
  {
    LaMostraPage();
  } else if (artistiActive)
  {
    artistSelected = ArtistiPage();
  } else if (artistaInfoPageActive)
  {
    ArtistaInfoPage();
  } else if (intervisteActive)
  {
    interviewSelected = IntervistePage();
  }
  else if (intervisteInfoPageActive)
  {
    IntervisteInfoPage();
  }
  else if (bigliettoPageActive)
  {
    BigliettoPage();
  }
}
