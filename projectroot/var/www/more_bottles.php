<?php

/*
Date:	08/07/05
Author:	caminoix
URL:	http://p2p.info.pl

this is from http://99-bottles-of-beer.net/language-php4-825.html
*/

/*
This script generates a series of HTML tables with cells in different colours. It is an utterly useless way to generate images on-the-fly.

It shows how comfortable PHP can be compared to raw HTML. This script is 5KB long compared to over 14MB (!) of HTML output.

If you like this script, I would be most grateful if you could visit http://p2p.info.pl/eng/index.php and click a Google ad ;)
*/

$letter["a"]=array(array(0,1,1,1,0),
		   array(1,0,0,0,1),
		   array(1,0,0,0,1),
		   array(1,1,1,1,1),
		   array(1,0,0,0,1));
$letter["b"]=array(array(1,1,1,1,0),
		   array(1,0,0,0,1),
		   array(1,1,1,1,0),
		   array(1,0,0,0,1),
		   array(1,1,1,1,0));
$letter["d"]=array(array(1,1,1,1,0),
		   array(1,0,0,0,1),
		   array(1,0,0,0,1),
		   array(1,0,0,0,1),
		   array(1,1,1,1,0));
$letter["e"]=array(array(1,1,1,1,1),
		   array(1,0,0,0,0),
		   array(1,1,1,1,0),
		   array(1,0,0,0,0),
		   array(1,1,1,1,1));
$letter["f"]=array(array(1,1,1,1,1),
		   array(1,0,0,0,0),
		   array(1,1,1,1,0),
		   array(1,0,0,0,0),
		   array(1,0,0,0,0));
$letter["g"]=array(array(0,1,1,1,1),
		   array(1,0,0,0,0),
		   array(1,0,1,1,1),
		   array(1,0,0,0,1),
		   array(0,1,1,1,0));
$letter["h"]=array(array(1,0,0,0,1),
		   array(1,0,0,0,1),
		   array(1,1,1,1,1),
		   array(1,0,0,0,1),
		   array(1,0,0,0,1));
$letter["i"]=array(array(0,1,1,1,0),
		   array(0,0,1,0,0),
		   array(0,0,1,0,0),
		   array(0,0,1,0,0),
		   array(0,1,1,1,0));
$letter["k"]=array(array(1,0,0,0,1),
		   array(1,0,0,1,0),
		   array(1,1,1,0,0),
		   array(1,0,0,1,0),
		   array(1,0,0,0,1));
$letter["l"]=array(array(1,0,0,0,0),
		   array(1,0,0,0,0),
		   array(1,0,0,0,0),
		   array(1,0,0,0,0),
		   array(1,1,1,1,1));
$letter["m"]=array(array(1,0,0,0,1),
		   array(1,1,0,1,1),
		   array(1,0,1,0,1),
		   array(1,0,0,0,1),
		   array(1,0,0,0,1));
$letter["n"]=array(array(1,0,0,0,1),
		   array(1,1,0,0,1),
		   array(1,0,1,0,1),
		   array(1,0,0,1,1),
		   array(1,0,0,0,1));
$letter["o"]=array(array(0,1,1,1,0),
		   array(1,0,0,0,1),
		   array(1,0,0,0,1),
		   array(1,0,0,0,1),
		   array(0,1,1,1,0));
$letter["p"]=array(array(1,1,1,1,0),
		   array(1,0,0,0,1),
		   array(1,0,0,0,1),
		   array(1,1,1,1,0),
		   array(1,0,0,0,0));
$letter["r"]=array(array(1,1,1,1,0),
		   array(1,0,0,0,1),
		   array(1,0,0,0,1),
		   array(1,1,1,1,0),
		   array(1,0,0,0,1));
$letter["s"]=array(array(0,1,1,1,1),
		   array(1,0,0,0,0),
		   array(0,1,1,1,0),
		   array(0,0,0,0,1),
		   array(1,1,1,1,0));
$letter["t"]=array(array(1,1,1,1,1),
		   array(0,0,1,0,0),
		   array(0,0,1,0,0),
		   array(0,0,1,0,0),
		   array(0,0,1,0,0));
