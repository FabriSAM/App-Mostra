int rows = 2;         // Numero di righe
int cols = 4;         // Numero di colonne
int totalCards = rows * cols;
PImage[] images = new PImage[totalCards]; // Array per tutte le immagini (ogni carta avrà la sua immagine unica)
int[] cards = new int[totalCards];        // Array che tiene traccia delle coppie di carte
boolean[] flipped = new boolean[totalCards]; // Stato delle carte girate
int cardWidth, cardHeight;
int firstCard = -1;   // Prima carta selezionata
int secondCard = -1;  // Seconda carta selezionata
boolean canFlip = true; // Controllo per girare le carte
int flipDelay = 1000;  // Tempo di attesa (in millisecondi) per ricoprire le carte
int lastFlipTime = 0;  // Ultimo momento in cui le carte sono state girate

void setup() {
  size(400, 400);
  cardWidth = width / cols;
  cardHeight = height / rows;
  
  // Carica le immagini da file (devi avere image0.png, image1.png, ..., image7.png)
  for (int i = 0; i < images.length; i++) {
    images[i] = loadImage("Assets/memory/img_" + i + ".png"); // Assumi di avere image0.png, image1.png, ..., image15.png
  }
  
  // Inizializziamo l'array delle carte. Le carte saranno abbinate per immagine e la successiva nell'array.
  for (int i = 0; i < totalCards; i++) {
    cards[i] = i; // Ogni carta ha un indice unico che corrisponde all'immagine
  }

  // Mescoliamo le carte in modo che le posizioni siano casuali
  shuffle(cards);
}

void draw() {
  background(255);
  
  // Disegniamo le carte
  for (int i = 0; i < totalCards; i++) {
    int x = (i % cols) * cardWidth;
    int y = (i / cols) * cardHeight;
    
    // Se la carta è scoperta, mostra l'immagine, altrimenti la copri
    if (flipped[i] || i == firstCard || i == secondCard) {
      fill(200);
      rect(x, y, cardWidth, cardHeight);
      imageMode(CENTER);
      image(images[cards[i]], x + cardWidth / 2, y + cardHeight / 2, cardWidth - 10, cardHeight - 10);
    } else {
      fill(100);
      rect(x, y, cardWidth, cardHeight);
    }
  }
  
  // Se sono state selezionate due carte e il tempo di attesa è scaduto, ricopriamo le carte
  if (firstCard != -1 && secondCard != -1 && millis() - lastFlipTime > flipDelay) {
    // Verifichiamo se le due carte corrispondono. Per farlo, verifichiamo se sono coppie consecutive.
    if (abs(cards[firstCard] - cards[secondCard]) != 1 || min(cards[firstCard], cards[secondCard]) % 2 != 0) {
      // Se le carte non corrispondono (non sono una coppia di immagini correlate), le ricopriamo
      firstCard = -1;
      secondCard = -1;
    } else {
      // Se sono una coppia, manteniamo le carte scoperte
      flipped[firstCard] = true;
      flipped[secondCard] = true;
      firstCard = -1;
      secondCard = -1;
    }
    canFlip = true;  // Ora possiamo permettere di girare altre carte
  }
}

void mousePressed() {
  if (canFlip) {
    int x = mouseX / cardWidth;
    int y = mouseY / cardHeight;
    int clickedCard = x + y * cols;
    
    // Se la carta cliccata non è già girata
    if (!flipped[clickedCard] && clickedCard != firstCard) {
      if (firstCard == -1) {
        firstCard = clickedCard;  // Prima carta selezionata
      } else if (secondCard == -1) {
        secondCard = clickedCard; // Seconda carta selezionata
        lastFlipTime = millis();  // Iniziamo il timer per il ritardo
        canFlip = false;          // Disabilitiamo ulteriori click finché non controlliamo
      }
    }
  }
}

// Funzione per mescolare l'array delle carte
void shuffle(int[] array) {
  for (int i = array.length - 1; i > 0; i--) {
    int index = int(random(i + 1));
    int temp = array[i];
    array[i] = array[index];
    array[index] = temp;
  }
}
