import Buffer "mo:base/Buffer";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";


actor{

type Freedom = {
   cozaco : Text;
   kontakt : Text;
   oferta : Text;
   kapital : Text;
   cena : Text;

   };

type Debug = {
  log : Text;
  deb : Text;

};

var delay : Int = 420_000_000_000;
var meit : Int = 1;
var time = Time.now();
let offer = Buffer.Buffer<Freedom>(25);

offer.add({ cozaco = "kupie ICP za SER"; kontakt = "discord .b_a_s_i_c."; oferta = "hej od kupie icp jeżeli ktoś nie chce ja się nimi chetnie zajmę ;p"; kapital = "20 KILO SERA"; cena = "1 ICP za KILO SERA" });


public query func oferta_cek(marker: Nat) : async Freedom {


let result = offer.get(marker);
};

public query func test() : async Freedom {


let result = offer.get(0);
};


public func oferta_add(cozaco: Text, kontakt: Text, oferta: Text, kapital: Text, cena: Text,) : async Debug {
if (Text.size(cozaco) == 0 or Text.size(kontakt) == 0 or Text.size(oferta) == 0 or Text.size(kapital) == 0 or Text.size(cena) == 0) {
 return({log = "ER"; deb = "przynajmniej jedno pole jest puste"});
};
if (Text.size(cozaco) >= 70 or Text.size(kontakt) >= 100 or Text.size(oferta) >= 1000 or Text.size(kapital) >= 100 or Text.size(cena) >= 100) {
 return({log = "ER"; deb = "za dużo znaków w jednym polu : tytuł-max = 70 opis-max = 1000 kapitał/cena/kontakt-max = 100"});
};

time := Time.now();
if (time <= (meit + delay)) {
  return { log = "ER"; deb = "system antyspam nie pozwolił dodać wpisu : spróbuj dodać ofertę później" };
};




if (24 <= offer.size()){
let x = offer.remove(0);

};

offer.add({ cozaco = cozaco; kontakt = kontakt; oferta = oferta; kapital = kapital; cena = cena });
time := Time.now();
meit := time;

return({log = "OK"; deb = "oferta dodana"});
};
};
// tu kod się kończy 