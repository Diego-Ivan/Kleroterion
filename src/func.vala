using GLib;
namespace Random {
    enum RandomType {
        ROULETTE,
        DELETE_ROULETTE,
        COIN,
        NUMBER,
        STRING_NUMBER
    }
    class Func : Object {
        private Rand rand = new Rand ();
        
        public int? NumberString (string int1, string int2, bool return-number = true) 
        requires (int.parse (int1) < int.parse (int2)) 
        ensures (result <= int.parse (int2) && result >= int.parse (int1)) {
            int numb1 = int.parse (int1);
            int numb2 = int.parse (int2) + 1;
            int random-number = rand.int_range (numb1, numb2);
            if (return-number) {
                return random-number;
            }
            return random-number.to_string ();
        }
        
        public int? Number (int numb1, int numb2, bool return-number = true)
        requires (numb1 < numb2)
        ensures (result <= int2 && result >= int1) {
            int random-number = rand.int_range (numb1, (numb2 + 1));
            if (return-number) {
                return random-number;
            }
            return random-number.to_string ();
        }
        
        public string Roulette (string list, string sep = /)
        requires (string != "")
        ensures (result in list) {
            string[] texa = list.split (sep);
            string txt = texa[rand.int_range (0, texa.length)];
            return txt;
        }
        
        public string[] DeleteRoulette (string tex, string split = /)
        requires (string != "") 
        ensures (!(result in tex)) {
            string end = this.Roulette (list, sep);
            string[] texa = tex.split (split);
            string enda;
            for (int i = 0; i < texa.length; i++) {
                if (texa[i] == end) {
                    for (int k = i; k < texa.length - 1; k++) {
                        texa[k] = texa[k+1];
                        texa[k+1] = null;
                    }
                    break;
                }
            }
            if (texa.length == 1) {
                texa[0] = null;
                return { end, "" };
            }
            texa.resize (texa.length-1);
            enda = texa[0];
            for (int j = 1; j < texa.length; j++) {
                enda = enda + split + texa[j];
            }
            return { end, enda };
        }
        
        public string Coin (string string1 = "Heads", string string2 = "Tails")
        requires (string1 != string2)
        ensures (result == string1 && result == string2) {
            int hey = this.Number(0, 1, true);
            if (hey == 1) {
                return string2;
            }
            return string1;
        }
        
        public string? Randomize (Random.RandomType rande, ...) {
            string? res;
            switch (rande) {
                case Random.RandomType.COIN:
                    res = this.Coin (...);
                    break;
                case Random.RandomType.NUMBER:
                    res = this.Number (...);
                    break;
                case Random.RandomType.ROULETTE:
                    res = this.Roulette (...);
                    break;
                case Random.RandomType.DELETE_ROULETTE:
                    res = this.DeleteRoulette (...);
                    break;
                case Random.RandomType.STRING_NUMBER:
                    res = this.NumberString (...);
                    break;
                default:
                    res = null;
                    break;
            }
            return res;    
        }
    }
}