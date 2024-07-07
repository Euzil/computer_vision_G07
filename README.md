# Tour into the Picture

Computer Vision Challenge - SoSe 2024
Gruppe 07


## Das Ziel: 

Erstellen verschiedener Ansichten einer Szene aus einem einzigen Bild (Umwandlung eines zweidimensionalen Bildes in ein dreidimensionales).

## Anwendbare Version: 

Matlab 2023b Toolbox-Installation: Image Processing Toolbox

## Anweisungen zur Benutzung:

Um die 3-dimensionale Rekonstruktion zu vervollständigen:

"Ein Bild auswählen": Wählen Sie ein Bild für die Rekonstruktion. Das Programm akzeptiert nur Dateien im ".jpg"-, ".png"-oder ".jpeg"- Format.

"4 Eckpunkte udn 1 Fluchtpunkt definieren": Sie sollten einen Fluchtpunkt und vier Eckpunkte zum Einrahmen einer Ebene fur eine Homographie definieren. Sie können maximal 5 Punkte auswählen.

"Reset": Setzt alle von Ihnen gewählten Punkte zurück.

"START": Wenn Sie schon Bild auswählen und Punkte(4 Eckpunkte udn 1 Fluchtpunkt) richtig definieren, können Sie die Rekonstruktion starten.

## Einzelheiten:

Mit Hilfe der GUI kann der Benutzer ein Bild auswählen und dann das innere Rechteck und den Fluchtpunkt bestimmen. Das Programm berechnet die Ecken der fünf Ebenen und trägt sie auf dem Originalbild ein. Der Algorithmus verwendet diese Punkte, um eine Schätzung der projektiven Transformation für jede Ebene auf der Grundlage der Methode der ähnlichen Dreiecke zu berechnen. Auch die Tiefe der Bilder wird mit dieser Methode geschätzt. Dann werden die Ebenen beschnitten und die Transformation durchgeführt. Im letzten Schritt werden die Ebenen zu einer 3D-Box zusammengesetzt.

## Code Explanation:

1.Transform3D:

Dieser Code erzeugt eine interaktive 3D-Szene, in der die Szene mit dem Mausrad vergrößert und verkleinert werden kann und die Perspektive und Position mit der Tastatur gesteuert werden kann. Er zeigt, wie mehrere Texturbilder im 3D-Raum platziert werden können, um einen einfachen stereoskopischen Effekt zu erzeugen.

2.ProjectiveRectification:

Dieser Code implementiert eine komplexe Bildverarbeitungsfunktion, die hauptsächlich aus der Berechnung einer Projektionstransformationsmatrix, der Korrektur mehrerer Bilder für die Projektion und der Rückgabe des korrigierten Bildes und seiner geometrischen Parameter besteht. Diese Technik wird häufig verwendet, um mehrere Bilder (die in der Regel aus verschiedenen Winkeln oder von verschiedenen Orten aus aufgenommen wurden) zur weiteren Analyse oder zum Compositing auf dieselbe Ebene zu projizieren.

3.ImageCropping:

Dieser Code beschneidet ein Bild durch Multiplikation des Eingabebildes mit einer bestimmten polygonalen Bereichsmaske. Beim Zuschneiden werden nur die Pixel innerhalb des Polygons beibehalten und die anderen Pixel auf Null gesetzt, um ein zugeschnittenes Bild zu erhalten.

4.CalculatePointCoordinates:

Die Hauptfunktion dieses Codes besteht darin, die Koordinaten von acht Nicht-Kontrollpunkten im Bild zu berechnen, die für geometrische Operationen verwendet werden, basierend auf dem Eingabebild und den Positionen der Kontrollpunkte. Die Berechnung dieser Punkte hängt von der geometrischen Struktur des Bildes und den Positionsbeziehungen der Kontrollpunkte ab und kann für nachfolgende Bildtransformationen, Slicing oder andere geometrische Verarbeitungen verwendet werden.

## Sie können uns gerne Verbesserungsvorschläge zu unserem Code machen! :)
