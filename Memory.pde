class Memory
{
  int rows = 3;         // Numero di righe
  int cols = 2;         // Numero di colonne
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
  
  // Variabili per il riquadro
  int gridX, gridY;     // Coordinate di partenza del riquadro
  int gridWidth, gridHeight; // Larghezza e altezza del riquadro
  int padding = 10;     // Padding tra le carte

  Memory(int x, int y, int w, int h)
  {
    println("StartMemory");
    gridX = x;
    gridY = y;
    gridWidth = w;
    gridHeight = h;

    // Calcoliamo la larghezza e l'altezza delle carte considerando il padding
    cardWidth = (w - padding * (cols + 1)) / cols;
    cardHeight = (h - padding * (rows + 1)) / rows;

    // Carica le immagini da file
    for (int i = 0; i < images.length; i++) {
      images[i] = loadImage("Assets/memory/img_" + i + ".png");
    }
    
    // Inizializziamo l'array delle carte
    for (int i = 0; i < totalCards; i++) {
      cards[i] = i; // Ogni carta ha un indice unico che corrisponde all'immagine
    }

    // Mescoliamo le carte in modo che le posizioni siano casuali
    shuffle(cards);
  }

  void Draw() {
    println("Draw Memory");
    background(255);
    
    // Disegniamo le carte all'interno del riquadro
    for (int i = 0; i < totalCards; i++) {
      int x = gridX + padding + (i % cols) * (cardWidth + padding);
      int y = gridY + padding + (i / cols) * (cardHeight + padding);
      
      // Se la carta è scoperta, mostra l'immagine, altrimenti la copri
      if (flipped[i] || i == firstCard || i == secondCard) {
        fill(200);
        rect(x, y, cardWidth, cardHeight);
        imageMode(CENTER);  // Usato solo qui per disegnare le immagini centrali
        image(images[cards[i]], x + cardWidth / 2, y + cardHeight / 2, cardWidth - 10, cardHeight - 10);
        imageMode(CORNER);  // Ripristina la modalità predefinita subito dopo
      } else {
        fill(100);
        rect(x, y, cardWidth, cardHeight);
      }
    }
    
    // Se sono state selezionate due carte e il tempo di attesa è scaduto, ricopriamo le carte
    if (firstCard != -1 && secondCard != -1 && millis() - lastFlipTime > flipDelay) {
      if (abs(cards[firstCard] - cards[secondCard]) != 1 || min(cards[firstCard], cards[secondCard]) % 2 != 0) {
        firstCard = -1;
        secondCard = -1;
      } else {
        flipped[firstCard] = true;
        flipped[secondCard] = true;
        firstCard = -1;
        secondCard = -1;
      }
      canFlip = true;  // Ora possiamo permettere di girare altre carte
    }
  }

  void MousePressed() {
    // Controllo se il click avviene all'interno della griglia
    if (mouseX >= gridX && mouseX <= gridX + gridWidth && mouseY >= gridY && mouseY <= gridY + gridHeight) {
      if (canFlip) {
        int x = (mouseX - gridX - padding) / (cardWidth + padding); // Adattiamo le coordinate al padding
        int y = (mouseY - gridY - padding) / (cardHeight + padding);
        int clickedCard = x + y * cols;

        // Controllo che l'indice della carta sia valido
        if (clickedCard >= 0 && clickedCard < totalCards) {
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
}