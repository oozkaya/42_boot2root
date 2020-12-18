#!/bin/bash

output="turtle.decoded"

echo "import turtle" > $output
echo "t = turtle.Turtle()" >> $output
echo "" >> $output
cat turtle >> $output

sed -i 's/Tourne gauche de /t.left(/' $output
sed -i 's/Tourne droite de /t.right(/' $output
sed -i 's/Avance /t.forward(/' $output
sed -i 's/Recule /t.backward(/' $output
sed -i 's/ degrees/)/' $output
sed -i 's/ spaces/)/' $output

sed -i 's/Can you digest the message? :)//' $output

echo "Done!"
echo "Can you digest the message? :)"
