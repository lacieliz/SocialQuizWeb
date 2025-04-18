// script_wordgame.js

var div_def = document.querySelector("div[name='definition']");
var num = 0;
var user_input = document.querySelector("input[name='user_input']");
var view_word = null;
var check_word = null;
var pos = null;

user_input.addEventListener("keydown", (event) => {
  if (event.key == "Enter") {
    var str = user_input.value;
    if (num > 0) {
      if (view_word.charAt(view_word.length - 1) != str.charAt(0))
        alert("틀렸습니다!");
      else {
        check(user_input.value);
      }
    } else if (user_input.value != null) {
      check(user_input.value);
    }

    user_input.value = "";
  }
});

let total = null;
let def = null;

function showUserInput(word) {
  var show_word = document.querySelector("input[name='show_word']");
  show_word.value = word;
  num++;
}

function check(word) {
  var url = 'https://krdict.korean.go.kr/api/search?key=';
  var queryParams = '3E3D8330155B7C1E8D840B4414F32D93';
  queryParams += '&type_search=search&part=word&q=';
  queryParams += encodeURIComponent(word);

  fetch(url + queryParams)
    .then((data) => data.text())
    .then((text) => {
      total = text.slice(text.indexOf("<total>") + 7, text.indexOf("</total>"));
      check_word = text.slice(text.indexOf("<word>") + 6, text.indexOf("</word>"));
      def = text.slice(text.indexOf("<definition>") + 12, text.indexOf("</definition>"));
      pos = text.slice(text.indexOf("<pos>") + 5, text.indexOf("</pos>"));

      if (check_word == word && pos == "명사") {
        if (parseInt(total) > 0) {
          div_def.textContent = def + "\n";
          view_word = word;
          showUserInput(word);
        }
      } else {
        div_def.textContent = word + "는(은) 없는 단어 입니다.\n";
      }
    })
    .catch(error => {
      alert("오류");
    });
}
