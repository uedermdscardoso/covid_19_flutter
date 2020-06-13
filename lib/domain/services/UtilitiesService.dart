
class UtilitiesService {

  static String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  static String capitalizeAllWord(String name){
    List<String> aux = name.split(" ");
    for(int i=0; i<aux.length; i++)
      aux[i] = capitalize(aux[i]);
    return aux.join(" ");
  }

  static bool like({ String word, String search }){
    for(int i=0; i<search.length; i++){
        if(word[i].compareTo(search[i]) == 0){
          if(i == search.length-1)
            return true;
        } else
          return false;
    }
  }

}