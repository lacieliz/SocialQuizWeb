

window.addEventListener("DOMContentLoaded", function () {
  const div_def = document.querySelector("div[name='definition']");
  const user_input = document.querySelector("input[name='user_input']");
  const show_word = document.querySelector("input[name='show_word']");
  const tspan = document.querySelector("#timeout"); // 남은 시간 표시할 span

  let num = 0;
  let view_word = null;
  let check_word = null;
  let pos = null;
  let interval;
  let time = 10;
  let gameOver = false;

  // 두음법칙 매핑 안돼 왜 안되는지 모르겟어
  const dooeumPairs = {
    "녀": "여", "뇨": "요", "뉴": "유", "니": "이", "력": "역",
    "례": "예", "랴": "야", "려": "여", "로": "노", "라": "나",
    "락": "낙", "란": "난", "량": "양", "렬": "열", "렴": "염",
    "렵": "엽", "령": "영", "뢰": "뇌", "루": "누", "류": "유",
    "륙": "육", "률": "율", "륜": "윤", "륭": "융", "리": "이",
	"람": "암",
  };

  const usedWords = [];

  user_input.addEventListener("keydown", (event) => {
    if (event.key === "Enter" && !gameOver) {
      const str = user_input.value.trim();

      if (str === "") return;

      if (str.length < 2) {
        alert("한글자는 입력이 불가능합니다!");
        user_input.value = "";
        return;
      }

      if (usedWords.includes(str)) {
        alert("이미 입력한 단어입니다!");
        user_input.value = "";
        return;
      }

      if (num > 0 && !isValidNextWord(view_word, str)) {
        alert("틀렸습니다!");
        user_input.value = "";
        return;
      }

      check(str);
      user_input.value = "";
    }
  });
  
  function isValidNextWord(prevWord, nextWord) {
    const lastChar = prevWord.charAt(prevWord.length - 1);
    const firstChar = nextWord.charAt(0);
    if (lastChar === firstChar) return true;
    for (const [wrong, correct] of Object.entries(dooeumPairs)) { // 권민정이 했음. 진짜 찐텐으로 
      if ((lastChar == correct && firstChar == wrong) ||			
          (lastChar == wrong && firstChar == correct)) {
        return true;
		
      }
    }
    return false;
  }

  function check(word) {
    const url = 'https://krdict.korean.go.kr/api/search?key=3E3D8330155B7C1E8D840B4414F32D93';
    const query = '&type_search=search&part=word&q=' + encodeURIComponent(word);

    fetch(url + query)
      .then((data) => data.text())
      .then((text) => {
        const total = text.slice(text.indexOf("<total>") + 7, text.indexOf("</total>"));
        check_word = text.slice(text.indexOf("<word>") + 6, text.indexOf("</word>"));
        const def = text.slice(text.indexOf("<definition>") + 12, text.indexOf("</definition>"));
        pos = text.slice(text.indexOf("<pos>") + 5, text.indexOf("</pos>"));

        if (check_word === word && pos === "명사") {
          if (parseInt(total) > 0) {
            div_def.textContent = def + "\n";
            view_word = word;
            showUserInput(word);
            resetTimer(); // 정답이면 타이머 리셋
          }
        } else {
          div_def.textContent = word + "는(은) 없는 단어입니다.\n";
        }
      })
      .catch(error => {
        alert("오류 발생: " + error);
      });
  }

  function showUserInput(word) {
    show_word.value = word;
    num++;
    usedWords.push(word);
    updateUsedWordsDisplay();
  }

  function updateUsedWordsDisplay() {
    const list = document.getElementById("usedWordsList");
    list.innerHTML = "";
    const recentWords = usedWords.slice(-20);
    recentWords.forEach((word) => {
      const li = document.createElement("li");
      li.textContent = word;
      list.appendChild(li);
    });
  }

  function resetTimer() {
    clearInterval(interval);
    time = 10;
    tspan.innerText = time;

    interval = setInterval(() => {
      tspan.innerText = time;
      time--;
      if (time < 0) {
        clearInterval(interval); 
        gameOver = true;
        alert("시간초과! 게임 종료!");
        div_def.textContent = "게임이 종료되었습니다.";
		user_input.value ="";
        user_input.disabled = true;
      }
    }, 1000);
  }

  // 게임 시작 시 타이머 시작
  resetTimer();
});


function restartGame() {
  if (confirm("게임을 다시 시작하시겠습니까?")) {
    location.reload();
  }
}

function exit() {	
	document.getElementById("exitBtn").addEventListener("click", () => {
	  if (confirm("정말로 나가시겠습니까?")) {
	    window.location.href = "selectquiz";
	  }
	});

}