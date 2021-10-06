using GLib;
namespace Random {
    [Flags]
    enum RandomType {
        ROULETTE,
        COIN,
        NUMBER
    }
    class Func : Object {
        private Rand rand = new Rand ();
        public int? NumberString (string int1, string int2, bool return-number = true) {
            int numb1 = int.parse (int1);
            int numb2 = int.parse (int2) + 1;
            int random-number = rand.int_range (numb1, numb2);
            if (return-number) {
                return random-number;
            }
            return random-number.to_string ();
        }
        
        public int? Number (int numb, int numb2, bool return-number = true) {
            int random-number = rand.int_range (numb1, (numb2 + 1));
            if (return-number) {
                return random-number;
            }
            return random-number.to_string ();
        }
        
        public string Roulette (string list, string sep = /) {
            string[] texa = list.split (sep);
            string txt = texa[rand.int_range (0, texa.length)];
            return txt;
        }
        
        public string[] DeleteRoulette (string list, string sep = /) {
            string SpinnedRoulette = this.Roulette (list, sep);
        }
        
        public string Coin (string string1, string string2) {
            int hey = this.Number(0, 1, true);
            if (hey == 1) {
                return string2;
            }
            return string1;
        }
    }
}