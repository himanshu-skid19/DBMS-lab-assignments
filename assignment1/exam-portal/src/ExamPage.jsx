import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './ExamPage.css'; // Ensure this path correctly points to your CSS file

function ExamPage() {
  const [questions, setQuestions] = useState([]);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [selectedOptions, setSelectedOptions] = useState({});
  const [timer, setTimer] = useState(0); // Example: 1 hour = 3600 seconds

  useEffect(() => {
    // Fetch questions and exam details
    axios.get('http://localhost:3001/get-exam-questions', { withCredentials: true })
      .then(response => {
        if (response.data.status === 'success') {
          setQuestions(response.data.data);
          // Initialize timer with the duration fetched from the backend
          const examDurationInSeconds = response.data.duration; // Convert minutes to seconds if duration is in minutes
          setTimer(examDurationInSeconds);
  
          const examEndTime = new Date().getTime() + examDurationInSeconds * 1000;
          const interval = setInterval(() => {
            const timeLeft = examEndTime - new Date().getTime();
            if (timeLeft <= 0) {
              clearInterval(interval);
              alert('Time is up!');
              submitExam(); // Auto-submit when time is up
            } else {
              setTimer(timeLeft / 1000); // Update timer every second
            }
          }, 1000);
  
          return () => clearInterval(interval);
        }
      })
      .catch(error => console.error('Fetching questions failed', error));
  }, []);

  const handleOptionChange = (questionId, optionIndex) => {
    setSelectedOptions({
      ...selectedOptions,
      [questionId]: optionIndex,
    });
  };

  const navigateQuestion = (index) => {
    setCurrentQuestionIndex(index);
  };

  const submitExam = () => {
    // Submit exam logic here
    console.log("Selected Options:", selectedOptions);
    // Example POST request with selected options
    axios.post('http://localhost:3001/submit-exam', { answers: selectedOptions }, { withCredentials: true })
      .then(response => {
        console.log("Exam submitted successfully:", response.data);
        // Handle successful submission (e.g., redirect to a result page or show a message)
      })
      .catch(error => console.error('Error submitting exam', error));
  };

  const renderTimer = () => {
    const hours = Math.floor(timer / 3600);
    const minutes = Math.floor((timer % 3600) / 60);
    const seconds = Math.round(timer % 60); // Use Math.round to avoid the long decimal
    return `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
  };

  return (
    <div className="exam-page">
      <aside className="question-sidebar">
        {questions.map((_, index) => (
          <button
            key={index}
            className={`question-number ${selectedOptions.hasOwnProperty(questions[index].qid) ? 'answered' : ''}`}
            onClick={() => navigateQuestion(index)}
          >
            {index + 1}
          </button>
        ))}
      </aside>

      <div className="exam-container">
        <div className="timer">{renderTimer()}</div>
        {questions.length > 0 && questions[currentQuestionIndex] ? (
          <div className="question-container">
            <h2>{questions[currentQuestionIndex].question}</h2>
            <ul>
              {questions[currentQuestionIndex].options && questions[currentQuestionIndex].options.map((option, index) => (
                <li key={index}>
                  <label>
                    <input
                      type="radio"
                      name={`question-${questions[currentQuestionIndex].qid}`}
                      checked={selectedOptions[questions[currentQuestionIndex].qid] === index}
                      onChange={() => handleOptionChange(questions[currentQuestionIndex].qid, index)}
                    />
                    {option}
                  </label>
                </li>
              ))}
            </ul>
            <div className="navigation-buttons">
              <button onClick={() => navigateQuestion(currentQuestionIndex - 1)} disabled={currentQuestionIndex === 0}>Previous</button>
              <button onClick={() => navigateQuestion(currentQuestionIndex + 1)} disabled={currentQuestionIndex === questions.length - 1}>Next</button>
            </div>
            <button className="submit-button" onClick={submitExam}>Submit Exam</button>
          </div>
        ) : (
          <p>Loading questions...</p>
        )}
      </div>
    </div>
  );
}

export default ExamPage;
