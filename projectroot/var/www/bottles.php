<?php

/*
Date:	05/17/05
Author:	Kenneth Clark
URL:	n/a

this is from http://99-bottles-of-beer.net/language-php5-659.html
*/

class SingBeerWallSong{
    private $noBeers;
    private $output;
    private $outputType;
    public function __construct($noBeers, $type){
        $this->noBeers  = $noBeers;
        $this->type     = $type;
        
    }
    
    public function singSong(){
        for ($i = $this->noBeers; $i > 0; $i--){
            if ($i == 1) {
                $bottle = "bottle";
            }else{
                $bottle = "bottles";
            }
            $this->output .= $i . " ".$bottle." of beer on the wall \n";   
            $this->output .= $i . " ".$bottle." of beer \n";
            $this->output .= "And if 1 bottle of beer should fall,\n";
            if ($this->minusOne($i) == 1) {
                $bottle = "bottle";
            }else{
                $bottle = "bottles";
            }
            $this->output .= "There will be " . $this->minusOne($i) . " " . $bottle . " of beer on the wall \n\n";
        }
        if (strtolower($this->type) == "html") {
            $this->addBreak();
        }
    }
    
    private function addBreak(){
        $this->output   = str_replace("\n","<br>",$this->output);
    }
    private function minusOne($int){
        return $int - 1;
    }
    public function getOutput(){
        return $this->output;
    }
}

$oBeer  = new SingBeerWallSong(99,"html");
$oBeer->singSong();
echo $oBeer->getOutput();

?>