$letter["u"]=array(array(1,0,0,0,1),
		   array(1,0,0,0,1),
		   array(1,0,0,0,1),
		   array(1,0,0,0,1),
		   array(0,1,1,1,0));
$letter["w"]=array(array(1,0,0,0,1),
		   array(1,0,0,0,1),
		   array(1,0,1,0,1),
		   array(1,1,0,1,1),
		   array(1,0,0,0,1));
$letter["y"]=array(array(1,0,0,0,1),
		   array(0,1,0,1,0),
		   array(0,0,1,0,0),
		   array(0,0,1,0,0),
		   array(0,0,1,0,0));
$letter["0"]=array(array(0,0,1,0,0),
		   array(0,1,0,1,0),
		   array(0,1,0,1,0),
		   array(0,1,0,1,0),
		   array(0,0,1,0,0));
$letter["1"]=array(array(0,0,1,0,0),
		   array(0,1,1,0,0),
		   array(0,0,1,0,0),
		   array(0,0,1,0,0),
		   array(0,0,1,0,0));
$letter["2"]=array(array(0,1,1,1,0),
		   array(1,0,0,1,1),
		   array(0,0,1,0,0),
		   array(0,1,0,0,0),
		   array(1,1,1,1,1));
$letter["3"]=array(array(1,1,1,1,0),
		   array(0,0,0,0,1),
		   array(0,1,1,1,0),
		   array(0,0,0,0,1),
		   array(1,1,1,1,0));
$letter["4"]=array(array(1,0,0,0,1),
		   array(1,0,0,0,1),
		   array(1,0,0,0,1),
		   array(1,1,1,1,1),
		   array(0,0,0,0,1));
$letter["5"]=array(array(1,1,1,1,1),
		   array(1,0,0,0,0),
		   array(1,1,1,1,0),
		   array(0,0,0,0,1),
		   array(1,1,1,1,0));
$letter["6"]=array(array(0,1,1,1,1),
		   array(1,0,0,0,0),
		   array(1,1,1,1,0),
		   array(1,0,0,0,1),
		   array(0,1,1,1,0));
$letter["7"]=array(array(1,1,1,1,1),
		   array(0,0,0,1,0),
		   array(0,0,1,0,0),
		   array(0,1,0,0,0),
		   array(1,0,0,0,0));
$letter["8"]=array(array(0,1,1,1,0),
		   array(1,0,0,0,1),
		   array(0,1,1,1,0),
		   array(1,0,0,0,1),
		   array(0,1,1,1,0));
$letter["9"]=array(array(0,1,1,1,0),
		   array(1,0,0,0,1),
		   array(0,1,1,1,1),
		   array(0,0,0,0,1),
		   array(0,1,1,1,0));
$letter[","]=array(array(0,0,0,0,0),
		   array(0,0,0,0,0),
		   array(0,0,0,0,0),
		   array(0,1,0,0,0),
		   array(1,0,0,0,0));
$letter["."]=array(array(0,0,0,0,0),
		   array(0,0,0,0,0),
		   array(0,0,0,0,0),
		   array(1,1,0,0,0),
		   array(1,1,0,0,0));
		   
function one_line($what_in_it){
	global $letter;
	echo "<table cellspacing=\"0\">";
	for ($y=0; $y<5; $y++){
		echo "<tr>";
		for ($i=0; $i<strlen($what_in_it); $i++){
			for ($x=0; $x<5; $x++){
				if ($letter[$what_in_it[$i]][$y][$x]==1)
					$colour="#000000";
					else
					$colour="#ffffff";
				echo "<td style=\"background-color:$colour\">";
				echo "</td>";
			}
			echo "<td style=\"background-color:#ffffff\"></td>";
		}
		echo "</tr>";
	}
	echo "<tr><td></td></tr>";
	echo "</table>";
}

for ($i=99; $i>0; $i--){
	$i==1 ? $s="" : $s="s";
	$i==1 ? $no="no more" : $no=$i-1;
	one_line("$i bottle$s of beer on the wall, $i bottle$s of beer.");
	one_line("take one down and pass it around, $no bottles of beer on the wall.");
	one_line(" ");
}
one_line("no more bottles of beer on the wall, no more bottles of beer.");
one_line("go to the store and buy some more, 99 bottles of beer on the wall.");
?>
