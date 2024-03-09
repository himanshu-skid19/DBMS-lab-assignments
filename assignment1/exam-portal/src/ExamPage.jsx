import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './ExamPage.css';

function ExamPage() {
  const [currentQuestion, setCurrentQuestion] = useState(null);
  const [selectedOption, setSelectedOption] = useState(null);
  const [answeredQuestionsCount, setAnsweredQuestionsCount] = useState(0);
  const [timer, setTimer] = useState(3600);

  useEffect(() => {
    fetchNextQuestion();
  }, []);

  useEffect(() => {
    if (answeredQuestionsCount >= 10) {
      submitExam();
    }
  }, [answeredQuestionsCount]);


  useEffect(() => {
    const interval = setInterval(() => {
      setTimer((prevTimer) => {
        if (prevTimer <= 1) {
          clearInterval(interval);
          submitExam();
          return 0;
        }
        return prevTimer - 1;
      });
    }, 1000);

    return () => clearInterval(interval);
  }, []);

  const fetchNextQuestion = (previousQuestionAnsweredCorrectly = null) => {
    let url = 'http://localhost:3001/get-exam-questions';
    if (previousQuestionAnsweredCorrectly !== null) {
      url += `?previousQuestionAnsweredCorrectly=${previousQuestionAnsweredCorrectly}`;
    }

    axios.get(url, { withCredentials: true })
      .then(response => {
        if (response.data.status === 'success') {
          const questionData = response.data.data;
          // Parse qoptions JSON string to an array
          questionData.qoptions = JSON.parse(questionData.qoptions);
          setCurrentQuestion(questionData);
          setSelectedOption(null); // Reset selected option for new question
        }
      })
      .catch(error => console.error('Fetching questions failed', error));
  };

  const handleOptionChange = (optionId) => {
    setSelectedOption(optionId);
  };

  const submitAnswer = () => {
    const isCorrect = selectedOption === currentQuestion.correct_option_id;
    setAnsweredQuestionsCount(answeredQuestionsCount + 1);
    if (answeredQuestionsCount < 9) {
      fetchNextQuestion(isCorrect);
    }
  };

  const submitExam = () => {
    console.log("Exam submitted successfully.");
    alert("The exam has been submitted!");
  };

  const renderTimer = () => {
    const hours = Math.floor(timer / 3600);
    const minutes = Math.floor((timer % 3600) / 60);
    const seconds = timer % 60;
    return `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
  };

  return (
    <div className="exam-page">
      <div className="timer">{renderTimer()}</div>
      {currentQuestion && (
        <div className="question-container">
          <h2>{currentQuestion.qcontent}</h2>
          <ul>
            {currentQuestion.qoptions.map((option) => (
              <li key={option.id}>
                <label>
                  <input
                    type="radio"
                    name="question-option"
                    checked={selectedOption === option.id}
                    onChange={() => handleOptionChange(option.id)}
                  />
                  {option.text}
                </label>
              </li>
            ))}
          </ul>
          <button onClick={submitAnswer}>Submit Answer</button>
        </div>
      )}
      {!currentQuestion && <p>Loading questions...</p>}
    </div>
  );
}

export default ExamPage;
