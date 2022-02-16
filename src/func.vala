/*
 * Copyright 2021 <?xml>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using GLib;
namespace Random {
    class Func : Object {
        private Rand rand = new Rand ();
        
        public int NumberString (string int1, string int2) {
            int numb1 = int.parse (int1);
            int numb2 = int.parse (int2);
            if (numb1 > numb2) {
                return rand.int_range (numb2, (numb1 + 1));
            } else {
                return rand.int_range (numb1, (numb2 + 1));
            }
        }
        
        public int Number (int numb1, int numb2) {
            if (numb1 > numb2) {
                return rand.int_range (numb2, (numb1 + 1));
            } else {
                return rand.int_range (numb1, (numb2 + 1));
            }
        }
        
        public string Roulette (string list, string sep = "/") {
            string[] texa = list.split (sep);
            string txt = texa[rand.int_range (0, texa.length)];
            return txt;
        }
        
        public string[] DeleteRoulette (string tex, string split = "/") {
            string end = this.Roulette (tex, split);
            string[] texa = tex.split (split);
            string enda;
            for (int t = 0; t < texa.length; t++) {
                if (texa[t] == end) {
                    for (int k = t; k < texa.length - 1; k++) {
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
        
        public string Coin (string string1 = "Heads", string string2 = "Tails") {
            int hey = this.Number(0, 1);
            if (hey == 1) {
                return string2;
            }
            return string1;
        }
        
        public string NumberRoulette (int num1, int num2, string sep = "/") {
            string list = num1.to_string ();
            for (int i = num1 + 1; i <= num2; i++) {
                list = list + sep + i.to_string ();
            }
            return list;
        }
    }
}
