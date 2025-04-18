window.addEventListener("DOMContentLoaded", () => {

let quizData = []; 
let quiz_scores = []; // 각 문제 점수 저장

let count = 0; 
let num = 0; 
let time = 10; 
let interval; 
let gameOver = false; 

let tspan;
let qdiv;

let game_id;
let userId;
let record_time;
let game_score;

qdiv = document.querySelector(".question");
tspan = document.querySelector("#timeout");

document.getElementById("startGameBtn").addEventListener("click", () => {
  document.getElementById("startModal").style.display = "none";
  startGame(); 
});


document.getElementById("cancelGameBtn").addEventListener("click", () => {
  window.location.href = "selectquiz"; 
});


function startGame() {
fetch("/quiz/oxquiz", {
  method: "GET"
})
  .then(response => response.json())
  .then(data => {
    console.log("받은퀴즈데이터:", data);

    quizData = data.map(quiz => ({
      question: quiz.question,
      answer: quiz.answer,
	  quiz_score: quiz.quiz_score // 점수도 포함
    }));

	const uniqueQuizData = Array.from(
	  new Map(quizData.map(q => [q.question, q])).values()
	);

	for (let i = uniqueQuizData.length - 1; i > 0; i--) {
	  const j = Math.floor(Math.random() * (i + 1));
	  [uniqueQuizData[i], uniqueQuizData[j]] = [uniqueQuizData[j], uniqueQuizData[i]];
	}

	quizData = uniqueQuizData.slice(0, Math.min(10, uniqueQuizData.length));
		  
    if (quizData.length === 0) {
      alert("퀴즈 데이터가 없습니다!");
      qdiv.innerText = "문제가 없습니다.";
      gameOver = true;
      return;
    }

    showQuestion(0);
    startTimer();
  })
  .catch(error => {
    console.error("퀴즈 데이터 불러오기 실패: ", error);
  });
 }
function showQuestion(index) {
  if (index < quizData.length) {
    qdiv.innerText = quizData[index].question;
  } else {
    endGame();
  }
}

function startTimer() {
  clearInterval(interval);
  time = 10;
  tspan.innerText = time;

  interval = setInterval(() => {
    tspan.innerText = time--;
	if (time < 0) {
	  clearInterval(interval);

	  // 결과 메시지 출력
	  const resultEl = document.getElementById("result");
	  resultEl.textContent = "시간초과입니다!";
	  resultEl.style.color = "#ffc107"; 
	  resultEl.classList.add("timeout-animate");
	  count++;
	  setTimeout(() => {
		resultEl.classList.remove("timeout-animate");
		resultEl.textContent = "";
	    if (count < quizData.length) {
	      resultEl.textContent = "";
	      showQuestion(count);
	      startTimer();
	    } else {
	      endGame();
	    }
	  }, 800); 
	}
  }, 1000);
}

function submitScore(game_id, userId, record_time, game_score) {
  fetch("/quiz/startox", {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      game_id: game_id,
      userId: userId,
      record_time: record_time,
      game_score: game_score
    })
  })
    .then(response => {
      if (!response.ok) {
        throw new Error("서버 전송 실패");
      }
      return response.json();
    })
    .then(data => {
      console.log("서버 응답", data);
    })
    .catch(error => {
      console.error("에러:", error);
    });
}

function endGame() {
  alert("퀴즈 종료! 맞힌 개수: " + num);
  tspan.innerText = 0;
  qdiv.innerText = "퀴즈가 종료되었습니다.";
  clearInterval(interval);
  gameOver = true;

  game_id = 1;
  userId = document.querySelector("#userId")?.value;
  record_time = Date.now();

  // 점수 총합 계산
  game_score = quiz_scores.reduce((sum, score) => sum + score, 0);

  submitScore(game_id, userId, record_time, game_score);
}


function resetGame() {
	quiz_scores = [];

  count = 0;
  num = 0;
  gameOver = false;
  showQuestion(0);
  startTimer();
  document.getElementById("result").textContent = "";
  clearAnimation();
}

function checkAnswer(userInput) {
  clearAnimation();
  const currentQuiz = quizData[count];
  const isCorrect = currentQuiz.answer === userInput;

  const btn = userInput === "O" ? document.querySelector(".btn_O") : document.querySelector(".btn_X");
  btn.classList.add(isCorrect ? "correct-animate" : "incorrect-animate");

  document.getElementById("result").textContent = isCorrect ? "정답입니다!" : "틀렸습니다!";
  document.getElementById("result").style.color = isCorrect ? "#28a745" : "#dc3545";

  if (isCorrect) {
    num++;
    quiz_scores.push(currentQuiz.quiz_score); // 정답일 경우 해당 점수 추가
  } else {
    quiz_scores.push(0); // 오답일 경우 0점 추가
  }

  count++;

  setTimeout(() => {
    if (count < quizData.length) {
      showQuestion(count);
      startTimer();
      document.getElementById("result").textContent = "";
    } else {
      endGame();
    }
  }, 800);
}


function clearAnimation() {
  const qDiv = document.querySelector(".question");
  
  document.querySelector(".btn_O").classList.remove("correct-animate", "incorrect-animate");
  document.querySelector(".btn_X").classList.remove("correct-animate", "incorrect-animate");

  void qDiv.offsetWidth;
}

document.querySelector(".btn_O").addEventListener("click", () => checkAnswer("O"));
document.querySelector(".btn_X").addEventListener("click", () => checkAnswer("X"));

document.getElementById("restartBtn").addEventListener("click", () => {
  if (gameOver) {
    if (confirm("게임이 종료되었습니다. 다시 시작하시겠습니까?")) {
      resetGame();
    }
  } else {
    if (confirm("게임 도중입니다. 다시 시작하시겠습니까?")) {
      resetGame();
    }
  }
});

document.getElementById("exitBtn").addEventListener("click", () => {
  if (confirm("정말로 나가시겠습니까?")) {
    window.location.href = "selectquiz";
  }
});

});